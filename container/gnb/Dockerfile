FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 在 builder stage 下載並編譯 srsRAN gNB，需支援 ZMQ。
# 安裝編譯所需的套件
RUN apt-get update && apt-get install -y cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev libzmq3-dev git

# 編譯支援 ZMQ 的 srsRAN_Project
RUN git clone --branch release_24_04 https://github.com/srsran/srsRAN_Project.git && \
    cd srsRAN_Project && mkdir build && cd build && \
    cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON && make -j$(nproc) && make install

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 安裝 gNB runtime 需要的 library。
# TODO: 從 builder 複製 gNB binary，並準備 gNB 設定檔。
# TODO: 設定 container 啟動時執行 gNB。
RUN apt-get update && apt-get install -y libsctp1 libyaml-cpp0.7 libzmq5 libmbedcrypto7 libfftw3-single3

COPY --from=builder /usr/local/bin/gnb /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY gnb.yaml /etc/srsran/

RUN ldconfig

CMD ["gnb", "-c", "/etc/srsran/gnb.yaml"]