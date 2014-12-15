#!/bin/bash

tests="eq lt add sub"

for a in $tests; do
    ./${a} > ../${a}.dat
done
