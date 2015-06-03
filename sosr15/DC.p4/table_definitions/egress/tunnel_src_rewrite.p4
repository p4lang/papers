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

action rewrite_tunnel_ipv4_src(ip) {
    modify_field(ipv4.srcAddr, ip);
}

table tunnel_src_rewrite {
    reads {
        egress_metadata.tunnel_src_index : exact;
    }
    actions {
        rewrite_tunnel_ipv4_src;
    }
    size : DEST_TUNNEL_TABLE_SIZE;
}
