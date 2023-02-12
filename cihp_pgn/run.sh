#!/bin/bash

# run and get output
docker run --gpus all \
                   -v ${PWD}/src:/pgn \
                   -v ${PWD}/data/input/image:/data/input-image \
                   -v ${PWD}/data/output/image:/data/output-image \
                   -v ${PWD}/data/test.sh:/data/test.sh \
                   -v ${PWD}/data/initialise.sh:/data/initialise.sh \
                   -it tensorflow:1.15.5-gpu-cihp-dependencies sh -c \
                                      "chmod +x /data/initialise.sh && /data/initialise.sh && \
                                        chmod +x /data/test.sh && /data/test.sh"