#!/bin/bash

tests="eq lt"

for a in $tests; do
    ./${a} > ../${a}.dat
done
