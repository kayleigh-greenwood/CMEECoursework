#!/usr/bin/env python3

###########
# imports #
###########

import subprocess

###############
# main script #
###############

### Data prep

subprocess.run(["Rscript", "DataPrep.R"])

### Model fitting

subprocess.run(["Rscript", "ModelFitting.R"])

### PlotandAnalyse.R

subprocess.run(["Rscript", "PlotandAnalyse.R"])

### Compile final report

subprocess.run(["bash", "WordCounter.sh"])
# Creates file 'document.sum' containing wordcount of report

subprocess.run(["bash", "CompileLaTeX.sh", "WrittenReport"])
# uses source codes to create final report pdf 
