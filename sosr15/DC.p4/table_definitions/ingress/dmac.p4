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

action dmac_hit(ifindex) {
    modify_field(ingress_metadata.egress_ifindex, ifindex);
    modify_field(ingress_metadata.egress_bd, ingress_metadata.bd);
}

action dmac_multicast_hit(mc_index) {
    modify_field(intrinsic_metadata.eg_mcast_group, mc_index);
    modify_field(ingress_metadata.egress_bd, ingress_metadata.bd);
}

action dmac_miss() {
    modify_field(intrinsic_metadata.eg_mcast_group, ingress_metadata.uuc_mc_index);
}

action dmac_redirect_nexthop(nexthop_index) {
    modify_field(ingress_metadata.l2_redirect, TRUE);
    modify_field(ingress_metadata.l2_nexthop, nexthop_index);
}

action dmac_redirect_ecmp(ecmp_index) {
    modify_field(ingress_metadata.l2_redirect, TRUE);
    modify_field(ingress_metadata.l2_ecmp, ecmp_index);
}

table dmac {
    reads {
        ingress_metadata.bd : exact;
        ingress_metadata.lkp_mac_da : exact;
    }
    actions {
        nop;
        dmac_hit;
        dmac_multicast_hit;
        dmac_miss;
        dmac_redirect_nexthop;
        dmac_redirect_ecmp;
    }
    size : DMAC_TABLE_SIZE;
    support_timeout: true;
}
