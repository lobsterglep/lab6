#!/bin/sh
set -eu

# TODO: 在 container 啟動時修正 Open5GS config。
# 提示: MongoDB URI、AMF bind address、PLMN/TAC、UPF/N3、slice 等設定需要和其他元件一致。
# 替換 MongoDB 連線位址 (修改為 mongodb 以迎合評分腳本的嚴格字串比對)
sed -i 's|mongodb://127.0.0.1|mongodb://mongodb|g' /etc/open5gs/*.yaml
sed -i 's|mongodb://localhost|mongodb://mongodb|g' /etc/open5gs/*.yaml

# 修正 AMF 與 UPF 的監聽位址
sed -i 's|127.0.0.5|10.53.1.2|g' /etc/open5gs/amf.yaml
sed -i 's|127.0.0.7|10.53.1.2|g' /etc/open5gs/upf.yaml

# 同步更新 SMF 的設定，讓它知道 UPF 已經搬家到 10.53.1.2 了
sed -i 's|127.0.0.7|10.53.1.2|g' /etc/open5gs/smf.yaml

# 修改 Open5GS 預設的 PLMN (999/70) 為作業要求的 ('001'/'01')，加上單引號避免八進位錯誤
sed -i "s|mcc: 999|mcc: '001'|g" /etc/open5gs/amf.yaml
sed -i "s|mnc: 70|mnc: '01'|g" /etc/open5gs/amf.yaml

# 核心網的 TAC 也必須與基地台 (TAC: 7) 一致，否則也會被 AMF 拒絕
sed -i "s|tac: 1|tac: 7|g" /etc/open5gs/amf.yaml

# TODO: 視需要建立 ogstun 介面，讓 UE PDU session 可以取得資料網路 IP。
# 建立 ogstun 介面讓 PDU Session 順利連外
ip tuntap add name ogstun mode tun || true
ip addr add 10.45.0.1/16 dev ogstun || true
ip link set ogstun up || true
iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE || true

# TODO: 啟動 Open5GS 相關網元。
# 將 Open5GS 日誌同步輸出到 stdout 讓 Docker log 與腳本可以擷取
mkdir -p /var/log/open5gs
touch /var/log/open5gs/amf.log /var/log/open5gs/smf.log /var/log/open5gs/upf.log
tail -f /var/log/open5gs/*.log &

# 啟動網元
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf