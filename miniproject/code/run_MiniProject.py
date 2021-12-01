#!/usr/bin/env python3

###########
# imports #
###########

import subprocess

###############
# main script #
###############

subprocess.run(["bash", "WordCounter.sh"])
# Creates file 'document.sum' containing wordcount of report

subprocess.run(["bash", "CompileLaTeX.sh", "Report"])
# uses source codes to create final report pdf 
