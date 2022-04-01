#!/bin/sh

# remove venv directory
if [ -e venv ]; then
    rm -rf venv
fi

# create virtual environment
python3 -m venv venv

# activate virtual environment
act_bin=`find ./venv -name "activate"`
echo $act_bin
source ${act_bin}
if [ $? -ne 1 ]; then
    echo "activate is fail."
    #exit 1
fi

# install packages
pip install click

# run program
