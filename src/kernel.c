 #define UART0_DR ((volatile unsigned int *)0x09000000)
 #define UART0_FR ((volatile unsigned int *)0x09000018)
 #define UART_FR_RXFE (1 << 4)

 char uart_read(void) {
      while (*UART0_FR & UART_FR_RXFE) { }
      return (char)*UART0_DR;
 }

void uart_write(const char c) {
  *UART0_DR = c;
}

void uart_puts(const char *str) {
   while (*str) {
        uart_write(*str++);
   }
}

void kmain(void) {
      uart_puts("Kernel shell ready\r\n> ");

      for (;;) {
          char c = uart_read();
          uart_write(c);  // echo it back
      }
 }
