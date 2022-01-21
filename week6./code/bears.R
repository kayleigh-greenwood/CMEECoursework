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

### use apply to find SNPs ###
    # define function
      myfunc <- function(v){
        x <- length(unique(v))
      return(x)
      }
    # find the number of uniques per column
      uniques <- apply(data, 2, myfunc)
      
    # find which columns have more than one unique ###
      snps <- vector()
      snps <- uniques != 1
      
### count and print number of SNPs ###
      n_snps <- sum(snps)
      
      cat("\nNumber of SNPs is", n_snps)
      # prints snp results to terminal
      
### visualize allele frequencies 
      plot(uniques)
      
#####################################
########### QUESTION 2 ##############
#####################################
# QUESTION: calculate, print and visualize allele frequencies for each SNP
# HINT: to proceed i need to understand how he used length(unique()) before as those same methods are used in this answer
      
      
### reduce dataset now that we know where snps are ###
  data <- data[,snps]

### calculate allele frequencies for each snp ###
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
# QUESTION: calculate and print genotype frequencies for each SNP

####### EXAMPLE RUN-THROUGH OF THE CODE FOR LOCATION 1 #######

### alleles in the first SNP ###
  alleles <- unique(data[,1])
  # stores types of alleles in that location (eg "A" "C")
  cat("\nSNP", 1, "with alleles", alleles)

### frequencies of the alleles ###
  freq_a1<-length(which(data[,1]==alleles[1]))/nrow(data)
  # stores frequency of first allele (eg 0.55)
  freq_a2<-length(which(data[,1]==alleles[2]))/nrow(data)
  # stores frequency of second allele (eg 0.45)

### the minor allele ###
  minor_allele <- alleles[which.min(c(freq_a1, freq_a2))]
  # minor allele = least frequent
  # alternative allele = most frequent
  # determines and stores which allele is least frequenct (eg "C")
  freq_minor_allele <- c(freq_a1, freq_a2)[which.min(c(freq_a1, freq_a2))]
  # stores the frequency of the minor allele (eg 0.45)

  cat(" the minor allele is",minor_allele ,"and the minor allele frequency (MAF) is", freq_minor_allele)

##### EXAMPLE RUN-THROUGH OF CODE FOR INDIVIDUAL 1 ONLY ############
  
### genotype frequencies ###
  genotype_counts <- c(0, 0, 0)
  # will store the count for amount of genotypes that store 0 versions of the minor allele, 1 version of the minor allele, and 2 versions of the minor allele
  # For example in this case (# of CC, # of AC/CA, # of AA)
  # genotypes (eg AA, CA, AC, CC) will be counted by occurences of the minor` allele (eg A)
  # because the two alleles add to 1, we only need to count frequency of one allele (eg A) and we can work out the genotype frequencies

  ### accessing genotype ###
    # state that we are examining individual 1
      j <- 1

    # creating index numbers for accessing the genotype, not directly accessing
      # eg for individual 1, create numbers 1 and 2 to access those rows
      haplotype_index <- c( (j*2)-1, (j*2) )
      # haplotype index will store the rows in which that individuals' information is
      # for each individual passed to the for loop, this line identifies which rows to analyse for its genetic information in 'data'
    
    # count the allele instances
      data[haplotype_index,1]
      # produces the genotype for the individual (eg "A" "A")
      # [,1] determines first column and haplotype_index determines which rows
      data[haplotype_index,1]==minor_allele
      # produces TRUE/FALSE for if either allele is the same as the minor allele (eg FALSE FALSE)
      which(data[haplotype_index,1]==minor_allele)
      # counts the amount of TRUE's in the above statement (eg 0)
      # product is empty
      # this is also the amount of the minor allele in this individual
      length(which(data[haplotype_index,1]==minor_allele))
      # adding length means that the integer 0 is produces and the answer isnt empty (eg 0)
      genotype <- length(which(data[haplotype_index,1]==minor_allele))
      #  stores the amount of minor alleles for that individual in variable 'genotype' (eg 0)
  
  ### increase the counter for the corresponding genotype
    genotype_index=genotype+1
    # so we want to put the result from 'genotype' into the genotype_counts vector
    # genotype can have three values: 0, 1, 2
    # genotype_counts has three indices: 1, 2, 3
    # to get the genotype result to match an indice, we must add 1 to the genotype
    # this is stored in 'genotype index' so we know where in the vector this result must go
    # genotype_index=genotype+1
    # IF genotype= 0, genotype_index= 1
    # IF genotype= 1, genotype_index= 2
    # IF genotype= 2, genotype_index= 3

  genotype_counts[genotype_index] <- genotype_counts[genotype_index]+1
   # IF genotype_index=1, the first index will be increased by 1
   # IF genotype_index=2, the second index will be increased by 1
   # IF genotype_index=3, the third index will be increased by 1
  
  
  


## trying to understand
  
  genotype_counts[1,2,3]= genotype_counts[CC, AC/CA, AA]
  genotype = amount of minor alleles in that individual
  
  # IF genotype= 0, the first index will be increased by 1
  # IF genotype= 1, the second index will be increased by 1
  # IF genotype= 2, the third index will be increased by 1
  
  # in this scenario, as genotype is 0, this will add one to the first position in the vector,
  # indicating that this individual has 0 instances of the alternative allele
  
  # THIS IS WRONG, IT HAS 2 VERSIONS OF THE ALTERNATIVE ALLELE




###############################
### genotype frequencies ###
genotype_counts <- c(0, 0, 0)
# will store the count for amount of genotypes that store 0 versions of the alternative allele, 1 version of the alternative allele, and 2 versions of the alterntive allele
# For example in this case (# of CC, # of AC/CA, # of AA)
# genotypes (eg AA, CA, AC, CC) will be counted by occurences of the alternative allele (eg A)
# because the two alleles add to 1, we only need to count frequency of one allele (eg A) and we can work out the genotype frequencies

nsamples <- 20
# number of individuals
# remember there are two rows of code for every individual
# one row represents each chromosome
# individual inherits two genes for any one characteristic
# two rows are needed to represent these two genes for any one individual

### accessing (looping through) genotype for individuals ###


## Example for column 1 ##
## state that we are examining individual 1
j <- 1

### creating index numbers for accessing the genotype, not directly accessing
# eg for individual 1, create numbers 1 and 2 to access those rows
# and for individual 2, create numbers 3 and 4 to access those rows
haplotype_index <- c( (j*2)-1, (j*2) )
# haplotype index will store the rows in which that individuals' information is
# for each individual passed to the for loop, this line identifies which rows to analyse for its genetic information in 'data'

### count the minor allele instances
data[haplotype_index,1]
# produces the genotype for the individual (eg "A" "A")




genotype <- length(which(data(haplotype_index[,1]==minor_allele)))
# [,1] determines first column and haplotype_index determines which rows

### increase the counter for the corresponding genotype
genotype_counts[genotype_index] <- genotype_counts[genotype_index]+1

}





###############################
for (j in 1:nsamples){
  ### creating index numbers for accessing the genotype, not directly accessing
    # eg for individual 1, create numbers 1 and 2 to access those rows
    # and for individual 2, create numbers 3 and 4 to access those rows
    haplotype_index <- c( (j*2)-1, (j*2) )
    # haplotype index will store the rows in which that individuals' information is
    # for each individual passed to the for loop, this line identifies which rows to analyse for its genetic information in 'data'
  
  ### count the minor allele instances
    genotype <- length(which(data(haplotype_index[,1]==minor_allele)))
    # [,1] determines first column and haplotype_index determines which rows
    
  ### increase the counter for the corresponding genotype
    genotype_counts[genotype_index] <- genotype_counts[genotype_index]+1
  
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