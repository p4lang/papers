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

action set_l2_rewrite() {
    modify_field(egress_metadata.routed, FALSE);
}

action set_ipv4_unicast_rewrite(smac_idx, dmac) {
    modify_field(egress_metadata.smac_idx, smac_idx);
    modify_field(egress_metadata.mac_da, dmac);
    modify_field(egress_metadata.routed, TRUE);
    modify_field(ipv4.ttl, ingress_metadata.ttl);
}

action set_ipv4_vxlan_rewrite(outer_bd, tunnel_src_index, tunnel_dst_index,
        smac_idx, dmac) {
    modify_field(egress_metadata.bd, outer_bd);
    modify_field(egress_metadata.smac_idx, smac_idx);
    modify_field(egress_metadata.mac_da, dmac);
    modify_field(egress_metadata.tunnel_src_index, tunnel_src_index);
    modify_field(egress_metadata.tunnel_dst_index, tunnel_dst_index);
    modify_field(egress_metadata.routed, TRUE);
    modify_field(egress_metadata.tunnel_type, EGRESS_TUNNEL_TYPE_IPV4_VXLAN);
}

action set_ipv4_geneve_rewrite(outer_bd, tunnel_src_index, tunnel_dst_index,
        smac_idx, dmac) {
    modify_field(egress_metadata.bd, outer_bd);
    modify_field(egress_metadata.smac_idx, smac_idx);
    modify_field(egress_metadata.mac_da, dmac);
    modify_field(egress_metadata.tunnel_src_index, tunnel_src_index);
    modify_field(egress_metadata.tunnel_dst_index, tunnel_dst_index);
    modify_field(egress_metadata.routed, TRUE);
    modify_field(egress_metadata.tunnel_type, EGRESS_TUNNEL_TYPE_IPV4_GENEVE);
}

action set_ipv4_nvgre_rewrite(outer_bd, tunnel_src_index, tunnel_dst_index,
        smac_idx, dmac) {
    modify_field(egress_metadata.bd, outer_bd);
    modify_field(egress_metadata.smac_idx, smac_idx);
    modify_field(egress_metadata.mac_da, dmac);
    modify_field(egress_metadata.tunnel_src_index, tunnel_src_index);
    modify_field(egress_metadata.tunnel_dst_index, tunnel_dst_index);
    modify_field(egress_metadata.routed, TRUE);
    modify_field(egress_metadata.tunnel_type, EGRESS_TUNNEL_TYPE_IPV4_NVGRE);
}

action set_ipv4_erspan_v2_rewrite(outer_bd, tunnel_src_index, tunnel_dst_index,
        smac_idx, dmac) {
    modify_field(egress_metadata.bd, outer_bd);
    modify_field(egress_metadata.smac_idx, smac_idx);
    modify_field(egress_metadata.mac_da, dmac);
    modify_field(egress_metadata.tunnel_src_index, tunnel_src_index);
    modify_field(egress_metadata.tunnel_dst_index, tunnel_dst_index);
    modify_field(egress_metadata.routed, TRUE);
    modify_field(egress_metadata.tunnel_type, EGRESS_TUNNEL_TYPE_IPV4_ERSPANV2);
}

table rewrite {
    reads {
        ingress_metadata.nexthop_index : exact;
    }
    actions {
        nop;
        set_l2_rewrite;
        set_ipv4_unicast_rewrite;
        set_ipv4_vxlan_rewrite;
        set_ipv4_geneve_rewrite;
        set_ipv4_nvgre_rewrite;
        set_ipv4_erspan_v2_rewrite;
    }
    size : NEXTHOP_TABLE_SIZE;
}
