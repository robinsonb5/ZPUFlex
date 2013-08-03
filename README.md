ZPUFlex - a compact and flexible variant of the ZPU - the Zylin soft processor
core.  The aim of this project is to see just how far the "small" variant
of the core can be be taken while keeping it under 1000 logic elements.

I've tried to keep the project as configurable as possible, so there are a
number of generics which can be used to configure this ZPU variant.  A few
other parameters have been moved from zpucfg.vhd to generics, because this
makes it easier to include multiple ZPUs in a single project.

It's possible to enable or disable hardware implementations of
various instructions.  With all these disabled, the ZPU is a little under 600
LEs in size, but requires emulation "microcode" in the lower kilobyte of the
program ROM.  With these instructions enabled, the ZPU takes just under 1,000
LEs, but in combination with various GCC switches, can make do without
emulation code; thus how you set these switches will depend on whether you're
short of LEs or Block RAM.

* IMPL_MULTIPLY - hardware mult
* IMPL_COMPARISON_SUB - hardware sub, lessthan, lessthanorequal,
  ulessthan, ulessthanorequal.
* IMPL_EQBRANCH - hardware eqbranch and neqbranch
* IMPL_STOREBH - hardware storeb and storeh  (CAUTION - only supported for
  external RAM, not internal Block RAM.  Can cause trouble with firmware!)
* IMPL_LOADBH - hardware loadb and loadh   (CAUTION - only supported for
  external RAM, not internal Block RAM.  Can cause trouble with firmware!)
* IMPL_CALL - hardware call
* IMPL_SHIFT - hardware lshiftright, ashiftright and ashiftleft
* IMPL_XOR - hardware xor

There are a couple of other switches too:
* EXECUTE_RAM - include support for executing code from outside the Boot ROM.
* REMAP_STACK - maps the stack / Boot ROM which usually appears at 0x00000000
  to an alternative address (0x04000000 by default).
  This is useful in combination with the EXECUTE_RAM switch if you want
  to bootstrap a larger program than will fit in the BlockRAM-based Boot ROM.

