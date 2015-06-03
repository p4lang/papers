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

action set_valid_outer_ipv4_packet() {
    modify_field(ingress_metadata.lkp_ip_type, IPTYPE_IPV4);
    modify_field(ingress_metadata.lkp_ipv4_sa, ipv4.srcAddr);
    modify_field(ingress_metadata.lkp_ipv4_da, ipv4.dstAddr);
    modify_field(ingress_metadata.lkp_ip_proto, ipv4.protocol);
    modify_field(ingress_metadata.lkp_ip_tc, ipv4.diffserv);
    modify_field(ingress_metadata.lkp_ip_ttl, ipv4.ttl);
    modify_field(ingress_metadata.l3_length, ipv4.totalLen);
}

action set_malformed_outer_ipv4_packet() {
}

table validate_outer_ipv4_packet {
    reads {
        ipv4.version : exact;
        ipv4.ihl : exact;
        ipv4.ttl : exact;
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
    }
    actions {
        set_valid_outer_ipv4_packet;
        set_malformed_outer_ipv4_packet;
    }
    size : VALIDATE_PACKET_TABLE_SIZE;
}
