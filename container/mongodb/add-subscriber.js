// TODO: 新增 Open5GS subscriber profile。
// 提示: 需要設定 IMSI、security key/opc、slice、DNN/session、QoS/AMBR 等欄位。
// 提示: subscriber 的 PLMN/IMSI/slice 需要和 UE、gNB、core 設定一致。
db.subscribers.insertOne({
    "imsi": "001010000000001",
    "security": {
        "k": "465B5CE8B199B49FAA5F0A2EE238A6BC",
        "amf": "8000",
        "op": null,
        "opc": "E8ED289DEBA952E4283B54E88E6183CA"
    },
    "ambr": {
        "downlink": { "value": 1, "unit": 3 },
        "uplink": { "value": 1, "unit": 3 }
    },
    "slice": [
        {
            "sst": 1,
            "sd": "000001",
            "default_indicator": true,
            "session": [
                {
                    "name": "internet",
                    "type": 3,
                    "pcc_rule": [],
                    "ambr": {
                        "downlink": { "value": 1, "unit": 3 },
                        "uplink": { "value": 1, "unit": 3 }
                    },
                    "qos": {
                        "index": 9,
                        "arp": { "priority_level": 8, "pre_emption_capability": 1, "pre_emption_vulnerability": 1 }
                    }
                }
            ]
        }
    ]
});