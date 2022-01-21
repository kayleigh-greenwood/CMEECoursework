# Weeks 8 & 9: Miniproject

This README file contains details about the contents of the miniproject, and relevant scripts, in CMEE weeks 8 & 9.

INSTRUCTIONS: "python3 run_MiniProject.py" to collate

## Languages
Python version 3.8.10
R version 3.6.3

## Dependencies/packages
tidyverse
minpac.lm

## Scripts
***

### Data Preparation

    DataPrep.R

**Summary:** Prepares the data for model fitting <br />
**Input:** LogisticGrowthData.csv in data <br />
**Output:** ModifiedData.csv in data <br />
**Required packages:** tidyverse (for reading files) <br />

### Model Fitting

    ModelFitting.R

**Summary:** creates models and plots onto all subsets <br />
**Input:** ModifiedData.csv in data <br />
**Output:** PlotID.pdf for each data subset into Plots, Analysis,csv in results  <br />
**Required packages:** minpack.lm (for NLLS), tidyverse <br />

### Plotting and analysis

    PlotandAnalyse.R

**Summary:** Plots model comparison data into pdfs <br />
**Input:** Analysis.csv in results results from model fitting <br />
**Output:** Figures and plots in Plots directory  <br />
**Required packages:** tidyverse(for ggplot2) <br />

### Written Report
    WrittenReport.tex

**Summary:** Report source code for LaTeX report <br />
**Input:** wordcount.sum from results, PlotID146.pdf from Plots, AIC.pdf from results, RSS.pdf from results <br />
**Output:**  <br />

    ReportBiblio.bib

**Summary:** Bibliography source code for LaTeX report <br />
**Input:**  <br />
**Output:**  <br />

    WordCounter.sh

**Summary:** Counts words in report, excluding title page, references, and figure/table legends <br />
**Input:** WrittenReport.tex <br />
**Output:** wordcount.sum in results <br />

    CompileLaTeX.sh

**Summary:** Creates pdf by combining latex source codes <br />
**Input:** WrittenReport.tex, ReportBiblio.bib, wordcount.sum in results <br />
**Output:** WrittenReport.pdf in results <br />

    run_MiniProject.py

**Summary:** Runs whole project by running main scripts <br />
**Input:** DataPrep.R, ModelFitting.R, PlotandAnalyse.R, WordCounter.sh, CompileLaTeX.sh, WrittenReport.tex <br />
**Output:** WrittenReport.pdf in results <br />

***
