FROM tensorflow/tensorflow:1.15.5-gpu-py3
#https://github.com/sangyun884/HR-VITON/issues/45

# reference: https://jdhao.github.io/2022/05/05/nvidia-apt-repo-public-key-error-fix/
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80

# Additional reference: https://gitlab.com/nvidia/container-images/cuda/-/issues/158
RUN export this_distro="$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')" \
    && export this_version="$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F'=' '{print $2}' | sed 's/[^0-9]*//g')" \
    && apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/cuda/repos/${this_distro}${this_version}/x86_64/3bf863cc.pub" \
    && apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/machine-learning/repos/${this_distro}${this_version}/x86_64/7fa2af80.pub"

# get the latest version of opencv        
RUN apt-get update &&  \
        DEBIAN_FRONTEND=noninteractive \
        apt-get install -y -qq \
        wget git libopencv-dev
 
RUN python -m pip install --upgrade pip && \
    pip install matplotlib opencv-python==4.5.4.60 Pillow scipy \
    azure-eventhub azure-eventhub-checkpointstoreblob-aio ipykernel

WORKDIR /