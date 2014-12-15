#!/bin/sh

# please change this variable when test target is changed
tests="left_logic_shift right_logic_shift left_arith_shift right_arith_shift"
run="shift_sim"
ERROR_MES="User(VHDL) Code Called Simulation Stop"


NUM=$(echo $tests | wc -w)
PASSED="0"
FAILED="0"

if [ $NUM -eq 1 ]; then
    echo -e "\e[32m[==========]\e[0m Running 1 bench";  
else
    echo -e "\e[32m[==========]\e[0m Running $NUM benchs";  
fi

for a in $tests; do
    rm -f shift.dat;
    cp $a.dat shift.dat;
    echo -e "\e[32m[ RUN      ]\e[0m $a";
    if echo "run all" | ./$run | grep "$ERROR_MES" > /dev/null; then
	echo -e "\e[31m[  FAILED  ]\e[0m $a";
	FAILED=$(( $FAILED + 1));
    else
	echo -e "\e[32m[  PASSED  ]\e[0m $a";
	PASSED=$(( $PASSED + 1));
    fi;
done
echo -e "\e[32m[==========]\e[0m";  
if [ $PASSED -eq 1 ]; then
    echo -e "\e[32m[  PASSED  ]\e[0m $PASSED bench.";
elif [ $PASSED -gt 1 ]; then
    echo -e "\e[32m[  PASSED  ]\e[0m $PASSED benchs.";
fi;

if [ $FAILED -eq 1 ]; then
    echo -e "\e[31m[  FAILED  ]\e[0m $FAILED bench.";
elif [ $FAILED -gt 1 ]; then
    echo -e "\e[31m[  FAILED  ]\e[0m $FAILED benchs.";
else
    exit 0;
fi;
exit 1;
