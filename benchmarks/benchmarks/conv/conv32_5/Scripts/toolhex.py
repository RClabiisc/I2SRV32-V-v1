#!/usr/bin/env python
import textwrap

infile=open('riscv-spike.hex','r')
outfile=open('riscv.hex','w')
for line in infile:
	line=textwrap.wrap(line,8)
    	for i in range(len(line)):
      		outfile.write(line[i])
		outfile.write(",\n")
infile.close()
outfile.close()

filenames = ['base.hex', 'riscv.hex']
with open('Outputfiles/Toolcode.coe', 'w') as outfile:
    for fname in filenames:
        with open(fname) as infile:
            for line in infile:
                outfile.write(line)
	    infile.close()
outfile.close()
