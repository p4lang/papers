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

action set_valid_outer_unicast_packet() {
    modify_field(ingress_metadata.lkp_pkt_type, L2_UNICAST);
    modify_field(ingress_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(ingress_metadata.lkp_mac_da, ethernet.dstAddr);
    modify_field(ingress_metadata.lkp_mac_type, ethernet.etherType);
}

action set_valid_outer_multicast_packet() {
    modify_field(ingress_metadata.lkp_pkt_type, L2_MULTICAST);
    modify_field(ingress_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(ingress_metadata.lkp_mac_da, ethernet.dstAddr);
    modify_field(ingress_metadata.lkp_mac_type, ethernet.etherType);
}

action set_valid_outer_broadcast_packet() {
    modify_field(ingress_metadata.lkp_pkt_type, L2_BROADCAST);
    modify_field(ingress_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(ingress_metadata.lkp_mac_da, ethernet.dstAddr);
    modify_field(ingress_metadata.lkp_mac_type, ethernet.etherType);
}

table validate_outer_ethernet {
    reads {
        ethernet.dstAddr : ternary;
    }
    actions {
        set_valid_outer_unicast_packet;
        set_valid_outer_multicast_packet;
        set_valid_outer_broadcast_packet;
    }
    size : VALIDATE_PACKET_TABLE_SIZE;
}
