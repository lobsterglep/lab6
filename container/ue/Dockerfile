FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 在 builder stage 下載並編譯 srsUE，需支援 ZMQ。

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 安裝 UE runtime 需要的 library 與測試工具。
# TODO: 從 builder 複製 srsUE binary / ZMQ RF plugin，並準備 UE 設定檔。
# TODO: 設定 container 啟動時執行 srsUE。
