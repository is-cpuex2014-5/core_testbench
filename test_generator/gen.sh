#!/bin/bash

tests="eq"

for a in $tests; do
    ./${a} > ../${a}.dat
done
