#!/usr/bin/env python3

"""align two DNA sequences such that they are as similar as possible
"""

### imports ###
import csv


### script ###

with open('../data/sequences.csv', 'r') as f: #opens the file to read
    csvread = csv.reader(f) # creates a csvread variable and reads the file
    seq1 = 0
    seq2 = 0
    for row in csvread:
        if seq1 == 0:
            seq1 = row[0]
        else:
            seq2 = row[0]

print(seq1)
print(seq2)


# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths




# # A function that computes a score by returning the number of matches starting
# # from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """compute a score by returning the number of matches starting from an abitrary startpoint"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
# print(my_best_align)
# print(s1)
# print("Best alignment score:", my_best_score)

f = open('../results/align_seqs_results.txt', 'w')
f.write(str(my_best_align))
f.write("\n")
f.write("Best alignment score:")
f.write("\n")
f.write(str(my_best_score))
f.write("\n")

f.close()

## TO DO: format output so that the .txt file makes more sense
## TO DO: format printed info so that it tells the user that the results have been saved to the results file

exit