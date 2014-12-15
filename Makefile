UNITS = eq lt add sub not and nand nor or xor shift
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
not_sim: alu.vhd
and_sim: alu.vhd
nand_sim: alu.vhd
nor_sim: alu.vhd
or_sim: alu.vhd
xor_sim: alu.vhd
shift_sim: alu.vhd

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
