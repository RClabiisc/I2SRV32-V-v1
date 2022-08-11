# To-Do
* Add all the IPs in the created project in design sources.
* The IPs are for **Xilinix Vivado Version 2020.2**.
* To work for different versions, upgrade the IPs.
* After adding and upgrading, do **Reset Output products** and **Generate Output products** for all the IPs. These options can be seen by right clicking on each IP.
* For **MainMem IP**, COE file should be added. 
* For DMEM_* IPs also COE file should need to add. These are called as vector memory banks or scratchpad memory. 
* The COE files are different for each benchmark. The COE files for matrixmultiplication is in benchmarks/matrixmultiplication/Outputfiles/ directory. 
* After adding COE file, **Reset Output products** and **Generate Output products**  again for all IPs where COE files are added.
* The Reset and Genearte options should be done whenever COE file is changed.
# How to add COE file
* Double-click on the IP, goto **Other options** tab. Enable **Load Init File** in **Memory Initilization** section and **Browse** for the required COE file from the directory mentioned.
