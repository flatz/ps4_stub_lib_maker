WINE = wine
WINE_PATH_TOOL = winepath

CC = $(WINE) orbis-clang
LD = $(WINE) orbis-ld
FIX_STUB = ./fix_stub.py

OBJDIR = obj
BLDDIR = build

TARGET = libtest

COMMON_FLAGS = -Wall
COMMON_FLAGS += -fdiagnostics-color=always
COMMON_FLAGS += -I $(SCE_ORBIS_SDK_DIR)/target/include -I $(SCE_ORBIS_SDK_DIR)/target/include/common
COMMON_FLAGS += -DNDEBUG
COMMON_FLAGS += -g

CFLAGS = $(COMMON_FLAGS)
CFLAGS += -std=c11
CFLAGS += -Wno-unused-variable -Wno-unused-function -Wno-unused-label -Werror=implicit-function-declaration -Wno-return-type
CFLAGS += -fno-strict-aliasing
CFLAGS += -fPIC
CFLAGS += -O3

SRCS = test.c
OBJS = $(addprefix $(OBJDIR)/,$(SRCS:.c=.c.o))

.PHONY: all clean

all: post-build

pre-build:
	@mkdir -p $(BLDDIR)

post-build: main-build

main-build: pre-build
	@$(MAKE) --no-print-directory lib

lib: $(OBJS)
	$(LD) $^ --oformat=prx --stub-only --prx-stub-output-dir=$(BLDDIR) -o $(BLDDIR)/$(TARGET).prx
	$(FIX_STUB) $(BLDDIR)/$(TARGET)_stub_weak.a

$(OBJDIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -rf $(OBJDIR) $(BLDDIR)
