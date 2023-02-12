#!/bin/bash

export FILE_ID='1Mqpse5Gen4V4403wFEpv3w3JAsWw2uhk'
export BASE_DIRECTORY='/pgn'
export DATA_DIRECTORY='/data-extraction'
export MODEL_DL_PATH=${BASE_DIRECTORY}/${DATA_DIRECTORY}/CIHP_pgn.zip
export CHECKOUT_DIRECTORY=${BASE_DIRECTORY}/CIHP_PGN

if [ ! -d ${BASE_DIRECTORY} ] ; then
    mkdir ${BASE_DIRECTORY}   
fi
 
if [ ! -d ${BASE_DIRECTORY}/${DATA_DIRECTORY} ] ; then
    mkdir ${BASE_DIRECTORY}/${DATA_DIRECTORY}
fi

if [ ! -d ${CHECKOUT_DIRECTORY} ] ; then
    cd ${BASE_DIRECTORY}
    git clone  https://github.com/Engineering-Course/CIHP_PGN.git
fi

if [ ! -d ${CHECKOUT_DIRECTORY}/checkpoint/CIHP_pgn ] ; then 
    # download pretrained model
    wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://drive.google.com/uc?export=download&id=${FILE_ID}' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=${FILE_ID}" \
        -O ${MODEL_DL_PATH} && rm -rf /tmp/cookies.txt

    unzip ${MODEL_DL_PATH} -d ${BASE_DIRECTORY}/${DATA_DIRECTORY}

    # prepare the checkout directory
    cd ${CHECKOUT_DIRECTORY} && \
        mkdir -p ${CHECKOUT_DIRECTORY}/checkpoint && \
        mv ${BASE_DIRECTORY}/${DATA_DIRECTORY}/CIHP_pgn ${CHECKOUT_DIRECTORY}/checkpoint/CIHP_pgn        
fi