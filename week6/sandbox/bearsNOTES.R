### NOTE: there is another file in sandbox explaining the code in even more detail ###
#####################################
########### QUESTION 1 ##############
#####################################
# QUESTION: Identify which positions are SNPs (polymorphic, meaning that they have more than one allele)
# HINT: SNPs are positions where there are more than one allele

### clear workspace ###
  rm(list=ls())

### import dataset ###
  data <- read.csv("../data/bears.csv",, stringsAsFactors = FALSE, header = FALSE, colClasses=rep("character", 10000))
    # must set col classes as character otherwise 'T' allele could be read as TRUE
  dim(data)
    # important because view() can hide things
  data[,1]
    # prints first column
  data[1,(c(1:100))]
    # prints first 100 columns of row 1


### loop to find SNPs ###
  snps <- vector()
    # pre-allocate vector to store locations of SNPs
  for (i in 1:ncol(data)){
    # loops 'i' through the numbers 1 to the number of columns in data
    # this means each vector of allele locations can be looped over
    if (length(unique(data[,i]))==2){
      # if there are two different alleles at that location
      snps <- c(snps, i)
        # add the column number to the SNPs vector
    }
  }
  # loop to detect columns in which there are more than one type of allele

  cat("\nNumber of SNPs is", length(snps))
    # prints snp results to terminal

### alternative method (apply) to find SNPs ###
  # he then challenges us to convert this for loop to the apply function
    # define function
      myfunc <- function(v){
        x <- length(unique(v))
      return(x)
      }
    # find the number of uniques per column
      uniques <- apply(data, 2, myfunc)
      
 # find which columns have more than one unique ###
      snps <- uniques != 1
      
### count number of SNPs ###
      n_snpsn <- sum(snps)
      
### visualize allele frequencies 
      plot(uniques)
      
#####################################
########### QUESTION 2 ##############
#####################################
# QUESTION: calculate, print and visualize allele frequencies for each SNP
# HINT: to proceed i need to understand how he used length(unique()) before as those same methods are used in this answer
      
      
### reduce dataset now that we know where snps are ###

data <- data[,snps]



### HOW TO PERFORM FOR ONE SNP ###
### alleles in this snp ###
data[,1]
# prints all alleles from that column

unique(data[,1])
# returns types of allele in that vector (A, C)

alleles <- unique(data[,1])
# stores info in variable so each letter can be accessed

cat("\nSNP", i, "with alleles", alleles)
# prints alleles in snp

### frequencies of the alleles ###

alleles[1]
# returns first letter (A)

alleles[2]
# returns second letter(C)

data[,1]==alleles[1]
# returns list of all indexes showing at which locations in the column, the allele is A
# returns in format of TRUE's and FALSE's

which(data[,1]==alleles[1])
# returns list of only the location indexes at which the result is TRUE
# returns location of every index of A

length(which(data[,1]==alleles[1]))
# returns count of occurences of allele (A in this instance)

length(which(data[,1]==alleles[1]))/nrow(data)
# returns relative frequency of allele (A)

freq_a1<-length(which(data[,1]==alleles[1]))/nrow(data)
# stores relative frequency in a variable

freq_a2<-length(which(data[,1]==alleles[2]))/nrow(data)
# stores same result for second allele

### determine minor allele ###
minor_allele <- alleles[which.min(c(freq_a1, freq_a2))]
# stores letter of which allele is the minor one
freq_minor_allele <- c(freq_a1, freq_a2)[which.min(c(freq_a1, freq_a2))]
# stores relative frequency of the minor allele

cat(" the minor allele is",minor_allele ,"and the minor allele frequency (MAF) is", freq_minor_allele)
# prints minor allele to terminal


### HOW TO PERFORM FOR EVERY SNP ###
frequencies<- c()
for (i in 1:ncol(data)){
  ### alleles in this snp ###
  
  alleles <- unique(data[,i])
  # stores info in variable so each letter can be accessed
  
  cat("\nSNP", i, "with alleles", alleles)
  # prints alleles in snp
  
  ### frequencies of the alleles ###
  
  freq_a1<-length(which(data[,i]==alleles[1]))/nrow(data)
  # stores relative frequency of allele 1 in variable
  
  freq_a2<-length(which(data[,i]==alleles[2]))/nrow(data)
  # stores same result for allele 2
  
  ### determine minor allele ###
  
  minor_allele <- alleles[which.min(c(freq_a1, freq_a2))]
  # stores letter of which allele is the minor one
  
  freq_minor_allele <- c(freq_a1, freq_a2)[which.min(c(freq_a1, freq_a2))]
  # stores relative frequency of the minor allele
  
  cat(" the minor allele is",minor_allele ,"and the minor allele frequency (MAF) is", freq_minor_allele)
  # prints minor allele to terminal
  
  ### store frequencies ###
  
  frequencies <- c(frequencies, freq_minor_allele)
}

### plot histogram ###
hist(frequencies)

### plot frequencies ###
plot(frequencies, type="h")

#####################################
########### QUESTION 3 ##############
#####################################

# calculate and print genotype frequencies for each SNP

### alleles in the first SNP ###

alleles <- unique(data[,1])
cat("\nSNP", i, "with alleles", alleles)

### frequencies of the alleles ###

freq_a1<-length(which(data[,1]==alleles[1]))/nrow(data)

freq_a2<-length(which(data[,1]==alleles[2]))/nrow(data)

### the minor allele ###

minor_allele <- alleles[which.min(c(freq_a1, freq_a2))]
# minor allele = least frequent
# alternative allele = most frequent
freq_minor_allele <- c(freq_a1, freq_a2)[which.min(c(freq_a1, freq_a2))]

cat(" the minor allele is",minor_allele ,"and the minor allele frequency (MAF) is", freq_minor_allele)


genotype_counts <- c(0, 0, 0)
# pre-allocate empty vector
# genotypes (eg aa, aA, Aa, AA) will be counted by occurences of one certain allele (eg A)
# don't need to count matches for entire "Aa" and "AA" for example
# as because they add to 1, we only need to count frequency of one allele (eg A) and we can work out the genotype frequencies
# we choose to count the alternative allele here

# eg imagine c(0,0,0) above was c(x,y,z)
# x = 0 occurences of the allele (eg aa)
# y = 1 occurence of the allele (eg aA, Aa)
# z = 2 occurences of the allele (eg AA)

nsamples <- 20
# number of individuals
# remember there are two rows of code for every individual
# one row represents each chromosome
# individual inherits two genes for any one characteristic
# two rows are needed to represent these two genes for any one individual

### accessing (looping through) genotype for individuals ###


## Example for column 1 ##
for (j in 1:nsamples){
  ### creating index numbers for accessing the genotype, not directly accessing
    # eg for individual 1, create numbers 1 and 2 to access those rows
    # and for individual 2, create numbers 3 and 4 to access those rows
    haplotype_index <- c( (j*2)-1, (j*2) )
    # haplotype index will store the rows in which that individuals' information is
  
  ### count the minor allele instances
    genotype <- length(which(data(haplotype_index[,1]==minor_allele)))
    # [,1] determines first column and haplotype_index determines which rows
    
  ### increase the counter for the corresponding genotype
    genotype_counts[genotype_index] <- genotype_counts[genotype_index]+1
  
}
    



### HOW TO PERFORM FOR EVERY SNP ###
frequencies<- c()
for (i in 1:ncol(data)){
  ### genotypes in this snp ###

  genotypes <- split(data[,i], ceiling(seq_along(data[,i])/2))
  # stores info in variable so each letter can be accessed
  
  cat("\nSNP", i, "with alleles", alleles)
  # prints alleles in snp
  
  ### frequencies of the alleles ###
  
  freq_a1<-length(which(data[,i]==alleles[1]))/nrow(data)
  # stores relative frequency of allele 1 in variable
  
  freq_a2<-length(which(data[,i]==alleles[2]))/nrow(data)
  # stores same result for allele 2
  
  ### determine minor allele ###
  
  minor_allele <- alleles[which.min(c(freq_a1, freq_a2))]
  # stores letter of which allele is the minor one
  
  freq_minor_allele <- c(freq_a1, freq_a2)[which.min(c(freq_a1, freq_a2))]
  # stores relative frequency of the minor allele
  
  cat(" the minor allele is",minor_allele ,"and the minor allele frequency (MAF) is", freq_minor_allele)
  # prints minor allele to terminal
  
  ### store frequencies ###
  
  frequencies <- c(frequencies, freq_minor_allele)
}


## testing
i <- data[,1]

genotypes <- split(data[,i], ceiling(seq_along(data[,i])/2))
# split rows up into pairs of alleles to make up genotype for each bear

for (i in genotypes){
  genotypes[i]<- paste(unlist(genotypes[i]), collapse='')
}
genotypey<- paste(unlist(genotypes), collapse='')
genotypex <- unique(genotypes)
# store list of different genotypes so can be referenced

length(which(genotypes==genotypex[1]))
# returns count of genotypex[1]
# can't do as trying to compare list to list


#####################################
########### QUESTION 4 ##############
#####################################
# calculate (observed) homozygosity and heterozygosity for each SNP

# calculate expected genotype counts for each SNP and test for HWE

# calculate, print and visualise inbreeding coefficient for each SNP deviating from HWE

### refine dataset to only polymorphic sites ###
polydata <- data.frame(c(data$V30, data$V40))# doesnt work
View(polydata)

col1 <- data$V30
col2 <- data$V40

polydata <- data.frame(col1, col2)

polydata %>% rename(Column30=col1, Column40=col2)

# polydata contains only columns which were polymorphic

### calculate