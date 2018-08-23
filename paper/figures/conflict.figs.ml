
(**
 * egfr.ml
 * GKappa
 * Jérôme Feret, projet Antique, INRIA Paris-Rocquencourt
 *
 * Creation:                      <2015-03-28 feret>
 * Last modification: Time-stamp: <2015-10-14 15:10:37 feret>
 * *
 *
 * Copyright 2015 Institut National de Recherche en Informatique  * et en Automatique.  All rights reserved.
 * This file is distributed under the terms of the
 * GNU Library General Public License *)


(** GKappa is a OCAML library to help making slides in Kappa *)
(** More applications are coming soon (hopefully) *)

(** Example to draw pictures related to the early egfr pathway *)

open Config
open Geometry



let config =
  {config with
    agent_colors = ["magenta";"blue";"green";"purple";"darkgreen";];
    site_colors = ["white";"cyan";"yellow";"pink";"purple";"green";"darkgreen"];
    state_colors = ["white";"black"];
    show_agent_names = true ;
    show_site_names = true ;
    show_state_names = false ;
    show_free_symbols = true ;
    color_agents = true ;
    color_sites = true ;
    color_states = true ;
    site_width = 0.2 ;
    site_height = 0.2;
    agent_width = 2. ;
    agent_height = 1. ;
    state_width = 0.1 ;
    state_height = 0.1 ;
    pi = 3.1416 ;
    free_width = 0.15 ;
    free_height = 0.1 ;
    bound_height = 0.3 ;
    rule_length = 1. ;
    rule_width = 1;
    cross_width = 5 ;
    edge_label_font = 50 ;
    link_width = 2 ;
    empty_graph = "";
    pairing_style = "dashed";
    pairing_color = "cyan";
    pairing_width = 2;
    weak_flow_color = "cyan";
    weak_flow_style = "dashed";
    flow_color = "red";
    strong_flow_color = "red";
    strong_flow_style = "";
    flow_style = "";
    binding_type_font = 15 ;
    agent_label_font = 18 ;
    site_label_font = 14;
    state_label_font = 10 ;
    txt_font = 25 ;
    rule_name_font = 20;
    dummy_font = 20;
    rule_margin = 0.6;
    flow_padding = 0.05;
    projection_width = 2;
    rule_color = "black";
    rule_style = "" ;
    projection_color = "blue";
    projection_style = "dashed";
    weak_flow_width = 1;
    flow_width = 2;
    strong_flow_width =3;
    losange = ("dotted","black"),("dashed",("blue","blue4")),("solid",("blue","blue4")),("solid",("red","red4")),("dashed",("red","red4")),("dotted","black");
    losange_corners = empty_co ;
    losange_padding = 0.5;
    rule = ("dashed","blue"),("dashed","blue4") ;
    rule_corners = empty_ru ;
 }


(* chemical species*)
let _,init = init config
(*signature*)

let
  [
    r,
    [r_g,[];r_s,[]];
    g,
    [g_a,[]];
    sh,
    [s_g,[];s_r,[]]
  ],
  signature
  =
  add_in_signature
    [
      "R",[Width 0.4;Height 0.5;Shape "ellipse"],
      [
        "g",[Direction ne;FillColor "green"],[];
        "s",[Direction se;FillColor "purple"],[]
      ];
      "G",[Width 0.4;Height 0.4;Shape "circle"],
      [
        "a",[Direction w],[];
      ];
      "S",[Width 0.35;Height 0.45;Shape "rectangle"],
      [
        "g",[Direction ne;FillColor "green"],[];
        "r",[Direction nw;FillColor "blue"],[]
      ];
]
    init


(* CONTACT MAP *)
let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_g,[cm_g_a,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[Free_site [Direction ne;]];
       r_s,[],[Free_site [Direction se;]]];
      g,1.2,0.3,[],
      [g_a,[],[Free_site [Direction nw]]];
      sh,0.8,-.0.3,[],
      [s_r,[],[Free_site [Direction n]];
       s_g,[],[Free_site [Direction e]]]]
    signature

let remanent =
  add_link_list
    [
      cm_r_g,cm_g_a;
      cm_s_g,cm_g_a;
      cm_r_s,cm_s_r;
    ]
    remanent

let contact_map = remanent


let _ = dump "conflict_contact_map.ladot" contact_map

let
  _,
  pattern
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[Free_site [Direction e;]];
       r_s,[],[Free_site [Direction e;]]]]
    signature

let _ = dump "conflict_r.ladot" pattern

let
  _,
  pattern
  =
  add_in_graph
    [
      g,1.2,0.3,[],
      [g_a,[],[Free_site [Direction nw]]];
    ]
    signature

let _ = dump "conflict_g.ladot" pattern

let _, pattern =
    add_in_graph
      [
        sh,0.6,-.0.3,[],
        [s_r,[],[Free_site [Direction e;]];
         s_g,[],[Free_site [Direction e;]]]]
      signature

let _ = dump "conflict_s.ladot" pattern

let
  [
    cm_g,[cm_g_a,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      g,1.2,-.0.5,[],
      [g_a,[],[]];
      sh,0.3,-.0.5,[],
      [s_r,[Direction w],[Free_site [Direction nw]];
       s_g,[Direction e],[]
      ]
    ]
    signature

let pattern =
  add_link_list
    [
      cm_s_g,cm_g_a;
    ]
    remanent

let _ = dump "conflict_gs.ladot" pattern

let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_g,[cm_g_a,_];

  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[];
       r_s,[],[Free_site [Direction e]]];
      g,0.8,0.,[],
      [g_a,[],[]];
    ]
    signature

let pattern =
  add_link_list
    [
      cm_r_g,cm_g_a;
    ]
    remanent

let _ = dump "conflict_rg.ladot" pattern

let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[Free_site []];
       r_s,[],[]];
        sh,0.8,-.0.,[],
      [s_r,[Direction w],[];
       s_g,[Direction e],[Free_site []]
      ]
    ]
    signature

let pattern =
  add_link_list
    [
      cm_r_s,cm_s_r;
    ]
    remanent

let _ = dump "conflict_rs.ladot" pattern

let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_g',[cm_g'_a,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[];
       r_s,[],[]];
      g,1.2,0.,[],
      [g_a,[],[]];
      sh,0.6,-.0.3,[],
      [s_r,[Direction w],[];
       s_g,[Direction e],[Free_site [Direction e]]
      ]
    ]
    signature

let pattern =
  add_link_list
    [
      cm_r_g,cm_g'_a;
      cm_r_s,cm_s_r;
    ]
    remanent

let _ = dump "conflict_grs.ladot" pattern

let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_g,[cm_g_a,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[Free_site [Direction e]];
       r_s,[],[]];
      g,1.2,-.0.5,[],
      [g_a,[],[]];
      sh,0.6,-.0.3,[],
      [s_r,[Direction w],[];
       s_g,[Direction e],[]
      ]
    ]
    signature

let pattern =
  add_link_list
    [
      cm_s_g,cm_g_a;
      cm_r_s,cm_s_r;
    ]
    remanent

let _ = dump "conflict_gbisrs.ladot" pattern


let
  [
    cm_r,[cm_r_g,_;cm_r_s,_];
    cm_g,[cm_g_a,_];
    cm_g',[cm_g'_a,_];
    cm_s,[cm_s_r,_;cm_s_g,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_g,[],[];
       r_s,[],[]];
      g,1.2,0.,[],
      [g_a,[],[]];
      g,1.4,-.0.3,[],
      [g_a,[],[]];
      sh,0.6,-.0.3,[],
      [s_r,[Direction w],[];
       s_g,[Direction e],[]
      ]
      ]
    signature

    let pattern =
      add_link_list
        [
          cm_r_g,cm_g_a;
          cm_s_g,cm_g'_a;
          cm_r_s,cm_s_r;
        ]
        remanent

let _ = dump "conflict_ggrs.ladot" pattern
