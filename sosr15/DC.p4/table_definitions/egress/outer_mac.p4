// Copyright 2015, Barefoot Networks, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

action rewrite_unicast_mac(smac) {
    modify_field(ethernet.srcAddr, smac);
    modify_field(ethernet.dstAddr, egress_metadata.mac_da);
}

action rewrite_multicast_mac(smac) {
    modify_field(ethernet.srcAddr, smac);
    modify_field(ethernet.dstAddr, 0x01005E000000);
    modify_field(ethernet.dstAddr, ipv4.dstAddr, 0x7FFFFF);
    add_to_field(ipv4.ttl, -1);
}

table outer_mac {
    reads {
        egress_metadata.smac_idx : exact;
        ipv4.dstAddr : ternary;
    }
    actions {
        nop;
        rewrite_unicast_mac;
        rewrite_multicast_mac;
    }
    size : SOURCE_MAC_TABLE_SIZE;
}
