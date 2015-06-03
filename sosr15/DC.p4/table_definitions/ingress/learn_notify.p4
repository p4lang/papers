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

field_list mac_learn_digest {
    ingress_metadata.bd;
    ingress_metadata.lkp_mac_sa;
    ingress_metadata.ifindex;
}

action generate_learn_notify() {
    generate_digest(MAC_LEARN_RECIEVER, mac_learn_digest);
}

table learn_notify {
    reads {
        ingress_metadata.l2_src_miss : ternary;
        ingress_metadata.l2_src_move : ternary;
        ingress_metadata.stp_state : ternary;
    }
    actions {
        nop;
        generate_learn_notify;
    }
    size : LEARN_NOTIFY_TABLE_SIZE;
}
