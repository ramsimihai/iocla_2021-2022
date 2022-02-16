#!/bin/bash

total='0'
CODING_STYLE_BONUS=0
MAX_BONUS=20

valgrind_test() {
    (time timeout 50 valgrind --leak-check=full --show-leak-kinds=all --error-exitcode=1 -q ./$EXEC) &>/dev/null
    if [ "$?" != "0" ]; then
        echo -n "DETECTED MEMORY LEAKS - "
        return 1
    else
        return 0
    fi
}

valgrind_test_hll() {
    (time timeout 50 valgrind --leak-check=full --show-leak-kinds=all --error-exitcode=1 -q ./$EXEC $test_file) &>/dev/null
    if [ "$?" != "0" ]; then
        echo -n "DETECTED MEMORY LEAKS - "
        return 1
    else
        return 0
    fi
}

rope() {
    rope_points=(10 10 20 20 5 5 10)

    echo "Testing Rope..."

    for i in `seq 1 7`; do
        echo -n "$i. "

        gcc -std=c11 -o test -g -Wall -Wextra rope.c "tests/test${i}.c"
        ref_file="tests/ref/test${i}.ref"

        EXEC=test
        ./$EXEC | diff - "$ref_file" > /dev/null
        TEST_OK=$?
        if [[ $i -le 5 ]]; then
            valgrind_test 
            VALGRIND_OK=$?
        else
            VALGRIND_OK=0
        fi
        [[ $TEST_OK -eq 0 && $VALGRIND_OK -eq 0 ]] \
            && echo "passed .......... ${rope_points[i-1]} points" \
            && total="$total+${rope_points[i-1]}" \
            || echo "failed";

        rm $EXEC

    done
    echo ""
}


function checkBonus {
    printf '%*s\n' "${COLUMNS:-$(($(tput cols) - $ONE))}" '' | tr ' ' -
    echo "" > checkstyle.txt

    echo -ne "Coding style Errors:\n"
    for entry in *.{c,h}; do
    echo $entry
        if [[ -f $entry ]]; then
            python2 cpplint.py --filter=-build/header_guard,-legal/copyright,-runtime/printf,-build/include "$entry" > checkstyle.txt
            YOUR_BONUS=`cat checkstyle.txt | grep "Total errors found: "| tr -dc '0-9'`
            echo $YOUR_BONUS
            ERRORS_NUMBER=$(( $ERRORS_NUMBER+$YOUR_BONUS ))
        fi
    done

    if [[ $ERRORS_NUMBER != "0" ]]; then
        printf '\nBonus: %*sFAIL' "${COLUMNS:-$(($(tput cols) - $MESSAGE_SIZE))}" '' | tr ' ' -
        echo -ne "\n\t\tYou have a total of $ERRORS_NUMBER coding style errors.\n"

    else
        echo -ne "\n\tNone?\n\t\tWow, next level!"
        printf '\n\nBonus: %*sOK' "${COLUMNS:-$(($(tput cols) - $MESSAGE_SIZE + $TWO ))}" '' | tr ' ' -

        CODING_STYLE_BONUS=$((($total) * $MAX_BONUS / 80))
        CODING_STYLE_BONUS=$(($CODING_STYLE_BONUS))
    fi
    rm -f checkstyle.txt
}

function printBonus {
    if [[ $ERRORS_NUMBER -gt 0 ]]; then
    printf '\n%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        echo -ne  "\n\tAnd you almost did it!\n"
    else
        echo -ne "\n\tDamn!\n"
    fi
    echo -ne "\n\t\tYou got a bonus of $CODING_STYLE_BONUS/$MAX_BONUS.\n\n"
}

echo ""; rope; echo "total = $(echo $total | bc)/80"; checkBonus; printBonus; make clean &> /dev/null
