# Source provenance

The platform is vendored as ordinary files so the source archive and Git
checkout have the same build layout. No upstream repository metadata is copied.

| Component | Upstream | Pinned revision |
| --- | --- | --- |
| `fm1-base/` platform | https://github.com/charlesvestal/fm1-base | `bbfd4615e344028c90375bbdd79968e1b6ba2cd9` |
| `fm1-base/bsp/` | https://github.com/hugelton/felucca-bsp | `33cac693903e753e8783baeed05c19cadfb04812` |
| SDK packaging files, fetched locally | https://gitee.com/Jieli-Tech/fw-AC79_AIoT_SDK | `d179b4484759423312073f5fbb232501aa491047` |
| JieLi compiler, fetched locally | https://pkgman.jieliapp.com/s/linux-toolchain | `jieli-linux-toolchains-20260730.1` |

Local additions are `fm1-base/rnbo/`, `fm1-base/rnbo-loader/`,
`fm1-base/bsp/chip/fm1_module_guard.h`, setup scripts and project documentation.
The platform and BSP's tracked source files are otherwise unchanged. Their
upstream `.gitmodules` files are omitted because the BSP is vendored here.
Existing per-file notices, licence texts and upstream attribution are retained.

`setup/dependencies.json` records the SDK/compiler and Docker pins; setup
verifies compiler archive and SDK packaging-file hashes before use. RNBO code
generation uses the user's installed version 1.4.4 and records its provenance
and source hashes in each generated export directory.
