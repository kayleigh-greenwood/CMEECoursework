
## imports
import csv
import sys
import doctest

## functions

def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
    
    >>> is_an_oak("quercus")
    True
    >>> is_an_oak("QUERCUS")
    True
    >>> is_an_oak("quercuss")
    False
    >>> is_an_oak("containsquercus")
    False
    >>> is_an_oak("Fagus")
    False
    >>> is_an_oak(" Quercus")
    True
    >>> 
    
    """
    name = name.strip()
    if len(name) == 7:
        return name.lower().startswith('quercus')
    else:
        return False
    # the purpose of .lower() here is to test the lowercase version of 'name' to check if it is quercus

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()