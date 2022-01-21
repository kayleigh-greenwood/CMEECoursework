#!/usr/bin/env python3

"""Python script which uses subprocess to run an R script"""

## IMPORTS ##
import subprocess

## SCRIPT ##
subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()
# must use Rscript and not source to avoid errors
