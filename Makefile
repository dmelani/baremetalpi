TCPATH=./toolchain/gcc-arm-none-eabi-5_2-2015q4/bin

CFLAGS=-O0 --std=c99 -ffreestanding -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mtune=cortex-a7
LDFLAGS=-nostdlib -mfloat-abi=hard

CC=$(TCPATH)/arm-none-eabi-gcc
OBJC=$(TCPATH)/arm-none-eabi-objcopy

CSRCS+=kmain.c
CSRCS+=cstubs.c
CSRCS+=gpio.c

ASRCS+=crt0.s

COBJS = $(CSRCS:.c=.o)
AOBJS = $(ASRCS:.s=.o)

OBJS = $(AOBJS) $(COBJS)

all: kernel.img

kernel.img: kernel.elf
	$(OBJC) kernel.elf -O binary kernel.img

kernel.elf: $(OBJS)
	$(CC) $(LDFLAGS) $^ -o kernel.elf

%.o : %.s
	$(CC) $(CFLAGS) -c $<

%.o : %.c
	$(CC) $(CFLAGS) -c $<

.PHONY: clean

clean:
	@rm -f $(OBJS) kernel.img kernel.elf
