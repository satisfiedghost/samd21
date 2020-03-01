void system_setup();

int main() {
    system_setup();

    unsigned int* PORT_A_DIR = (unsigned int*)0x41004400;
    unsigned int* PORT_A_OUT = (unsigned int*)(0x41004400 + 0x10);

    *PORT_A_DIR |= (unsigned int)(1 << 17);
    *PORT_A_OUT |= (unsigned int)(1 << 17);

    while(1);

    return 0;
}

void system_setup() {
    unsigned int *SYS_CTRL = (unsigned int*)0x40000800U;
    unsigned int *OSC_8M = (unsigned int*)(0x40000800U + 0x20);
    *OSC_8M &= (unsigned int)0xFFFFFE7F;
}