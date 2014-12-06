FindInFiles
===========

Set of R functions to look for search terms in files

This set of R functions are the result of a <a href="http://www.active-analytics.com/blog/finding-things-in-files/" target="_blank"></a> written about searching for items in text files. It could be a tool for developers want to search for functions in a code file or files without paging through multiple lines of text and searching by eye.

There are three main functions

## findInFile()

The `findInFile` function allows the user to look for a search `pattern` in a file, it returns a data frame with the file path, the line locations where the search pattern was located and the contents of the line. The user can also specify whether the search is alphabetically case sensitive with the `case` argument (deafults to `TRUE`).

```
# Usage: Searching a file for the pattern "someFunction"
findInFile(fPath = "path/to/file", pattern = "someFunction", case = TRUE)
```

## findInFiles()

The `findInFiles` function allows users to look for a search patterns in multiple files `fPaths`.

```
# Usage: Searching a vector or list of files for the the search pattern "someFunction"
findInFiles(fPaths = c("vector", "or", "list", "of", "file", "paths"), pattern = "someFunction")
```

## findInFolder()

The `findInFolder` function allows users to look for search patterns in files located in a folder. The function works by allowing the user to specify a search pattern for the file names `fpattern` and then specifying the search pattern they would like to find in the files `pattern`.

```
# Usage: Searching the files in a folder with file names ending with ".r" or ".R" for the search pattern "someFunction" ...
findInFolder(fPath = "path/to/folder", pattern = "someFunction", fpattern = "[.][rR]$")
```
## Contact

For more information contact chibisi@active-analytics.com
