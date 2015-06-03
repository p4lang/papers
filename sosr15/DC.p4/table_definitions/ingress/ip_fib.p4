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

action fib_hit_nexthop(nexthop_index) {
    modify_field(ingress_metadata.fib_hit, TRUE);
    modify_field(ingress_metadata.fib_nexthop, nexthop_index);
}

action fib_hit_ecmp(ecmp_index) {
    modify_field(ingress_metadata.fib_hit, TRUE);
    modify_field(ingress_metadata.fib_ecmp, ecmp_index);
}

table ipv4_fib_lpm {
    reads {
        ingress_metadata.vrf : exact;
        ingress_metadata.lkp_ipv4_da : lpm;
    }
    actions {
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV4_LPM_TABLE_SIZE;
}

table ipv4_fib {
    reads {
        ingress_metadata.vrf : exact;
        ingress_metadata.lkp_ipv4_da : exact;
    }
    actions {
        on_miss;
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV4_HOST_TABLE_SIZE;
}
