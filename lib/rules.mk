WINE = wine
WINE_PATH_TOOL = winepath

CC = $(WINE) orbis-clang
LD = $(WINE) orbis-ld
FIX_STUB = $(CURDIR)/../../fix_stub.py

TARGET = $(notdir $(CURDIR))
OUTPUT = $(CURDIR)/$(TARGET)

COMMON_FLAGS = -Wall
COMMON_FLAGS += -fdiagnostics-color=always
COMMON_FLAGS += -I $(SCE_ORBIS_SDK_DIR)/target/include -I $(SCE_ORBIS_SDK_DIR)/target/include/common -I $(CURDIR)/.. -include common.h
COMMON_FLAGS += -DNDEBUG
COMMON_FLAGS += -g

CFLAGS = $(COMMON_FLAGS)
CFLAGS += -std=c11
CFLAGS += -Wno-unused-variable -Wno-unused-function -Wno-unused-label -Werror=implicit-function-declaration -Wno-return-type
CFLAGS += -fno-strict-aliasing
CFLAGS += -fPIC
CFLAGS += -O3

$(OUTPUT).prx: stub.o
	@rm -f $(OUTPUT)_stub.a $(OUTPUT)_stub_weak.a $(OUTPUT).prx
	$(LD) $^ --oformat=prx --stub-only --prx-stub-output-dir=$(CURDIR) -o $@
	$(FIX_STUB) $(OUTPUT)_stub_weak.a

stub.o: stub.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -f stub.o $(OUTPUT)_stub.a $(OUTPUT)_stub_weak.a $(OUTPUT).prx
