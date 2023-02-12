#!/bin/bash

cd /pgn/CIHP_PGN

cp /data/input-image/*.png ./datasets/images

python ./inf_pgn.py

cp -r  ./datasets/output/* /data/output-image
