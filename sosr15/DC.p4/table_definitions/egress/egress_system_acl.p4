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

action egress_redirect_to_cpu() {
}

table egress_system_acl {
    reads {
        egress_metadata.mtu_check_fail : ternary;
    }
    actions {
        nop;
        egress_redirect_to_cpu;
    }
    size : EGRESS_SYSTEM_ACL_TABLE_SIZE;
}
