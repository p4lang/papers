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

action set_tunnel_termination_flag() {
    modify_field(ingress_metadata.tunnel_terminate, TRUE);
}

table ipv4_dest_vtep {
    reads {
        ingress_metadata.vrf : exact;
        ingress_metadata.lkp_ipv4_da : exact;
        ingress_metadata.lkp_ip_proto : exact;
        ingress_metadata.lkp_l4_dport : exact;
    }
    actions {
        nop;
        set_tunnel_termination_flag;
    }
    size : DEST_TUNNEL_TABLE_SIZE;
}
