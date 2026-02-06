CC := gcc
CFLAGS := -Iinclude -Wall -Wextra -std=c11
LDFLAGS :=

SRC := main.c $(wildcard src/*.c)

MODE ?= debug
BUILD_DIR ?= build/$(MODE)
TARGET := $(BUILD_DIR)/main

ifeq ($(MODE),debug)
	CFLAGS += -g -O0
else ifeq ($(MODE),release)
	CFLAGS += -O2 -DNDEBUG
endif

.PHONY: all debug release clean

all: $(TARGET)

debug:
	$(MAKE) MODE=debug BUILD_DIR=$(word 2,$(MAKECMDGOALS)) all

release:
	$(MAKE) MODE=release BUILD_DIR=$(word 2,$(MAKECMDGOALS)) all

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET) $(LDFLAGS)

clean:
	rm -rf build
