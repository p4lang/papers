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

action redirect_to_cpu() {
    modify_field(standard_metadata.egress_spec, CPU_PORT);
    modify_field(intrinsic_metadata.eg_mcast_group, 0);
}

action copy_to_cpu() {
    clone_ingress_pkt_to_egress(CPU_PORT);
}

action drop_packet() {
    modify_field(intrinsic_metadata.eg_mcast_group, 0);
    drop();
}

table system_acl {
    reads {
        ingress_metadata.if_label : ternary;
        ingress_metadata.bd_label : ternary;

        /* ip acl */
        ingress_metadata.lkp_ipv4_sa : ternary;
        ingress_metadata.lkp_ipv4_da : ternary;
        ingress_metadata.lkp_ip_proto : ternary;

        /* mac acl */
        ingress_metadata.lkp_mac_sa : ternary;
        ingress_metadata.lkp_mac_da : ternary;
        ingress_metadata.lkp_mac_type : ternary;

        /* drop reasons */
        ingress_metadata.acl_deny : ternary;
        ingress_metadata.racl_deny: ternary;

        /* other checks, routed link_local packet, l3 same if check, expired ttl */
        ingress_metadata.src_vtep_miss : ternary;
        ingress_metadata.routed : ternary;
        ingress_metadata.src_is_link_local : ternary;
        ingress_metadata.ttl : ternary;
        ingress_metadata.stp_state : ternary;
        ingress_metadata.control_frame: ternary;

        /* egress information */
        standard_metadata.egress_spec : ternary;
    }
    actions {
        nop;
        redirect_to_cpu;
        copy_to_cpu;
        drop_packet;
    }
    size : SYSTEM_ACL_SIZE;
}
