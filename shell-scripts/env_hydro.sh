#!/bin/bash

helpMessage() {
   echo "Usage: `basename $0` env_name [-hv]"
   echo "Options:"
   echo -e "\tenv_name: name of the environment for creation"
   echo -e "\th: see this message"
   echo -e "\tv: get software version"
   exit
}

while getopts "hv" OPT
do
    case $OPT in
        h) helpMessage ;;
        v)
            echo "`basename $0` version 0.1"
            exit ;;
        ?) helpMessage ;;
    esac
done
shift $((OPTIND-1))

if [ -z $1 ]
then
    helpMessage
fi

export LC_ALL="en_US.UTF-8"

echo ""
echo "Create enviroment"
conda create -n $1 -y
source activate $1 || conda activate $1

echo ""
echo "Install dependencies"
conda install r-irkernel -y
conda install r-devtools -y
conda install r-ncdf4 -y
conda install r-rncdf -y
conda install netcdf4 -y
conda install -c conda-forge r-ncdf4 -y
conda install -c conda-forge r-rgdal -y
conda install libxml2 libcurl openssl -y

echo ""
echo "Install rwrfhydro in R"
R -e 'devtools::install_github("NCAR/rwrfhydro", upgrade="never")'

echo ""
echo "Install jupyterlab"
conda install jupyterlab -y

echo ""
echo "done."
