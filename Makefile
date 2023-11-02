# Директории
SRC_DIR=src
BIN_DIR=bin

# Компиляторы, линковщики
ASM=fasm
LD=ld
C=gcc
C_FLAGS=-nostdlib

# Исходный код, бинарники, вывод
CODE=putsf.asm
.phony: build clean run clean_all

build:
	$(ASM) $(SRC_DIR)/putsf.asm $(BIN_DIR)/putsf.o
	$(ASM) $(SRC_DIR)/c_putsf.asm $(BIN_DIR)/c_putsf.o
	$(ASM) $(SRC_DIR)/c_exit.asm $(BIN_DIR)/c_exit.o
	$(C) $(C_FLAGS) -o $(BIN_DIR)/putsf.bin $(BIN_DIR)/putsf.o $(BIN_DIR)/c_putsf.o $(BIN_DIR)/c_exit.o $(SRC_DIR)/putsf_example.c

run:
	./$(BIN_DIR)/putsf.bin

clean:
	rm $(BIN_DIR)/*.o

clean_all:
	rm $(BIN_DIR)/*
