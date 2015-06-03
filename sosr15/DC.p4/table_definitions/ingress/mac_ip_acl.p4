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

action acl_log() {
}

action acl_deny() {
    modify_field(ingress_metadata.acl_deny, TRUE);
}

action acl_permit() {
}

action acl_redirect_nexthop(nexthop_index) {
    modify_field(ingress_metadata.acl_redirect, TRUE);
    modify_field(ingress_metadata.acl_nexthop, nexthop_index);
}

action acl_redirect_ecmp(ecmp_index) {
    modify_field(ingress_metadata.acl_redirect, TRUE);
    modify_field(ingress_metadata.acl_ecmp, ecmp_index);
}

table mac_acl {
    reads {
        ingress_metadata.if_label : ternary;
        ingress_metadata.bd_label : ternary;

        ingress_metadata.lkp_mac_sa : ternary;
        ingress_metadata.lkp_mac_da : ternary;
        ingress_metadata.lkp_mac_type : ternary;
    }
    actions {
        nop;
        acl_log;
        acl_deny;
        acl_permit;
    }
    size : INGRESS_MAC_ACL_TABLE_SIZE;
}

counter ip_acl_counters {
    type : packets;
    direct : ip_acl;
}

table ip_acl {
    reads {
        ingress_metadata.if_label : ternary;
        ingress_metadata.bd_label : ternary;

        ingress_metadata.lkp_ipv4_sa : ternary;
        ingress_metadata.lkp_ipv4_da : ternary;
        ingress_metadata.lkp_ip_proto : ternary;
        ingress_metadata.lkp_l4_sport : ternary;
        ingress_metadata.lkp_l4_dport : ternary;

        ingress_metadata.lkp_mac_type : ternary;
        ingress_metadata.msg_type : ternary; /* ICMP code */
        tcp : valid;
        tcp.flags : ternary;
        ingress_metadata.ttl : ternary;
    }
    actions {
        nop;
        acl_log;
        acl_deny;
        acl_permit;
        acl_redirect_nexthop;
        acl_redirect_ecmp;
    }
    size : INGRESS_IP_ACL_TABLE_SIZE;
}    
