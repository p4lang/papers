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

action egress_drop () {
    drop();
}

table egress_block {
    reads {
        standard_metadata.egress_port : exact;
        intrinsic_metadata.replication_id : exact;
    }
    actions {
        on_miss;
        egress_drop;
    }
    size : EGRESS_BLOCK_TABLE_SIZE;
}
