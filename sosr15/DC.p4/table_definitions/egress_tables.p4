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

/* RID table, RID: Replication ID */
#include "egress/rid.p4"

/* Tunnel decap table */
#include "egress/tunnel_decap.p4"

/* egress_bd_map table */
#include "egress/egress_bd_map.p4"

/* rewrite table */
#include "egress/rewrite.p4"

/* tunnel_rewrite table */
#include "egress/tunnel_rewrite.p4"

/* tunnel_src_rewrite table */
#include "egress/tunnel_src_rewrite.p4"

/* tunnel_dst_rewrite table */
#include "egress/tunnel_dst_rewrite.p4"

/* outer_mac table */
#include "egress/outer_mac.p4"

/* egress_block table */
#include "egress/egress_block.p4"

/* egress_vlan_xlate  table */
#include "egress/egress_vlan_xlate.p4"

/* egress_system_acl table */
#include "egress/egress_system_acl.p4"

/* cpu_rewrite table */
#include "egress/cpu_rewrite.p4"
