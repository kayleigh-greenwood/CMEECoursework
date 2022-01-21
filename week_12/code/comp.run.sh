#!/usr/bin/env bash

if [[ -e ./a.out ]]
then
    rm ./a.out
fi

if [[ -f $1 ]] # [[ is not recognised by sh so run this file using bash
then
    gcc $1

    if [[ -e ./a.out ]]
    then
        ./a.out
    else
        echo "Error: Program did not run. No Output File (./a.out) Produced"
    fi
else
    echo 'Error: No Suitable File Provided, please enter C file following this script'
fi
