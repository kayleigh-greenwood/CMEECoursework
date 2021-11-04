#### function ####

doit <- function(x){
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique values!")
        }
    }

#### generate population ####

set.seed(1345) # again, to get the same result for illustration
# only used for debugging, remove once finished.
# used to get the same result for illustration

popn <- rnorm(50)

hist(popn)

#### lapply ####

# lapply(1:15, function(i) doit(popn))


# gave 4 means (out of the 15 we asked for) and the ran error message saying there werent enough unique values
# stops after one of the lines encounters an error and doesnt run the rest
# use try to avoid this

#### lapply using try ####

result <- lapply(1:15, function(i) try(doit(popn), FALSE))

# in this run, it only gave 13 means (out of the 15 we asked for) but no error message as above
# the FALSE modifier for the try command suppresses any error message, but result will still contain them
# prints error when line doesnt work but continues running the rest
# the full error messages are stored in result

#### store results manually using a loop ####

result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
    }