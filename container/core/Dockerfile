FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# TODO: 安裝 Open5GS core 需要的套件與工具。
# TODO: 安裝並設定 Open5GS，讓 core container 可以啟動 AMF/SMF/UPF 等網元。
# TODO: 複製並啟用 core 的 entrypoint / supervisor 設定。
# 1. 先安裝必要的系統工具與 GPG 金鑰管理工具
RUN apt-get update && \
    apt-get install -y software-properties-common curl gnupg iproute2 iptables tcpdump supervisor iputils-ping

# 2. 匯入 MongoDB 官方 GPG 金鑰與 Repository (讓 Open5GS 可以滿足 apt 依賴)
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# 3. 加入 Open5GS PPA 並執行安裝
RUN add-apt-repository ppa:open5gs/latest && \
    apt-get update && \
    apt-get install -y open5gs

# 4. 複製設定檔
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]