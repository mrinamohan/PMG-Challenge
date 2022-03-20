# CSV Combiner

Write a command line program that takes several CSV files as arguments. Each CSV file (found in the fixtures directory of this repo) will have the same columns. Your script should output a new CSV file to stdout that contains the rows from each of the inputs along with an additional column that has the filename from which the row came (only the file's basename, not the entire path). Use filename as the header for the additional column.

# Input & Output
Run combiner.py on the terminal with the command below:

`python combiner.py accessories.csv clothing.csv household_cleaners.csv > combined.csv`

combined.csv is the the new csv file with all the data combined.

# References
1) https://pandas.pydata.org/docs/user_guide/io.html#csv-text-files
2) https://www.geeksforgeeks.org/how-to-merge-multiple-csv-files-into-a-single-pandas-dataframe/
