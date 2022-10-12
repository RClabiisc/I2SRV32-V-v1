#!/usr/bin/env python
import textwrap

filenames = ['Sbase.hex', 'riscv-spike.hex']
with open('code.hex', 'w') as outfile:
    for fname in filenames:
        with open(fname) as infile:
            for line in infile:
                outfile.write(line)
	    infile.close()
outfile.close()
