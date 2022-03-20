import sys
import os
import pandas as pa
import unittest
def combiner(files):
    
    # Function to check validity of all files
    def _check_valid_files(files):
    
        # Check if names for files are given
        if not files: return None

        init_col = None
        for name in files:
        
            # Checking if file exists
            if not os.path.exists(name): raise IOError('File Not Found Error: No such file')
            
            # Checking for "csv" extension
            if not name.endswith('.csv'): raise Exception('Not a valid CSV file.')

            col = pa.read_csv(name, nrows=1).columns
            if not init_col: init_col = set(col)

            # Checking if columns are same as initial file
            elif init_col != set(col): raise Exception('Columns are not same')

        return True

    # Checking for all validity conditions
    error = _check_valid_files(files)

    for names in files:
        
        if error:
            col = list(pa.read_csv(names, nrows=1).columns) + ['filename']

            # Adding columns in the output file
            print(','.join(col))

            error = False

        # Reading the csv file in chunks to avoid memory error
        chunk_size = 64000
        for chunk in pa.read_csv(names, chunksize=chunk_size, low_memory=False):

            # Creating the "filename" column
            chunk['filename'] = names.split('/')[-1]
            
            print(chunk.to_csv(header=False, index=None, chunksize=chunk_size))

# Main Function
def main():
    files = sys.argv[1:]
   
    combiner(files)
    
if __name__ == '__main__': main()