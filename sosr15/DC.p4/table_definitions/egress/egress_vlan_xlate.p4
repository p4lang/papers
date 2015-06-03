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

action set_egress_packet_vlan_tagged(vlan_id) {
    add_header(vlan_tag_[0]);
    modify_field(vlan_tag_[0].vid, vlan_id);
}

action set_egress_packet_vlan_untagged() {
    remove_header(vlan_tag_[0]);
}

table egress_vlan_xlate {
    reads {
        standard_metadata.egress_port : exact;
        egress_metadata.bd : exact;
    }
    actions {
        nop;
        set_egress_packet_vlan_tagged;
        set_egress_packet_vlan_untagged;
    }
    size : EGRESS_VLAN_XLATE_TABLE_SIZE;
}
