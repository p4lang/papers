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

action set_l2_redirect_action() {
    modify_field(ingress_metadata.nexthop_index, ingress_metadata.l2_nexthop);
    modify_field(ingress_metadata.ecmp_index, ingress_metadata.l2_ecmp);
    modify_field(ingress_metadata.ttl, ingress_metadata.lkp_ip_ttl);
}

action set_acl_redirect_action() {
    modify_field(ingress_metadata.nexthop_index, ingress_metadata.acl_nexthop);
    modify_field(ingress_metadata.ecmp_index, ingress_metadata.acl_ecmp);
}

action set_racl_redirect_action() {
    modify_field(ingress_metadata.nexthop_index, ingress_metadata.racl_nexthop);
    modify_field(ingress_metadata.ecmp_index, ingress_metadata.racl_ecmp);
    modify_field(ingress_metadata.routed, TRUE);
    modify_field(ingress_metadata.ttl, ingress_metadata.lkp_ip_ttl);
    add_to_field(ingress_metadata.ttl, -1);
}

action set_fib_redirect_action() {
    modify_field(ingress_metadata.nexthop_index, ingress_metadata.fib_nexthop);
    modify_field(ingress_metadata.ecmp_index, ingress_metadata.fib_ecmp);
    modify_field(ingress_metadata.routed, TRUE);
    modify_field(ingress_metadata.ttl, ingress_metadata.lkp_ip_ttl);
    add_to_field(ingress_metadata.ttl, -1);
}

table fwd_result {
    reads {
        ingress_metadata.l2_redirect : ternary;
        ingress_metadata.acl_redirect : ternary;
        ingress_metadata.racl_redirect : ternary;
        ingress_metadata.fib_hit : ternary;
    }
    actions {
        nop;
        set_l2_redirect_action;
        set_acl_redirect_action;
        set_racl_redirect_action;
        set_fib_redirect_action;
    }
    size : FWD_RESULT_TABLE_SIZE;
}
