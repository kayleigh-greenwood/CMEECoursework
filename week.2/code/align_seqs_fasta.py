#!/usr/bin/env python3
"""align two DNA sequences such that they are as similar as possible
"""
__appname__ = 'align_seqs_fasta.py' 
__author__ = 'Junyue Zhang (jz1621@ic.ac.uk), Kate Griffin (kate.griffin21@imperial.ac.uk), Peter Zeng (pz221@imperial.ac.uk), Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

### IMPORTS ###
import csv
import sys

### FUNCTIONS ###
def extract(fastafile1, fastafile2):
    """assign sequences and their lengths into correct variables"""

    ## extract sequences from files ##
    temp = []

    with open(fastafile1, 'r') as file:
        next(file) ## ensures header line isn't copied ##
        seq1 = file.read()
        temp.append(seq1)
        seq1 = temp[0].replace("\n", "") ## remove all newline characters ##

    with open(fastafile2, 'r') as file:
        next(file) 
        seq2 = file.read()
        temp.append(seq2)
        seq2 = temp[1].replace("\n", "") 

    ## assigns length of sequences to variables ##
    len1 = len(seq1) 
    len2 = len(seq2)

    ## Ensure that seq1 & len1 represent the longest sequence, if not, swap them ##
    if len1 < len2:
        seq1, seq2 = seq2, seq1 
        len1, len2 = len2, len1 

    return seq1, seq2, len1, len2

def calculate_score(seq1, seq2, len1, len2, startpoint):
    """calculates alignment score based on a specified startpoint"""
    
    ## create necessary variables ##
    matched = "" ## to hold string displaying which indices match ##
    score = 0 ## starts with zero alignments ##

    ## calculate alignment score ##
    for index in range(len2): ## loop through the shorter sequence to find matches ##
        if (index + startpoint) < len1: ## ensures startpoint is small enough so that the sequences overlap ##
            if seq1[index + startpoint] == seq2[index]: ## if the bases in the same position in seq1 and seq2 match ##
                matched += "*" ## * indicates a match ##
                score += 1 ## increment score to record the match ##
            else:
                matched += "-" ## - indicates no match ##

    return score

def run_alignment(fastafile1, fastafile2):
    """ Finds the best match (highest alignment score) for the two sequences """

    ## extract sequences from files ##
    seq1, seq2, len1, len2 = extract(fastafile1, fastafile2)

    ## create necessary variables ##
    best_align = None
    best_score = -1 ## new_score needs to be bigger than best_score in the first loop, and there is a chance new_score could be 0 ##

    ## find best alignment ##
    for startpoint in range(len1): ## loops through what will be the various starting points / alignments to check ##
        new_score = calculate_score(seq1, seq2, len1, len2, startpoint)
        if new_score > best_score:
            best_align = "." * startpoint + seq2 ## update the pattern for best_align every time a new highest score is reached ##
            best_score = new_score ## updates with highest score ##
    
    ## write results into file ##
    f = open('../results/align_seqs_fasta_results.txt', 'w')
    f.write(f"Best alignment score: {best_score} \n")
    f.write(f"\nBest alignment: \n{best_align} \n{seq1}")
    f.close()
    print("Results saved into ../results/align_seqs_fasta_results.txt")

### ENTRY POINT ###
def main(argv):
    """Determines which files to run"""

    if len(argv)>=2:
        try: ## if user has entered all required parameters ##
            print(f"Running script with {argv[1]} and {argv[2]}")
            run_alignment(argv[1], argv[2])

        except: ## if user has entered enough required parameters but of wrong format ##
            print("Error: input parameters of the wrong format.")

    elif len(argv)>1: ## if user has entered parameters, but not enough ##
            print("Error: not enough input parameters.", "\n")

    else: ## if user has entered no parameters ##
        print("Running script with default values.")
        run_alignment("../data/407228326.fasta", "../data/407228412.fasta")

if __name__ == "__main__": 
    """Makes sure the main function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)