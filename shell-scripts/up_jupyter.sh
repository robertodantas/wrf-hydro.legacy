#!/bin/bash

helpMessage() {
   echo "Usage: `basename $0` -s n [options]"
   echo "s:"
   echo -e "\t1: allocate available node"
   echo -e "\t2: mirrors localhost with hpv. Needed options: -n -c"
   echo -e "\t3: run jupyterlab. Needed options: -n -p"
   echo "Options:"
   echo -e "\th: see this message"
   echo -e "\tv: get software version"
   echo -e "\tn: node name"
   echo -e "\tp: jupyter port"
   echo -e "\tc: hpc alias connection"
   echo -e "\te: enviroment name"
   echo "Examples:"
   echo -e "\tstep 1: `basename $0` -s 1"
   echo -e "\tstep 2: `basename $0` -s 2 -n c019 -c ogun"
   echo -e "\tstep 2: `basename $0` -s 2 -n c019 -p 8889 -c ogun"
   echo -e "\tstep 3: `basename $0` -s 3 -p 8889"
   echo -e "\tstep 3: `basename $0` -s 3 -p 8889 -e env_jupyter"
   exit
}

while getopts "hvs:n:p:c:e:" OPT
do
    case $OPT in
        h) helpMessage ;;
        v)
            echo "`basename $0` version 0.1"
            exit ;;
        s) STEP=$OPTARG ;;
        n) NODE=$OPTARG ;;
        p) PORT=$OPTARG ;;
        c) CON=$OPTARG ;;
        e) ENV=$OPTARG ;;
        ?) helpMessage ;;
    esac
done
shift $((OPTIND-1))

if [ -z $STEP ]
then
    helpMessage
fi

case $STEP in
    1)
        idle_node=$(sinfo -p standard -t idle -N | awk 'NR==2 {print $1}')
        echo "node allocation: $idle_node"
        salloc -w $idle_node -J wrfhydro
        ;;
    2)
        if [ -z $NODE ]
        then
            helpMessage
        fi

        if [ -z $PORT ]
        then
            PORT='8888'
        fi

        ssh -L 127.0.0.1:$PORT:$NODE:$PORT $CON
        ;;
    3)
        if [ -z $PORT ]
        then
            PORT='8888'
        fi

        if [ -z $ENV ]
        then
            helpMessage
        fi

        source activate $ENV || conda activate $ENV
        jupyter-lab --ip 0.0.0.0 --port $PORT --no-browser
        ;;
    ?)
        helpMessage
        exit ;;
esac
