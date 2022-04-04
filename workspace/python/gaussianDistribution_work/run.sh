#!/bin/bash

until [ -z $1 ] 
do
    echo "\$1 is $1"
    # remove venv directory
    if [ $1 == "--init" ] || [ $1 == "-i" ]; then
        if [ -e venv ]; then
            rm -rf venv
        fi
    fi

    shift 1
done

# create virtual environment
if [ ! -e venv ]; then
    python3 -m venv venv

    act_bin=`find ./venv -name "activate"`

    # activate virtual environment
    echo ${act_bin}
    source ${act_bin}
    if [ $? -ne 0 ]; then
        echo "activate is failed."
        exit 1
    fi
    
    # install packages
    pip install click
    pip install pyyaml
else
    act_bin=`find ./venv -name "activate"`
    echo ${act_bin}
    source ${act_bin}
    if [ $? -ne 0 ]; then
        echo "activate is failed."
        exit 1
    fi
fi

# run program
python GaussianDistribution.py --total 10000000 --group 1000
