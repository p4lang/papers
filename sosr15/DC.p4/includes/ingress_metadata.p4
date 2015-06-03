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

/* METADATA */
header_type ingress_metadata_t {
    fields {
        lkp_pkt_type : 3;
        lkp_mac_sa : 48;
        lkp_mac_da : 48;
        lkp_mac_type : 16;
        lkp_ip_type : 2;
        lkp_ipv4_sa : 32;
        lkp_ipv4_da : 32;
        lkp_ip_proto : 8;
        lkp_ip_tc : 8;
        lkp_ip_ttl : 8;
        lkp_icmp_type : 16;
        lkp_icmp_code : 16;

        lkp_l4_sport : 16;
        lkp_l4_dport : 16;
        lkp_inner_l4_sport : 16;
        lkp_inner_l4_dport : 16;

        l3_length : 16;                        /* l3 length */

        ifindex : IFINDEX_BIT_WIDTH;           /* input interface index - MSB bit lag*/
        lif : 16;                              /* logical interface */
        vrf : VRF_BIT_WIDTH;                   /* VRF */

        tunnel_type : 4;                       /* tunnel type from parser */
        tunnel_terminate : 1;                  /* should tunnel be terminated */
        tunnel_vni : 24;                       /* tunnel id */
        tunnel_lif : 16;                       /* tunnel ingress logical interface */
        src_vtep_miss : 1;                     /* src vtep lookup failed */

        outer_bd : 8;                          /* outer BD */
        outer_rmac_group : 10;                 /* Rmac group, for rmac indirection */
        outer_rmac_hit : 1;                    /* dst mac is the router's mac */
        outer_dscp : 8;                        /* outer dscp */
        outer_ttl : 8;                         /* outer ttl */

        l2_multicast : 1;                      /* packet is l2 multicast */
        src_is_link_local : 1;                 /* source is link local address */
        bd : BD_BIT_WIDTH;                     /* inner BD */
        ipv4_unicast_enabled : 1;              /* is ipv4 unicast routing enabled on BD */
        igmp_snooping_enabled : 1;             /* is IGMP snooping enabled on BD */
        rmac_group : 10;                       /* Rmac group, for rmac indirection */
        rmac_hit : 1;                          /* dst mac is the router's mac */
        uuc_mc_index : 16;                     /* unknown unicast multicast index */
        umc_mc_index : 16;                     /* unknown multicast multicast index */
        bcast_mc_index : 16;                   /* broadcast multicast index */
        multicast_bridge_mc_index : 16;        /* multicast index from igmp/mld snoop */
        routed : 1;                            /* is packet routed */

        if_label : 16;                         /* if label for acls */
        bd_label : 16;                         /* bd label for acls */

        l2_src_miss : 1;                       /* l2 source miss */
        l2_src_move : IFINDEX_BIT_WIDTH;       /* l2 source interface mis-match */
        acl_deny : 1;                          /* ifacl/vacl deny action */
        racl_deny : 1;                         /* racl deny action */
        l2_redirect : 1;                       /* l2 redirect action */
        acl_redirect :   1;                    /* ifacl/vacl redirect action */
        racl_redirect : 1;                     /* racl redirect action */
        fib_hit : 1;                           /* fib hit */

        learn_mac : 48;                        /* mac learn data */

        l2_nexthop : 16;                       /* next hop from l2 */
        acl_nexthop : 16;                      /* next hop from ifacl/vacl */
        racl_nexthop : 16;                     /* next hop from racl */
        fib_nexthop : 16;                      /* next hop from fib */
        l2_ecmp : 10;                          /* ecmp index from l2 */
        acl_ecmp : 10;                         /* ecmp index from ifacl */
        racl_ecmp : 10;                        /* ecmp index from racl */
        fib_ecmp : 10;                         /* ecmp index from fib */
        ecmp_index : 10;                       /* final ecmp index */
        ecmp_offset : 14;                      /* offset into the ecmp table */
        nexthop_index : 16;                    /* final next hop index */
        lag_offset : 14;                       /* numer of lag members */

        ttl : 8;                               /* update ttl */

        egress_ifindex : IFINDEX_BIT_WIDTH;    /* egress interface index */
        egress_bd : BD_BIT_WIDTH;              /* egress BD */

        ingress_bypass : 1;                    /* skip the entire ingress pipeline */
        ipv4_dstaddr_24b : 24;                 /* first 24b of ipv4 dst addr */
        drop_0 : 1;                            /* dummy */
        drop_reason : 8;                       /* drop reason */
        msg_type : 8;
        stp_group: 10;                         /* spanning tree group id */
        stp_state : 3;                         /* spanning tree port state */
        stp_enabled: 1;                        /* spanning tree is enabled */
        control_frame: 1;                      /* control frame */
    }
}
