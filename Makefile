TCPATH=/Users/daniel/projects/embedded/toolchain/gcc-arm-none-eabi-4_9-2015q3/bin

CFLAGS=-O0 -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mtune=cortex-a7
LDFLAGS=-nostartfiles -mfloat-abi=hard

CC=$(TCPATH)/arm-none-eabi-gcc
OBJC=$(TCPATH)/arm-none-eabi-objcopy

CSRCS = cstubs.c kmain.c
ASRCS = crt0.s

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
	rm $(OBJS) kernel.img kernel.elf
