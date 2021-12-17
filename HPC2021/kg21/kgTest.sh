#!/bin/bash
#PBS -lwalltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
cp $HOME/kg21_HPC_2021_main.R .
module load anaconda3/personal
module load intel-suite
echo "R is about to run"
R --vanilla < $HOME/clusterrun.R 
mv resultiter* $HOME
echo "R has finished running"
# end of file

# Use sftp and ssh to set your jobs running on the cluster as instructed during the lecture(also see lecture notes).
# Then test on the cluster with iter of 1,2,3 only before doing the rest (use -J 1-3 as in the lecture notes).  
# Finally run the full set of jobs to the clustere.g. -J 4-100 if the first 3 came out OK[10marks for all your output files(.rda .e and .o),shellscript codeand R code]
