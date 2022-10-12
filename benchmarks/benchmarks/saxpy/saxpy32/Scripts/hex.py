#!/usr/bin/env python3

import config
import textwrap
import linecache as lc
import subprocess

infile=open('temphex','r')
outfile=open('temp.hex','w')
for lineno,line in enumerate(infile):
  if('@' in line):
    continue
  else:
    line=textwrap.wrap(line,8)
    for i in range(len(line)):
      outfile.write(line[i])
      outfile.write(",\n") 
    if(config.sperateInstrDataMemory==True):
      if('0000006f' in line):
        outfile.close();
        outfile=open('memory.hex','w');

infile.close()
outfile.close()

filenames = ['base.hex', 'temp.hex']
with open('code.coe', 'w') as outfile:
    for fname in filenames:
        with open(fname) as infile:
            for line in infile:
                outfile.write(line)
            infile.close()
outfile.close()

## Create 8 .coe files for 8 vector Memory Banks
# Start Address of Vector Memory : 0x0010_0000 (Changed from 0x0004_0000 earlier)
file_list=[]
#vmem_start = 65536
vmem_start = 65536*4
init_offset = 3+1024
first_line = "MEMORY_INITIALIZATION_RADIX=16;\n"
second_line="MEMORY_INITIALIZATION_VECTOR=\n"
for i in range(8):
    filename = 'file'+str(i)
    file_list.append(filename)
    file_list[i] = open("dmem_bank"+str(i)+".coe",'w')
    file_list[i].writelines([first_line,second_line])

start_line = vmem_start + init_offset
offset = 0
while 1:
    line1 = lc.getline("code.coe", offset + start_line)
    modval = offset%8
    if line1 != '':
        file_list[modval].write(line1)
        offset+=1;
    else:
        break
        print ("DMEM Files Written Successfully .\n")


##########################################################
# Truncate code.coe to 262144 (+ 2 Lines) (1MB)
xmem_size = 262144 + 2
line_no=0
with open('xmem.coe', 'w') as outfile:
    with open('code.coe') as infile:
        for line in infile:
            if line_no < xmem_size:
                outfile.write(line)
                line_no = line_no + 1
            else:
                break
                print("xmem.coe Written Successfully")
    infile.close()
outfile.close()


