birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

print(type(birds))
## LATIN NAMES ##

# loop version

bird_latin = []
for species in birds:
    bird_latin.append(species[0])

print(bird_latin)

#lc version
bird_latin = [species[0] for species in birds]
print(bird_latin)

## NORMAL NAMES ##

# For loop
normal_names = []
for species in birds:
    normal_names.append(species[1])

print(normal_names)


# list comprehension that creates list of common names for each species in birds


normal_names = [species[1] for species in birds]
print(normal_names)

## BODY MASS ##

# for loops

body_mass = []
for species in birds:
    body_mass.append(species[2])

print(body_mass)

# list comprehension 

body_mass = [species[2] for species in birds]
print(body_mass)

# write each as for loop and convert




# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 