extern int main(void);

extern unsigned int _etext;
extern unsigned int _sdata;
extern unsigned int _edata;
extern unsigned int _sbss;
extern unsigned int _ebss;
extern unsigned int _stack_top;

void reset_handler(void);

__attribute__ ((used, section(".vectors")))
void (* const vectors[])(void) =
{
    &_stack_top,
    reset_handler
};

void reset_handler(void) {
    unsigned int *src, *dst;

    src = &_etext;
    dst = &_sdata;

    while (dst < &_edata) {
        *dst++ = *src++;
    }

    dst = &_sbss;

    while (dst < &_ebss) {
        *dst++ = 0;
    }

    unsigned int *SCB_VTOR = (unsigned int*)(0xE000E000UL + 0x0D00UL + 0x08);


    *SCB_VTOR = (unsigned int)vectors;

    main();

    while (1);
}

void _exit(int status) {
    (void)status;
    while (1);
}