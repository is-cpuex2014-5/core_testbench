UNITS = eq lt add sub
SIMS = $(UNITS:%=%_sim)
DATA = $(UNITS:%=%.dat)
TESTBENCH = $(SIMS)
vpath %.vhd core
vpath %.vhd src
vpath %.prj src
vpath %_sim.vhd src

all: $(TESTBENCH)


add_sim: alu.vhd
sub_sim: alu.vhd
lt_sim: compr.vhd
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
