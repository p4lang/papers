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

action terminate_tunnel_inner_ipv4(bd, vrf,
        rmac_group, bd_label,
        uuc_mc_index, bcast_mc_index, umc_mc_index,
        ipv4_unicast_enabled, igmp_snooping_enabled)
        {
    modify_field(ingress_metadata.bd, bd);
    modify_field(ingress_metadata.vrf, vrf);
    modify_field(ingress_metadata.outer_dscp, ingress_metadata.lkp_ip_tc);
    // This implements tunnel in 'uniform' mode i.e. the TTL from the outer IP
    // header is copied into the header of decapsulated packet.
    // For decapsulation, the TTL in the outer IP header is copied to
    // ingress_metadata.lkp_ip_ttl in validate_outer_ipv4_packet action
    modify_field(ingress_metadata.outer_ttl, ingress_metadata.lkp_ip_ttl);
    add_to_field(ingress_metadata.outer_ttl, -1);

    modify_field(ingress_metadata.lkp_mac_sa, inner_ethernet.srcAddr);
    modify_field(ingress_metadata.lkp_mac_da, inner_ethernet.dstAddr);
    modify_field(ingress_metadata.lkp_ip_type, IPTYPE_IPV4);
    modify_field(ingress_metadata.lkp_ipv4_sa, inner_ipv4.srcAddr);
    modify_field(ingress_metadata.lkp_ipv4_da, inner_ipv4.dstAddr);
    modify_field(ingress_metadata.lkp_ip_proto, inner_ipv4.protocol);
    modify_field(ingress_metadata.lkp_ip_tc, inner_ipv4.diffserv);
    modify_field(ingress_metadata.lkp_l4_sport, ingress_metadata.lkp_inner_l4_sport);
    modify_field(ingress_metadata.lkp_l4_dport, ingress_metadata.lkp_inner_l4_dport);

    modify_field(ingress_metadata.ipv4_unicast_enabled, ipv4_unicast_enabled);
    modify_field(ingress_metadata.igmp_snooping_enabled, igmp_snooping_enabled);
    modify_field(ingress_metadata.rmac_group, rmac_group);
    modify_field(ingress_metadata.uuc_mc_index, uuc_mc_index);
    modify_field(ingress_metadata.umc_mc_index, umc_mc_index);
    modify_field(ingress_metadata.bcast_mc_index, bcast_mc_index);
    modify_field(ingress_metadata.bd_label, bd_label);
    modify_field(ingress_metadata.l3_length, inner_ipv4.totalLen);
}

table tunnel {
    reads {
        ingress_metadata.tunnel_vni : exact;
        ingress_metadata.tunnel_type : exact;
        inner_ipv4 : valid;
    }
    actions {
        terminate_tunnel_inner_ipv4;
    }
    size : VNID_MAPPING_TABLE_SIZE;
}
