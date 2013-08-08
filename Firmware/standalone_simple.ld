
/* Memory Definitions for a ZPU program running entirely from boot / stack RAM with no address remapping. */

MEMORY
{
  CODE (rx) : ORIGIN = 0x04000008, LENGTH = 0x000fff8 /* Up to the end of the first 64K */
}


/* Section Definitions */

SECTIONS
{
  /* first section is .fixed_vectors which is used for startup code */
  . = 0x0000000;
  .fixed_vectors :
  {
    *(.fixed_vectors)
  }>BOOT

  /* Remaining code sections */
  .text :
  {
	. = ALIGN(4);
    *(.text)                   /* remaining code */
  } >CODE

  /* .rodata section which is used for read-only data (constants) */
  .rodata :
  {
    *(.rodata*)
  . = ALIGN(4);
  } >CODE
  _romend = . ;

  /* .data section which is used for initialized data. */
  .data :
  {
    _data = . ;
    *(.data)
    SORT(CONSTRUCTORS)
    . = ALIGN(4);
  } >CODE

  /* .bss section which is used for uninitialized data */
  .bss :
  {
    __bss_start = . ;
    __bss_start__ = . ;
    *(.bss)
    *(COMMON)
    . = ALIGN(4);
  } >CODE
  __bss_end__ = . ;
}
