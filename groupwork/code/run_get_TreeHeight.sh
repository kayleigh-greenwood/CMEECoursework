#!/bin/bash


Rscript get_TreeHeight.R ../data/trees.csv

python3 get_TreeHeight.py ../data/trees.csv