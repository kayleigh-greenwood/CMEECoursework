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
then # remove the suffix
    input=$(basename "$1" .tex)
    echo $input
fi

##Creates pdf
pdflatex $input.tex
bibtex $input
pdflatex $input.tex
pdflatex $input.tex

## relocates pdf
mv $input.pdf ../results/

##Cleanup, removes intermediary files
rm *.aux
rm *.log
rm *.bbl
rm *.blg