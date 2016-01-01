# TODO: En el futuro es preferible usar una mejor heurística para diferenciar
# ejemplos completos de pseudocódigo
SOURCES := $(shell grep -r 'int main' | cut -d ":" -f 1)
TARGETS := $(patsubst %.c, target/%, $(SOURCES))

CFLAGS := -Wall
CLINKFLAGS := -pthread

.PHONY: all
all: $(TARGETS)
	@echo > /dev/null

target/%: %.c
	$(CC) $(CFLAGS) $< -o $@ $(CLINKFLAGS)
