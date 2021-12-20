#!/bin/bash
#PBS -lwalltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
cp $HOME/kg21_HPC_2021_main.R .
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/kg_HPC_clusterrun.R
mv resultiter* $HOME
echo "R has finished running"
