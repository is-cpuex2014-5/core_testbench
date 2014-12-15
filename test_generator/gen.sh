#!/bin/bash

tests="eq lt add"

for a in $tests; do
    ./${a} > ../${a}.dat
done
