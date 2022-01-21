#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: CompileLaTeX.sh
# Description: Compiles latex with bibtex
#
# Outputs: pdf latex file
# Arguments: 1 (.tex latex code)
# Date: Oct 17th 2021

input=$1 # set $1 to a variable so that it can be manipulated to remove the suffix

if [[ $input == *.tex ]] # if there is a .tex suffic
then 
    # remove the suffix
    input=$(basename "$1" .tex)
    echo $input

    # determine if there is a bibtex file
    count=`ls -1 *.bib 2>/dev/null | wc -l` # sets the variable 'count' equal to the amount of .tif files in the current directory

    ##Creates pdf
    pdflatex $input.tex
    if [ $count = 0 ]
    then
        # to avoid an error, only attempt this line if .bib file is present
        bibtex $input
    fi
    pdflatex $input.tex
    pdflatex $input.tex
    evince $input.pdf &

    ##Cleanup, removes intermediary files
    rm *.aux
    rm *.log
    rm *.bbl
    rm *.blg
else
    echo "Error: Please provide a LaTeX source code file (.tex) after the script name in the command line."
fi

