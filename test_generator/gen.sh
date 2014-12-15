#!/bin/bash

tests="eq lt add sub not"

for a in $tests; do
    ./${a} > ../${a}.dat
done
