#!/bin/bash

docker run --gpus all -e DISPLAY=$DISPLAY \
                   -v /tmp/.X11-unix/:/tmp/.X11-unix \
                   -v ${PWD}/data/input/image:/data/in/image \
                   -v ${PWD}/data/output/json:/data/out/json \
                   -v ${PWD}/data/output/image:/data/out/image \
                   -v ${PWD}/data/detect-pose.sh:/data/detect-pose.sh \
                   -it openpose:cuda10.0-cudnn7-devel sh -c "chmod +x /data/detect-pose.sh && /data/detect-pose.sh"