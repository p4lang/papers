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

/* Table to validate outer ethernet header */
#include "ingress/validate_outer_ethernet.p4"

/* Table to validate outer IP header */
#include "ingress/validate_outer_ipv4_packet.p4"

/* Port mapping table, sets ifindex and if_label depending on ingress port */
#include "ingress/port_mapping.p4"

/* Port VLAN mapping table, set Bridging Domain, RMAC group, VRF and STP group based on ifindex and VLAN tag */
#include "ingress/port_vlan_mapping.p4"

/* Spanning tree table */
#include "ingress/spanning_tree.p4"

/* Outer RMAC table, for tunnel termination */
#include "ingress/outer_rmac.p4"

/* IPv4 Dest VTEP table, terminate tunnel if you are the destination IP */
#include "ingress/ipv4_dest_vtep.p4"

/* IPv4 Src VTEP table, create tunnel if you are the source IP */
#include "ingress/ipv4_src_vtep.p4"

/* Tunnel table, terminate tunnel */
#include "ingress/tunnel.p4"

/* BD table */
#include "ingress/bd.p4"

/* validate packet table, check if link local, or malformed based on MAC DST and IPv4 DST */
#include "ingress/validate_packet.p4"

/* SMAC table, SMAC: source MAC */
#include "ingress/smac.p4"

/* DMAC table, DMAC: Destination MAC */
#include "ingress/dmac.p4"

/* RMAC table, RMAC: Router MAC */
#include "ingress/rmac.p4"

/* MAC and IP ACL */
#include "ingress/mac_ip_acl.p4"

/* Mirror ACL */
#include "ingress/mirror_acl.p4"

/* IP_RACL table, What is RACL? */
#include "ingress/ip_racl.p4"

/* IP FIB tables, both lpm and ternary */
#include "ingress/ip_fib.p4"

/* fwd_result table */
#include "ingress/fwd_result.p4"

/* ecmp_group table */
#include "ingress/ecmp_group.p4"

/* next hop table */
#include "ingress/next_hop.p4"

/* LAG group table */
#include "ingress/lag_group.p4"

/* system_acl table */
#include "ingress/system_acl.p4"

/* learn_notify table */
#include "ingress/learn_notify.p4"
