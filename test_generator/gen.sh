#!/bin/bash

tests="eq lt add sub not and nand nor or xor right_arith_shift left_arith_shift right_logic_shift left_logic_shift"

for a in $tests; do
    ./${a} > ../${a}.dat
done
