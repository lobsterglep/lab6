#!/bin/sh
set -eu

# TODO: 在 container 啟動時修正 Open5GS config。
# 提示: MongoDB URI、AMF bind address、PLMN/TAC、UPF/N3、slice 等設定需要和其他元件一致。

# TODO: 視需要建立 ogstun 介面，讓 UE PDU session 可以取得資料網路 IP。

# TODO: 啟動 Open5GS 相關網元。
