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

field_list entropy_hash_fields {
    inner_ethernet.srcAddr;
    inner_ethernet.dstAddr;
    inner_ethernet.etherType;
    inner_ipv4.srcAddr;
    inner_ipv4.dstAddr;
    inner_ipv4.protocol;
}

field_list_calculation entropy_hash {
    input {
        entropy_hash_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

action f_copy_ipv4_to_inner() {
    add_header(inner_ethernet);
    copy_header(inner_ethernet, ethernet);
    add_header(inner_ipv4);
    copy_header(inner_ipv4, ipv4);
    modify_field(inner_ipv4.ttl, ingress_metadata.ttl);
    remove_header(ipv4);
}

action f_copy_ipv4_udp_to_inner() {
    f_copy_ipv4_to_inner();
    add_header(inner_udp);
    copy_header(inner_udp, udp);
    remove_header(udp);
}

action f_copy_ipv4_tcp_to_inner() {
    f_copy_ipv4_to_inner();
    add_header(inner_tcp);
    copy_header(inner_tcp, tcp);
    remove_header(tcp);
}

action f_insert_vxlan_header() {
    add_header(udp);
    add_header(vxlan);

    modify_field_with_hash_based_offset(udp.srcPort, 0, entropy_hash, 16384);
    modify_field(udp.dstPort, UDP_PORT_VXLAN);
    modify_field(udp.checksum, 0);
    modify_field(udp.length_, ingress_metadata.l3_length);
    add_to_field(udp.length_, 30); // 8+8+14

    modify_field(vxlan.flags, 0x8);
    modify_field(vxlan.vni, egress_metadata.vnid);
}

action f_insert_ipv4_header(proto) {
    add_header(ipv4);
    modify_field(ipv4.protocol, proto);
    modify_field(ipv4.ttl, ingress_metadata.ttl);
    modify_field(ipv4.version, 0x4);
    modify_field(ipv4.ihl, 0x5);
}

action ipv4_vxlan_inner_ipv4_udp_rewrite() {
    f_copy_ipv4_udp_to_inner();
    f_insert_vxlan_header();
    f_insert_ipv4_header(IP_PROTOCOLS_UDP);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 50);
}

action ipv4_vxlan_inner_ipv4_tcp_rewrite() {
    f_copy_ipv4_tcp_to_inner();
    f_insert_vxlan_header();
    f_insert_ipv4_header(IP_PROTOCOLS_UDP);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 50);
}

action f_insert_genv_header() {
    add_header(udp);
    add_header(genv);

    modify_field_with_hash_based_offset(udp.srcPort, 0, entropy_hash, 16384);
    modify_field(udp.dstPort, UDP_PORT_GENV);
    modify_field(udp.checksum, 0);
    modify_field(udp.length_, ingress_metadata.l3_length);
    add_to_field(udp.length_, 30); // 8+8+14

    modify_field(genv.ver, 0);
    modify_field(genv.oam, 0);
    modify_field(genv.critical, 0);
    modify_field(genv.optLen, 0);
    modify_field(genv.protoType, 0x6558);
    modify_field(genv.vni, egress_metadata.vnid);
}

action ipv4_genv_inner_ipv4_udp_rewrite() {
    f_copy_ipv4_udp_to_inner();
    f_insert_genv_header();
    f_insert_ipv4_header(IP_PROTOCOLS_UDP);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 50);
}

action ipv4_genv_inner_ipv4_tcp_rewrite() {
    f_copy_ipv4_tcp_to_inner();
    f_insert_genv_header();
    f_insert_ipv4_header(IP_PROTOCOLS_UDP);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 50);
}

action f_insert_nvgre_header() {
    add_header(gre);
    add_header(nvgre);
    modify_field(gre.proto, 0x6558);
    modify_field(gre.K, 1);
    modify_field(gre.C, 0);
    modify_field(gre.S, 0);
    modify_field(nvgre.tni, egress_metadata.vnid);
}

action ipv4_nvgre_inner_ipv4_udp_rewrite() {
    f_copy_ipv4_udp_to_inner();
    f_insert_nvgre_header();
    f_insert_ipv4_header(IP_PROTOCOLS_GRE);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 42);
}

action ipv4_nvgre_inner_ipv4_tcp_rewrite() {
    f_copy_ipv4_tcp_to_inner();
    f_insert_nvgre_header();
    f_insert_ipv4_header(IP_PROTOCOLS_GRE);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 42);
}

action f_insert_erspan_v2_header() {
    add_header(gre);
    add_header(erspan_v2_header);
    modify_field(gre.proto, GRE_PROTOCOLS_ERSPAN_V2);
    modify_field(erspan_v2_header.version, 1);
    modify_field(erspan_v2_header.vlan, egress_metadata.vnid);
}

action ipv4_erspan_v2_inner_ipv4_udp_rewrite() {
    f_copy_ipv4_udp_to_inner();
    f_insert_erspan_v2_header();
    f_insert_ipv4_header(IP_PROTOCOLS_GRE);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 46);
}

action ipv4_erspan_v2_inner_ipv4_tcp_rewrite() {
    f_copy_ipv4_tcp_to_inner();
    f_insert_erspan_v2_header();
    f_insert_ipv4_header(IP_PROTOCOLS_GRE);
    modify_field(ipv4.totalLen, ingress_metadata.l3_length);
    add_to_field(ipv4.totalLen, 46);
}


table tunnel_rewrite {
    reads {
        egress_metadata.tunnel_type : exact;
        ipv4 : valid;
        tcp : valid;
        udp : valid;
    }
    actions {
/*
 * These actions encapsulate a packet.
 * Sequence of modifications in each action is:
 * 1. Add inner L3/L4 header. The type of these headers should be same as that
 *    of the packet being encapsulated.
 * 2. Copy outer L3/L4 headers to inner L3/L4 headers.
 * 3. Remove outer L3/L4 headers.
 * 4. Add outer L3 header and encapsulation header.
 * For each encapsulation type, we need 8 actions to handle 8 different
 * combinations:
 * Outer L3 (IPv4) X Inner L3 (IPv4) X Inner L4 (TCP/UDP)
 */
        ipv4_vxlan_inner_ipv4_udp_rewrite;
        ipv4_vxlan_inner_ipv4_tcp_rewrite;
        ipv4_genv_inner_ipv4_udp_rewrite;
        ipv4_genv_inner_ipv4_tcp_rewrite;
        ipv4_nvgre_inner_ipv4_udp_rewrite;
        ipv4_nvgre_inner_ipv4_tcp_rewrite;
        ipv4_erspan_v2_inner_ipv4_udp_rewrite;
        ipv4_erspan_v2_inner_ipv4_tcp_rewrite;
    }
    size : TUNNEL_REWRITE_TABLE_SIZE;
}
