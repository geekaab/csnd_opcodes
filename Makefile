SRCS:=$(foreach f, ., $(wildcard *.c))
OPCODES:=$(addsuffix .so, $(basename $(SRCS)))

CSND_INC_DIR:=/usr/local/include/csound
INSTALL_DIR:=~/lib/csnd/

CC:=gcc
CC_OPT:=-O2
CC_FLAGS:=-shared -fPIC
CC_PATHS:=$(CSND_INC_DIR)
CC_INC:=$(addprefix -I, $(CC_PATHS))

help:
	@echo "opcodes: $(OPCODES)"
	@echo "source files: $(SRCS)"

all:
	$(MAKE) $(OPCODES)

%.so: %.c
	$(CC) $(CC_OPT) $(CC_FLAGS) -o$@ $< $(CC_INC)

$(SRCS): opcode_utils.h

install: $(OPCODES)
	cp -f $^ $(INSTALL_DIR)
