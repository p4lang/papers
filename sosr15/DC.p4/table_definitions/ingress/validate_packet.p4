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

action set_l2_multicast() {
    modify_field(ingress_metadata.l2_multicast, TRUE);
}

action set_src_is_link_local() {
    modify_field(ingress_metadata.src_is_link_local, TRUE);
}

action set_malformed_packet() {
}

table validate_packet {
    reads {
        ingress_metadata.lkp_mac_da : ternary;
        ingress_metadata.lkp_ipv4_da : ternary;
    }
    actions {
        nop;
        set_l2_multicast;
        set_src_is_link_local;
        set_malformed_packet;
    }
    size : VALIDATE_PACKET_TABLE_SIZE;
}
