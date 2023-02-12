cd /openpose/

/openpose/build/examples/openpose/openpose.bin \
      --image_dir /data/in/image \
      --hand --disable_blending --display 0 \
      --write_json /data/out/json \
      --write_images /data/out/image \
      --num_gpu 1 --num_gpu_start 0
