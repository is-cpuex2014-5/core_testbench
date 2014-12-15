UNITS = eq
SIMS = $(UNITS:%=%_sim)
DATA = $(UNITS:%=%.dat)
TESTBENCH = $(SIMS)
vpath %.vhd core
vpath %.vhd src
vpath %.prj src
vpath %_sim.vhd src

all: $(TESTBENCH)


eq_sim: compr.vhd

%.dat:
	make -C test_generator

%_sim: %_sim.prj %_sim.vhd
	fuse -incremental -prj $< -o $@ $@

test:$(TESTBENCH) $(DATA)
	@./test.sh

clean:
	rm -f $(TESTBENCH) *.wdb

.PHONY: all clean test
