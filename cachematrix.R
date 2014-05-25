## Brief overviews of what each function does are found below (preceeding 
## individual functions)

## More detailed comments describing smaller steps are included in the function;
## although some steps could be written in a single line, all functions are
## written in out in full multi-line form (with spacing between individual 
## functions) for the sake of clarity


## This function creates a special "matrix" object that can cache its inverse. 
## Specifically, makeCacheMatrix creates a list with a function to (1) set the 
## value of the matrix; (2) get the value of the matrix; (3) set the value of 
## the inverse of the matrix; (4) get the value of the matrix inverse

makeCacheMatrix <- function(x = matrix()) {
    ## initialize the value of the matrix inverse 'inv' to NULL
    inv <- NULL
    
    ## set the value of the matrix 'x' equal to the input matrix 'y'; set the 
    ## value of the inverse matrix to NULL to clear the cache when 'x' is 
    ## changed
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    
    ## simply return the value of 'x'
    get <- function() {
        x
    }
    
    ## set the value of 'inv' equal to the calculated value of the inverse 
    ## matrix; note: this value is not calculated by the setinv function
    setinv <- function(inverse) {
        inv <<- inverse
    }
    
    ## return the value of the matrix inverse 'inv'
    getinv <- function() {
        inv
    }
    
    ## return a list with each of the above functions representing the 
    ## "special" matrix
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. cacheSolve first checks whether the inverse has 
## already been calculated using the getinv() function within the object
## defined by makeCacheMatrix; if so, the cacheSolve retrieves the inverse from 
## the cache and prints a message.

## If the inverse of the matrix has not been calculated (its value is NULL),
## then the solve() function is used to calculate the inverse; this value is 
## then returned by cacheSolve.

cacheSolve <- function(x, ...) {
    ## set the value of the matrix inverse 'inv' equal to the stored matrix
    ## inverse value for 'x'
    inv <- x$getinv()
    
    ## if the value of 'inv' is not NULL, this indicates that the inverse of 'x'
    ## has already been calculated and cached; in this case, return 'inv' and 
    ## exit the function
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    
    ## if 'inv' is NULL, then the inverse of 'x' has not been cached and must be
    ## calculated; set 'data' equal to the value of 'x'
    data <- x$get()
    
    ## calculate the inverse of 'data' using the solve() function
    inv <- solve(data, ...)
    
    ## cache the newly calculated inverse matrix 
    x$setinv(inv)
    
    ## return a matrix that is the inverse of 'x'
    inv 
}
