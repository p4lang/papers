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

action set_stp_state(stp_state) {
    modify_field(ingress_metadata.stp_state, stp_state);
}

table spanning_tree {
    reads {
        ingress_metadata.ifindex : exact;
        ingress_metadata.stp_group: exact;
    }
    actions {
        set_stp_state;
    }
    size : SPANNING_TREE_TABLE_SIZE;
}
