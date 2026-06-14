FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 在 builder stage 下載並編譯 srsUE，需支援 ZMQ。
# 安裝編譯所需的套件
RUN apt-get update && apt-get install -y cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev libzmq3-dev git libconfig++-dev libboost-program-options-dev

# 編譯包含 srsUE 的 srsRAN_4G 專案
RUN git clone https://github.com/srsran/srsRAN_4G.git && \
    cd srsRAN_4G && mkdir build && cd build && \
    cmake ../ -DENABLE_ZEROMQ=ON && make -j$(nproc) && make install

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 安裝 UE runtime 需要的 library 與測試工具。
# TODO: 從 builder 複製 srsUE binary / ZMQ RF plugin，並準備 UE 設定檔。
# TODO: 設定 container 啟動時執行 srsUE。
RUN apt-get update && apt-get install -y libsctp1 libyaml-cpp0.7 libzmq5 libmbedcrypto7 libfftw3-single3 libconfig++9v5 iproute2 iputils-ping libboost-program-options1.74.0

COPY --from=builder /usr/local/bin/srsue /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY ue.conf /etc/srsran/

RUN ldconfig

CMD ["srsue", "/etc/srsran/ue.conf"]