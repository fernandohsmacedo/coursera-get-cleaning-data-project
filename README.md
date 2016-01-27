# README for coursera-get-cleaning-data-project
Author: Fernando Henrique Macedo

Date: 2016-01-27
  
Version: 1.0

## Summary
This is the final project's repository for Get and Cleaning Data course by Johns Hopkins University on Coursera.
  
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. For details of the inputs, transformations and outputs, see the [Code Book](https://github.com/fernandohsmacedo/coursera-get-cleaning-data-project/blob/master/CodeBook.md).

### The data
The datasets represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
  
Here are the data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

### Tidy data
Tidy data characteristics:
- Each variable forms a column
- Each observation forms a row
- Each type of observational unit forms a table
  
Common problems on a messy data:
- Column headers are values, not variable names.
- Multiple variables are stored in one column.
- Variables are stored in both rows and columns.
- Multiple types of observational units are stored in the same table.
- A single observational unit is stored in multiple tables.

## Project Structure
```
.
+-- _output
|   +-- average_tidy_data.csv
|   +-- tidy_data.csv
+-- _.gitignore
+-- _CodeBook.md
+-- _README.md
+-- _run_analysis.R
```
  
- output/ -> Folder containing the output in "csv" format. See CodeBook.md for more details.
- .gitignore -> Instrucions for ignoring files on commits.
- CodeBook.md -> A code book that describes the variables, the data, and any transformations or work performed to clean up the data.
- README.md -> This file.
- run_anaysis.R -> The code used to perfom the transformations of the data.

## References

- Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
- <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
- <https://www.coursera.org/learn/data-cleaning/>
- [WICKHAM, H., Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)
