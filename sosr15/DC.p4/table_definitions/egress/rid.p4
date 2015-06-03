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

#ifndef MULTICAST_DISABLE
action replica_from_rid(bd) {
    modify_field(ingress_metadata.egress_bd, bd);
    modify_field(egress_metadata.replica, TRUE);
}

table rid {
    reads {
        intrinsic_metadata.replication_id : exact;
    }
    actions {
        nop;
        replica_from_rid;
    }
    size : RID_TABLE_SIZE;
}

#endif
