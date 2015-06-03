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

action smac_miss() {
    modify_field(ingress_metadata.l2_src_miss, TRUE);
}

action smac_hit(ifindex) {
    bit_xor(ingress_metadata.l2_src_move, ingress_metadata.ifindex, ifindex);
    add_to_field(ingress_metadata.egress_bd, 0);
}

table smac {
    reads {
        ingress_metadata.bd : exact;
        ingress_metadata.lkp_mac_sa : exact;
    }
    actions {
        nop;
        smac_miss;
        smac_hit;
    }
    size : SMAC_TABLE_SIZE;
}
