# Computing Week 3

This README file contains details about the scripts from classwork and practicals in CMEE week 3.

## R

    basic_io.R

**Summary:** A simple script to illustrate R input-output and how to use the read() and write() functions <br />
**Input:** n/a <br />
**Output:** MyData.csv in results <br />
**Running Instructions:** Rscript basic_io.R <br /><br />

    control_flow.R

**Summary:** Intro to control flow tools (if statements, for loops and while loops)  <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript control_flow.R <br /><br />


    break.R

**Summary:** Intro to breaking out of loops using 'break' <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript break.R <br /><br />


    next.R

**Summary:** Intro to using 'next' to skip to next iteration of for loop. Only prints odd numbers <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript next.R<br /><br />


    boilerplate.R

**Summary:** boilerplate R script <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript boilerplate.R <br /><br />



    R_conditionals.R

**Summary:** Functions with conditionals examples <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript R_conditionals.R<br /><br />



    TreeHeight.R

**Summary:** Calculates tree height for each entry in a specified dataset using distance and angle. <br />
**Input:** trees.csv in data <br />
**Output:** TreeHts.csv in results <br />
**Running Instructions:** Rscript TreeHeight.R<br /><br />


    Vectorize1.R

**Summary:** Sums all elements of a matrix. Compares sum() and a sum function <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript Vectorize1.R<br /><br />


    preallocate.R

**Summary:** Compares times of pre-allocation to no pre-allocation <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript preallocate.R<br /><br />


    apply1.R

**Summary:** Applying a function to the rows or columns of a matrix <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript apply1.R <br /><br />


    apply2.R

**Summary:** Using apply to define own functions <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript apply2.R<br /><br />


    sample.R

**Summary:** Example of vectorization using lapply and sapply <br />
**Input:** N/A <br />
**Output:** Prints to terminal and produces histogram <br />
**Running Instructions:** Rscript sample.R <br /><br />


    Ricker.R

**Summary:** Plots the ricker model <br />
**Input:** N/A <br />
**Output:** N/A <br />
**Running Instructions:** Rscript Ricker.R <br /><br />

   
    Vectorize2.R

**Summary:** Vectorizes the ricker model and adds fluctuation <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript Vectorize2.R<br /><br />


    browse.R

**Summary:** Using the browser() function to debug by examining local variables <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Run inside RStudio to explore browser() function<br /><br />


    try.R

**Summary:** illustrates try <br />
**Input:** N/A <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript try.R<br /><br />


    Florida.R

**Summary:** Calculates correlation coefficient between temperature and time for the 20th century in Key West, Florida and uses a permutation analysis to calculate the P-value <br />
**Input:** KeyWestAnnualMeanTemperature.RData in data <br />
**Output:** Prints to terminal and saves figures in results <br />
**Running Instructions:** Rscript Florida.R <br /><br />


    Florida_warming.tex

**Summary:** LaTeX code writeup file for results and their interpretation from Florida.R  <br />
**Input:** Figures in results <br />
**Output:** Can be compiled into LaTeX file <br />
***
**Running Instructions:** To be compiled with LaTeX<br /><br />
## R GROUPWORK


    get_TreeHeight.R

**Summary:** Calculates tree height for each entry in any dataset (input into command line) using distance and angle. <br />
**Input:** 1 file into command line consisting of tree data to be analysed (e.g. trees.csv in data) <br />
**Output:** [inputfilename]_TreeHts_R.csv in results <br />
**Running Instructions:** Rscript get_TreeHeight.R trees <br /><br />


    get_TreeHeight.py

**Summary:** Calculates tree height for each entry in any dataset (input into command line) using distance and angle. <br />
**Input:** 1 file into command line consisting of tree data to be analysed <br />
**Output:** [inputfilename]_TreeHts_py.csv in results <br />
**Dependencies:** sys, pandas, numpy<br />
**Running Instructions:** python3 get_TreeHeight.py ../data/Trees.csv <br /><br />

    run_get_TreeHeight.sh

**Summary:** Tests get_TreeHeight.R and get_TreeHeight.py <br />
**Input:** n/a <br />
**Output:** trees_TreeHts_R.csv, trees_TreeHts_py.csv in results <br />
**Running Instructions:** bash run_get_TreeHeight.sh <br /><br />

    TAutoCorr.R

**Summary:** Calculates correlation coefficient between temperature of one year and temperature of the next in Key West, Florida and uses a permutation analysis to calculate the P-value <br />
**Input:** KeyWestAnnualMeanTemperature.RData in data <br />
**Output:** Uses permutation analysis to calculate p-value <br />
**Running Instructions:** Rscript TAutoCorr.R <br /><br />

    TAutoCorr.tex

**Summary:** Write up for TAutoCorr.R <br />
**Input:** n/a <br />
**Output:** source code produces latex pdf <br />
**Running Instructions:** Must compile using latex <br /><br />


## DATA MANAGEMENT AND VISUALISATION

    DataWrang.R
**Summary:** Wrangling the pound hill dataset <br />
**Input:** PoundHillData.csv, PoundHillMetaData.csv from data <br />
**Output:** Prints to terminal <br />
**Dependencies:** reshape2
**Running Instructions:** Rscript DataWrang.R<br /><br />

    DataWrangTidy.R
**Summary:** Wrangling the pound hill dataset using tidyverse <br />
**Input:** PoundHillData.csv, PoundHillMetaData.csv from data <br />
**Output:** Prints to terminal <br />
**Running Instructions:** Rscript DataWrangTidy.R<br /><br />


    plotLin.R
**Summary:** Annotates a linear regression plot <br />
**Input:** N/A <br />
**Output:** Figure 'MyLinReg.pdf' in results <br />
**Running Instructions:** Rscript plotLin.R<br /><br />


    PP_Dists.R
**Summary:** Data exploration - creating sub-plots <br />
**Input:** EcolArchives from data <br />
**Output:** Pdf figures (Pred_Subplots.pdf, Prey_Subplots.pdf, SizeRatio_Subplots.R) and regression results (PP_Results.csv) in results <br />
**Running Instructions:** Rscript PP_Dists.R <br /><br />


    PP_Regress.R
**Summary:** Generating and accessing regression results <br />
**Input:** EcolArchives from data <br />
**Output:** PP_Regress_Results.csv and PP_Regress.pdf in results <br />
**Running Instructions:** Rscript PP_Regress<br /><br />


    Girko.R
**Summary:** Plotting two dataframes together <br />
**Input:**  <br />
**Output:** Girko.pdf figure in results <br />
**Running Instructions:** Rscript Girko.R<br /><br />


    MyBars.R
**Summary:** Annotating a plot <br />
**Input:** Results.txt in data <br />
**Output:** MyBars.pdf figure in results <br />
**Running Instructions:** Rscript MyBars.R<br /><br />


    GPDD_Data.R
**Summary:** Mapping intro - creates a world map with points <br />
**Input:** GPDDFiltered.RData in data <br />
**Output:** worldmap.pdf in results <br />
**Running Instructions:** Rscript GPDD_Data.R<br /><br />


###### Author: Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)