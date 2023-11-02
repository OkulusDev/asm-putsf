# Директории
SRC_DIR=src
BIN_DIR=bin

# Компиляторы, линковщики
ASM=fasm
LD=ld

# Исходный код, бинарники, вывод
CODE=putsf.asm
CODE_OUTPUT=putsf.o
BIN=putsf.elf64

.phony: build clean run clean_all

build:
	$(ASM) $(SRC_DIR)/$(CODE) $(BIN_DIR)/$(CODE_OUTPUT)
	$(LD) $(BIN_DIR)/$(CODE_OUTPUT) -o $(BIN_DIR)/$(BIN)

run:
	./$(BIN_DIR)/$(BIN)

clean:
	rm $(BIN_DIR)/*.o

clean_all:
	rm $(BIN_DIR)/*
