ARG from
FROM $from

ARG cuda

COPY install_tensorrt.sh /tmp/install_tensorrt.sh
RUN /tmp/install_tensorrt.sh $cuda

ENV CUDA_INSTALL_DIR=/usr/local/cuda
ENV CUDNN_INSTALL_DIR=/usr/local/cuda
