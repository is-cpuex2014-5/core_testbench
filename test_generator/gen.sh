#!/bin/bash

tests="eq lt add sub not and nand nor or xor"

for a in $tests; do
    ./${a} > ../${a}.dat
done
