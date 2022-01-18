#!/usr/bin/env python3

"""align two DNA sequences such that they are as similar as possible
"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

### imports ###
import csv
import sys

### script ###

def assign(data):
    """assign sequences and lengths of them into variables to be returned"""
    with open(data, 'r') as f: #opens the file to read
        csvread = csv.reader(f) # creates a csvread variable and reads the file
        seq1 = 0
        seq2 = 0
        for row in csvread:
            if seq1 == 0: # if seq1 variable hasn't been filled yet,
                seq1 = row[0] # assign the row to seq1
            else: # if seq1 variable has been filled
                seq2 = row[0] # assign the row to seq2

    l1 = len(seq1) # l1 is length of the longest, l2 that of the shortest
    l2 = len(seq2)
    if l1 >= l2: # if l1 is larger than l2
        s1 = seq1 # Assign the longer sequence s1, and the shorter to s2
        s2 = seq2
    else: # if l2 is larger than l1
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

    return s1, s2, l1, l2

def calculate_score(s1, s2, l1, l2, startpoint):
    """computes a score for one specific alignment of two sequences, based on a specific startpoint of the shorter sequence
    by returning the number of matches starting from an abitrary startpoint chosen by the user"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2): # l2 is the shorter length
        if (i + startpoint) < l1: # if the startpoint is small enough that the bases still overlap
            if s1[i + startpoint] == s2[i]: # if the base in the same position in seq1 and seq1 match,
                matched = matched + "*" # add a * to the matched variable to indicate a match
                score = score + 1 # add to score to indicate a match
            else:
                matched = matched + "-" # add a - to the matched variable to indicate no match

    # some formatted output
    print("." * startpoint + matched) # print full stops up until where the startpoint was, then print the matched variable
    # which contains the pattern of which bases are matching vs not matching           
    print("." * startpoint + s2) # display the correspondin alignment of seq2 (the shorter sequence)
    print(s1) # display the longer sequence underneath
    print("Score:", score) 
    print(" ")

    return score

def calculate_best(s1, s2, l1, l2):
    # now try to find the best match (highest score) for the two sequences
    my_best_align = None
    my_best_score = -1 # need to set to -1 because in the first loop, we need z to be bigger than my_best_score so that the first loop runs
    # for this reason, if we set my_best_score to 0, the loop still might not run because there is a chance z could be 0
    # z could be 0 because there could be alignments where there are no matches
    # this is why we must set it to -1

    for i in range(l1): # Loops through what will be the various starting points / alignments to check
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # update the pattern for my_best_align every time a new highest score is reached.
            my_best_score = z # updates with highest score
    
    return my_best_align, my_best_score

### ENTRY POINT ###
def main(argv):
    """main entry point of the program"""
    
    data = '../data/sequences.csv'

    s1, s2, l1, l2 = assign(data)

    my_best_align, my_best_score = calculate_best(s1, s2, l1, l2)
    

    # write results into file
    f = open('../results/align_seqs_results.txt', 'w')
    f.write("Best alignment: \n")
    f.write(str(my_best_align))
    f.write("\n")
    f.write(str(s1))
    f.write("\nBest alignment score: \n")
    f.write(str(my_best_score))
    f.write("\n")

    f.close()

    print("Results saved into ../results/align_seqs_results.txt")


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)


## TO DO: format output so that the .txt file makes more sense
## TO DO: format printed info so that it tells the user that the results have been saved to the results file
## TO DO: convert to python programme
