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

action set_bd_info(vrf, rmac_group, 
        bd_label, uuc_mc_index, bcast_mc_index, umc_mc_index,
        ipv4_unicast_enabled, 
        igmp_snooping_enabled, stp_group) {
    modify_field(ingress_metadata.vrf, vrf);
    modify_field(ingress_metadata.ipv4_unicast_enabled, ipv4_unicast_enabled);
    modify_field(ingress_metadata.igmp_snooping_enabled, igmp_snooping_enabled);
    modify_field(ingress_metadata.rmac_group, rmac_group);
    modify_field(ingress_metadata.uuc_mc_index, uuc_mc_index);
    modify_field(ingress_metadata.umc_mc_index, umc_mc_index);
    modify_field(ingress_metadata.bcast_mc_index, bcast_mc_index);
    modify_field(ingress_metadata.bd_label, bd_label);
    modify_field(ingress_metadata.stp_group, stp_group);
}

/*
* extract all the bridge domain parameters for non-tunneled
*   packets
*/
table bd {
    reads {
        ingress_metadata.bd : exact;
    }
    actions {
        set_bd_info;
    }
    size : BD_TABLE_SIZE;
}
