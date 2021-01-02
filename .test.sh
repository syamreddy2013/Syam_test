#!/bin/bash
SCORE=0
PASS=0
TOTAL_TESTS=1

hadoop fs -ls /user  > output1.txt
TEST_1=$( grep -e "inputdataset" output1.txt | wc -l )
if [ $TEST_1 -eq 1 ]
then PASS=$((PASS + 1))
fi;



echo "Total testcases: 1"
echo "Total testcase passed: $PASS"
echo "Total testcase fail: $fail"
SCORE=$(($PASS*100 / $TOTAL_TESTS))
echo "You have scored:$SCORE%"
























