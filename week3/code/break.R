# Intro to breaking out of loops using 'break'

i <- 0 
# Set i as 0
    while(i < Inf) {
        # sets infinite while loop
        if (i == 10) { 
            break 
            } 
            # Break out of the while loop when i hits 10
        else { 
            cat("i equals " , i , " \n")
            # print value of i
            i <- i + 1 # Add 1 until 10 is reached
    }
}