#' @name FindInFiles
#' 
#' @title Function to find a search pattern in a file and return the line numbers and the line text
#' 
#' @param fPath character for the file path where the search term should be searched
#' @param pattern character for the regular expression pattern to be searched
#' @param case logical for whether the search should be case sensitive, defaults to TRUE
#' 
#' @return data frame containing the fPath, the line numbers and the content of the lines where 
#'          the search term was found. If the search term was not found or the file did not exist,
#'          a line number zero is returned with either the error message or NA respectively
#' 
#' @author Chibisi Chima-Okereke
findInFile <- function(fPath, pattern, case = TRUE){
  # Get file contents as string
  fString <- tryCatch(scan(fPath, what = character(), sep = "\n", quiet = TRUE), 
                      error = function(e)e, warning = function(w){})
  if(class(fString)[1] == "simpleError")
    return(data.frame(File = fPath, Line = 0, Content = "Error, File Not Found!"))
  # Finding item in the file
  if(case){
    locs <- grep(pattern, fString)
  }else{
    fString <- casefold(fString)
    pattern <- casefold(pattern)
    locs <- grep(pattern, fString)
  }
  output <- data.frame(File = fPath, Line = 0, Content = NA)
  if(length(locs) > 0)
    output <- data.frame(File = fPath, Line = locs, Content = fString[locs])
  
  return(output)
}

#------------------------------------------------------------------------------------------------

#' @name findInFiles
#' @title Function to find a search pattern in multiple files
#' 
#' @param fPaths character vector containing the paths that should be searched
#' @param pattern character for the regular expression pattern to be searched
#' @param case logical for whether the search should be case sensitive, defaults to TRUE
#' @param asDF logical for whether the results should be bound together to return a data frame
#'              it defaults to TRUE
#' @return returns a data frame (or list!) of file names, line numbers and line content where the 
#'        search pattern has been matched
#' @note This is built directly over the findInFile function
#' 
#' @author Chibisi Chima-Okereke
findInFiles <- function(fPaths, pattern = NULL, case = TRUE, asDF = TRUE){
  output <- lapply(fPaths, findInFile, pattern = pattern, case = case)
  if(asDF)
    output <- do.call(rbind.data.frame, output)
  return(output)
}

#------------------------------------------------------------------------------------------------

#' @name findInFolder
#' @title Function to find search pattern in files in a folder
#' 
#' @param fPath character for path to folder where files should be searched
#' @param pattern character for the regular expression pattern to be searched
#' @param fpattern character for the regular expression for file name patterns to be searched
#' @param case logical for whether the search should be case sensitive, defaults to TRUE
#' @param asDF logical for whether the results should be bound together to return a data frame
#'              it defaults to TRUE
#' @return returns a data frame (or list!) of file names, line numbers and line content where the 
#'        search pattern has been matched
#' @author Chibisi Chima-Okereke
findInFolder <- function(fPath, pattern, fpattern = NULL, case = TRUE, asDF = TRUE){
  fPaths <- list.files(fPath, fpattern, all.files = TRUE, full.names = TRUE)
  output <- findInFiles(fPaths, pattern, case, asDF)
  return(output)
}
