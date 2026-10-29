/* Fixed-address RAM module. It imports no firmware symbols. */
MEMORY {
    IMAGE (rwx) : ORIGIN = 0x01c34000, LENGTH = 64K
    STATE (rw)  : ORIGIN = 0x01c44000, LENGTH = 176K
}
SECTIONS {
    .image : {
        KEEP(*(.module_api))
        *(.text*) *(.rodata*)
        . = ALIGN(4);
        _rnbo_init_array_start = .; KEEP(*(SORT(.init_array.*))) KEEP(*(.init_array)) _rnbo_init_array_end = .;
        _rnbo_ctors_start = .; KEEP(*(SORT(.ctors.*))) KEEP(*(.ctors)) _rnbo_ctors_end = .;
        *(.data*) *(.sdata*)
        . = ALIGN(4); _module_image_end = .;
    } > IMAGE
    .state (NOLOAD) : {
        _module_state_start = .;
        *(.bss*) *(.sbss*) *(COMMON) . = ALIGN(16); *(.pool*)
        . = ALIGN(16); _module_state_end = .;
    } > STATE
    /DISCARD/ : { *(.comment) *(.note*) }
}
