#!/usr/bin/sh
pres=$(pwd)
cp temphex Scripts/
cd Scripts
python3 hex.py
pwd
echo "Copying coe files ..."
cp -r *.coe ../Outputfiles/
cd ../
#cp code.coe $pres
#cd $pres
echo "Finish "
ls -lrt
