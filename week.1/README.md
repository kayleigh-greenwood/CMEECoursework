# Computing Week 1

This README file contains details about the scripts from classwork and practicals in CMEE week 1.

## UNIX and LINUX

    UnixPrac1.txt

**Summary:** Contains commands which manipulate the FASTA files <br />
**Input:** FASTA files from data <br />
**Output:** Prints to terminal <br />
**Running Instructions:** bash UnixPrac1.txt <br /><br />
    
## SHELL SCRIPTING

	boilerplate.sh

**Summary:** Simple boilerplate for shell scripts <br />
**Input:** n/a <br />
**Output:** Prints to terminal <br />
**Running Instructions:** bash boilerplate.sh <br /><br />


	variables.sh

**Summary:** Illustrates the different types of shell variables <br />
**Input:** (OPTIONAL) two random arguments (strings/numbers etc.) <br />
**Output:** Prints to terminal <br />
**Running Instructions:** bash variables.sh arg1 arg2 OR bash variables.sh <br /><br />


	MyExampleScript.sh

**Summary:** Introduction to the $USER variable <br />
**Input:** n/a<br />
**Output:** Prints to terminal<br />
**Running Instructions:** bash MyExampleScript.sh<br /><br />



	tabtocsv.sh

**Summary:** Substitutes the tabs in a file for commas<br />
**Input:** 1 File with tab separated values (e.g. test.txt in data)<br />
**Output:** csv version of file in Results (separate to original)<br />
**Running Instructions:** bash tabtocsv.sh ../data/test.txt<br /><br />



	CountLines.sh

**Summary:** Counts and displays the number of lines in a file<br />
**Input:** 1 File (e.g. test.txt in data)<br />
**Output:** Prints to terminal<br />
**Running Instructions:** bash CountLines.sh ../sandbox/test.txt<br /><br />


	ConcatenateTwoFiles.sh

**Summary:** Concatenates the contents of two files<br />
**Input:** 2 files to be concatenated followed by the new name of the output file which the script creates<br />
**Output:** Concatenated file in results.<br />
**Running Instructions:** bash ConcatenateTwoFiles.sh ../sandbox/test.txt ../sandbox/test.txt result.txt<br /><br />


	tiff2png.sh

**Summary:** Converts tif files in directory where it is run to png format (by creating a new file)<br />
**Input:** No arguments needed, but will only detect tif files in current directory<br />
**Output:** .png versions of the files into the current directory<br />
**Running Instructions:** bash tiff2png.sh (in a directory that has tif files)<br />
**Dependencies:** imagemagick<br /><br />



	csvtospace.sh

**Summary:** Substitutes the commas in a file with spaces<br />
**Input:** 1 comma delimited file<br />
**Output:** .txt version of the input file, saved into results<br />
**Running Instructions:** bash csvtospace.sh ../data/Temperatures/1800.csv<br /><br />

## SCIENTIFIC DOCUMENTS WITH LaTeX

	FirstExample.tex

**Summary:** Example LaTeX code document<br />
**Running Instructions:** Not to be run. Source code only. Is used as an argument when CompileLaTeX.sh is called<br /><br />


	FirstBiblio.bib

**Summary:** Bibliography for example LaTeX document<br />
**Running Instructions:** Not to be run. Source code only. Is referenced when the FirstExample.tex code is compiled<br /><br />


	CompileLaTeX.sh

**Summary:** Compiles LaTeX with bibtex<br />
**Input:** 1 argument, a latex source code file<br />
**Output:** Produces the pdf of the latex source code and opens the pdf<br />
**Running Instructions:** bash CompileLaTeX.sh FirstExample.tex<br /><br />


###### Author: Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)