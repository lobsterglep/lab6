# Lab 6 Demo
這是 lab6 的作業規範模版

如果你覺得 `README` 有任何不合理的問題, 請盡快到 e3 詢問

## 0. Prerequisites
準備 ubuntu 24.04 lts

安裝 docker, 既然你 lab5 有做成功, 我想這應該不是什麼大問題

安裝 wireshark:
```
sudo apt update
sudo apt install wireshark
```

## 1. Build the 5G Mobile Network
注意:
- 不要更改 `container` 名稱或架構
- `eval` 內的 demo code 可以修改, 但必須解釋清楚原因
- Part F 的 `iperf3` 測試必須走 UE 的 PDU session: `10.45.0.2 -> 10.45.0.1`。  
不要直接測 Docker network IP: `10.53.1.5 -> 10.53.1.2`, 否則就不是 5G throughput。
- 使用 `eval/rebuild.sh` 重新套用 config, 會比 `build-docker.sh & run-docker.sh` 安全,  
但是不會顯示詳細資訊, 注意: 會清空 MongoDB subscribers 並且再註冊

### Topology
```text
+-----------------------------+
| lab6-mongodb (10.53.1.4)    |
+-------------+---------------+
              |
              | MongoDB
              |
+-------------+---------------+
| lab6-core (10.53.1.2)       |
+-------------+---------------+
  AMF (10.53.1.2:38412)
              |
              | N2 / NGAP over SCTP
              |
+-------------+---------------+
| lab6-gnb (10.53.1.3)        |
+-------------+---------------+
              |
              | ZMQ virtual radio
              | *:2000 <-> 10.53.1.5:2001
              |
+-------------+---------------+
| lab6-ue (10.53.1.5)         |
+-----------------------------+

UE PDU session IP: 10.45.0.2
```

## 2. Demo
在 demo 前, 你必須保證:
- 整套系統有存在一個 `IMSI = 001010000000001, TAC = 7` 的 ue, 記得檢查你的所有 config
- part F (3) 自由發揮, 其他的 ue 的編號隨意

## 3. Evaluation Items
| part | eval file | score | description |
| :- | :- | :- | :- |
| `a1` | `eval/a1.sh` | 10 % | 檢查 MongoDB/Open5GS 安裝、Open5GS 網元狀態，以及 Open5GS 是否正確連到 MongoDB |
| `a2` | `eval/a2.sh` | 5 % | 測試 subscriber 新增、列印與 container 重啟後資料仍存在 |
| `b` | `eval/b.sh` | 15 % | 檢查 srsRAN gNB 安裝、啟動，以及 gNB 是否成功連線 Open5GS AMF |
| `c` | `eval/c.sh` | 15 % | 測試 UE 透過 ZMQ virtual radio 完成 registration 與 PDU session，並取得 UE IP |
| `d` | `eval/d.sh` | 15 % | 擷取 core `n3` 封包，輸出 pcap，並用於 Wireshark signaling analysis |
| `e1` | `eval/e1.sh` | 7 % | 修改 PLMN 後，檢查 UE registration / PDU session 是否仍能成功 |
| `e2` | `eval/e2.sh` | 7 % | 修改 TAC 後，檢查 UE registration / PDU session 是否仍能成功 |
| `e3` | `eval/e3.sh` | 6 % | 修改 AMF address 後，觀察 gNB NG setup / UE registration 失敗或成功的關鍵 log |
| `f1` | `eval/f1.sh` | 4 % | 比較 10 MHz 與 20 MHz bandwidth 設定下的 gNB config 與 iperf3 throughput |
| `f2` | `eval/f2.sh` | 3 % | 比較不同 MCS 設定下的 gNB config 與 iperf3 throughput |
| `f3` | 自由發揮 | 3 % | Scheduler comparison：比較 round robin 與 proportional fair 的 throughput、fairness、resource utilization |
| `g1` | `eval/g1.sh` | 4 % | 檢查多 slice 設定、subscriber slice profile，以及 Open5GS registration / NSSAI log |
| `g2` | 自由發揮 | 4 % | Traffic differentiation / performance measurement：產生 eMBB 與 URLLC traffic，量測 throughput、packet loss、RTT |
| `g3` | 自由發揮 | 2 % | Wireshark analysis：擷取 NGAP/NAS，辨識 Allowed NSSAI、Configured NSSAI、Requested NSSAI |

## 4. bonus
EC446B 有 USRP B210, 如果有需要做 bonus 需要 email TA 約時間
