#!/usr/bin/env python3
import numpy as np
import pandas as pd

def lower_triangle_to_full_matrix(filename):
    num_lines_in_file = sum(1 for line in open(filename))
    distances = []
    sample_names = []

    with open(filename) as f:
        next(f) # skip sample count line
        for line in f:
            elements = line.strip().split('\t')
            sample_names.append(elements[0])
            row = [float(e) for e in elements[1:]]
            row.extend([0.0] * (num_lines_in_file-1-len(row)))
            distances.append(row)
        np_array = np.asarray(distances)
        index_upper = np.triu_indices(num_lines_in_file-1)
        np_array[index_upper] = np_array.T[index_upper]
        with open('dist_table.phy', 'w') as out_f:
            out_f.write(f'\t{len(distances)}\n')
        return pd.DataFrame(np_array, columns=sample_names, index=sample_names).to_csv('dist_table.phy', mode='a', sep='\t', index=True, header=False)

if __name__ == '__main__':
    import sys
    lower_triangle_to_full_matrix(sys.argv[1])
