## 13-09-2026 - No serial output on the UART when testing

### My first hitting face on wall
I forgot to setup a stack when starting the kernel, since i call C functions with local variables
on their stack frame what happened

```
   sub sp, sp, #16 
```

since when i started the kernel with no stack setup, the default stack pointer was probably pointing to 0x0, with that sub the new stack value
must've been decreased to 0xFFFFFFFFFFFFFFFFF or to an address whose qemu didn't map, since i allocated only 128MB :(
