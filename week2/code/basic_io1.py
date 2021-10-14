#############################
# FILE INPUT
#############################


# Open a file for reading
f = open('../sandbox/test.txt', 'r')

# use "implicit" for loop:
# if the object is a file, python will cycle over its' lines
for line in f:
    print(line)
# prints each line from the file

# close the file
f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0: 
        #checks if line is empty
        #.strip() removes any leading or trailing spaces
        print(line)
# makes sure that each element (line of text) is separated by only one empty line

f.close()


