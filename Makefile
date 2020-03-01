CC=arm-none-eabi-gcc
LDFLAGS=-T linker.ld

DEFINES += -DF_CPU=8000000

CFLAGS += $(DEFINES)

hex : program.o
	objcopy -O ihex program.o program.hex

program.o : startup.o main.o
	$(CC) $(CFLAGS) -o program.o $(LDFLAGS) startup.o main.o

startup.o : startup.c
	$(CC) $(CFLAGS) -c startup.c

main.o : main.c startup.c
	$(CC) $(CFLAGS) -c main.c

.PHONY: flash
flash : program.hex
	JLinkExe -if swd -device ATSAMD21G18 -speed 4000 flash.jlink

.PHONY: clean
clean:
	rm -f *.o *.hex