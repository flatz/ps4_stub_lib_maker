ifeq ($(DIST),)
$(error Error! DIST variable is not set!)
endif

TARGETS := libkernel

.PHONY: all install clean

all:
	@for target in $(TARGETS); do \
		echo Entering directory $$target; \
		$(MAKE) --no-print-directory -C $$target; \
		echo Leaving directory $$target; \
	done

clean:
	@for target in $(TARGETS); do \
		echo Cleaning directory $$target; \
		$(MAKE) --no-print-directory -C $$target clean; \
	done

install: all
	@mkdir -p "$(DIST)/lib"
	@cp */*.a "$(DIST)/lib/"
