#!/bin/sh
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: WordCounter.sh
# Desc: Produce wordcount for Report.tex excluding relevant areas

echo "creating wordcount.sum"

texcount -1 -sum WrittenReport.tex > ../results/wordcount.sum

echo "wordcount.sum created"
# produces a file containing only the word count
# word count contains: headings, sub-headings, abstract, 
# word count doesn't contain: title page, References, figure legends