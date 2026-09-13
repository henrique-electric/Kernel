CC      := clang
QEMU    := qemu-system-aarch64

BUILD   := build
KERNEL  := $(BUILD)/kernel.elf
SOURCES  := $(wildcard src/*.S)
SOURCESC := $(wildcard src/*.c)
OBJECTS  := $(patsubst src/%.S,$(BUILD)/%.o,$(SOURCES)) \
            $(patsubst src/%.c,$(BUILD)/%.o,$(SOURCESC))

CFLAGS  := --target=aarch64-none-elf -ffreestanding -fno-stack-protector
LDFLAGS := -nostdlib -fuse-ld=lld -Wl,-T,linker.ld -Wl,--build-id=none
QEMUFLAGS := -M virt -cpu cortex-a72 -m 128M -nographic -serial mon:stdio

.PHONY: all run debug clean

all: $(KERNEL)

$(KERNEL): $(OBJECTS) linker.ld | $(BUILD)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJECTS)

$(BUILD)/%.o: src/%.S | $(BUILD)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: src/%.c | $(BUILD)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD):
	mkdir -p $@

run: $(KERNEL)
	$(QEMU) $(QEMUFLAGS) -kernel $(KERNEL)

debug: $(KERNEL)
	$(QEMU) $(QEMUFLAGS) -S -s -kernel $(KERNEL)

clean:
	rm -rf $(BUILD)
