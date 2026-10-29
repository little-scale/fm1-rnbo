#!/usr/bin/env python3
"""Review existing device outputs without Docker or writing to an FM-1."""
import hashlib
import json
import re
import struct
import sys
from pathlib import Path

APP = Path(__file__).resolve().parents[1]
OUT = APP / "build"
sys.path.insert(0, str(APP.parent / "tools"))
import fm1_install as installer
import fm1pkg_make as pkg


def require(condition, message):
    if not condition:
        raise SystemExit("Device review failed: " + message)


def main():
    raw = (OUT / "rnbo.fwsc").read_bytes()
    product, logical, digest = installer.load_package(OUT / "rnbo.fwsc", False)
    require(product == "FM-1_9300", "unexpected package identity")
    header = bytearray(logical[:64])
    pkg.enc(header, 0, len(header))
    hcrc, lcrc, total, count = struct.unpack_from("<HHIH", header)
    require(pkg.crc16(header[2:]) == hcrc, "UFW header CRC")
    require(total == len(logical) and count == 2, "UFW length/file count")
    entries = logical[64:64 + count * 80]
    require(pkg.crc16(entries) == lcrc, "UFW file-list CRC")
    files = {}
    for i in range(count):
        entry = bytearray(entries[i * 80:(i + 1) * 80])
        pkg.enc(entry, 0, len(entry))
        typ, index, crc, reserved, offset, length, padded = struct.unpack_from("<HHHHIII", entry)
        name = entry[64:].split(b"\0", 1)[0].decode()
        require(offset >= 64 + count * 80 and offset + length <= len(logical), "UFW file bounds")
        data = logical[offset:offset + length]
        require(pkg.crc16(data) == crc, name + " CRC")
        require(name not in files, "duplicate UFW filename")
        files[name] = data
    require(set(files) == {"flash.bin", "ota.bin"}, "UFW contents")
    require(files["ota.bin"] == (OUT / "loader/ota.bin").read_bytes(), "loader mismatch")
    pkg.SDK = APP.parents[1] / "dependencies/ac79-sdk"
    app = (OUT / "rnbo.bin").read_bytes()
    require(files["flash.bin"] == pkg.flash_image(app, pkg.KEY), "packaged flash differs from current app/SDK")

    elf = (OUT / "rnbo.elf").read_bytes()
    require(elf[:6] == b"\x7fELF\x01\x01", "expected little-endian ELF32")
    h = struct.unpack_from("<16sHHIIIIIHHHHHH", elf)
    sections = [struct.unpack_from("<IIIIIIIIII", elf, h[6] + i * h[11]) for i in range(h[12])]
    strings = sections[h[13]]
    names = elf[strings[4]:strings[4] + strings[5]]
    section = {names[s[0]:names.index(b"\0", s[0])].decode(): s for s in sections}
    symbols, unresolved = {}, []
    for sh in sections:
        if sh[1] != 2:
            continue
        strings = sections[sh[6]]
        names = elf[strings[4]:strings[4] + strings[5]]
        for off in range(sh[4], sh[4] + sh[5], sh[9]):
            n, value, size, info, other, index = struct.unpack_from("<IIIBBH", elf, off)
            if not n:
                continue
            name = names[n:names.index(b"\0", n)].decode()
            if index:
                symbols[name] = value
            elif info >> 4 == 1:
                unresolved.append(name)
    require(not unresolved, "unresolved ELF globals: " + str(unresolved))
    require(h[4] == symbols["_start"] == 0x02000120, "ELF entry point")
    text = section[".text"]
    text_data = elf[text[4]:text[4] + text[5]]
    require(app[:len(text_data)] == text_data, "ELF text differs from application")
    for name, load in ((".ram_text", "_rt_load"), (".data", "_data_load")):
        s = section[name]
        at = symbols[load] - h[4]
        require(app[at:at + s[5]] == elf[s[4]:s[4] + s[5]], name + " load image mismatch")
    constructors = []
    for kind in ("init_array", "ctors"):
        require(all("_rnbo_" + kind + suffix in symbols for suffix in ("_start", "_end")), kind + " linker symbols missing")
        start, end = (symbols["_rnbo_" + kind + suffix] for suffix in ("_start", "_end"))
        require(text[3] <= start <= end <= text[3] + text[5] and (end - start) % 4 == 0, kind + " table bounds")
        constructors += [p for p in struct.unpack_from("<" + "I" * ((end - start) // 4), text_data, start - text[3]) if p not in (0, 0xffffffff)]
    require(constructors, "empty constructor tables")
    require(all(text[3] <= p < text[3] + text[5] for p in constructors), "constructor pointer outside XIP text")
    require(any("GLOBAL__sub_I" in n and v in constructors for n, v in symbols.items()), "RNBO global constructor missing")

    dis = (OUT / "rnbo.dis").read_text()
    calls, function = [], ""
    for line in dis.splitlines():
        m = re.fullmatch(r"([\w.$]+):", line)
        if m and not m[1].startswith(".GJT"):
            function = m[1]
        if re.search(r"\bcall\b.*<__(?:\w*df\w*)\s*:", line):
            calls.append({"function": function, "instruction": line.strip()})
    report = {
        "package": product, "package_bytes": len(raw), "sha256": hashlib.sha256(raw).hexdigest(),
        "package_crcs_and_current_payloads_verified": True, "elf_load_images_verified": True,
        "constructor_addresses": [hex(p) for p in constructors],
        "memory_bytes": {"image": len(app), "static_ram": symbols["_bss_end"] - 0x01C08000,
                         "pool": symbols["_pool_end"] - symbols["_pool_start"]},
        "software_double_call_sites": calls,
        "disassembly_limit": "Pinned objdump cannot decode some FPU instructions; complete target DSP loop audit remains unverified.",
        "installed_by_this_review": False, "target_timing_verified": False,
    }
    (OUT / "device-review.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
