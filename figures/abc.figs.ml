
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
    a,
    [a_b,[];
     a_c,[]];
    b,
    [b_a,[];
     b_c,[]];
    c,
    [c_a,[];
     c_b,[]]],
  signature
  =
  add_in_signature
    [
      "A",[Width 0.5;Height 0.4;Shape "ellipse";FillColor "\"#6767f2\""],
      [
        "b",[Direction (of_degree (120.));FillColor "\"#709d54\""],[];
        "c",[Direction (of_degree (-.120.));FillColor "\"#b5dce6\""],[]
      ];
      "B",[Width 0.5;Height 0.4;Shape "ellipse";FillColor "\"#709d54\""],
      [
        "a",[Direction (of_degree (-.30.));FillColor "\"#6767f2\""],[];
        "c",[Direction (of_degree (-.90.));FillColor "\"#b5dce6\""],[]
      ];
      "C",[Width 0.5;Height 0.4;Shape "ellipse";FillColor "\"#b5dce6\""],
      [
        "a",[Direction (of_degree (30.));FillColor "\"#6767f2\""],[];
        "b",[Direction (of_degree (90.));FillColor "\"#709d54\""],[]
      ]]
    init


(* CONTACT MAP *)
let
  [
    cm_a,[cm_a_b,_;cm_a_c,_];
    cm_b,[cm_b_a,_;cm_b_c,_];
    cm_c,[cm_c_a,_;cm_c_b,_];
  ],
  remanent
  =
  add_in_graph
    [
      a,0.,0.3,[],
      [a_b,[],[Free_site [Direction ne;Tag ("CM",1)]];
      a_c,[],[Free_site [Direction nw;Tag ("CM",1)]]];
      b,+.0.6,-.0.6,[],
      [b_a,[],[Free_site [Direction ne;Tag ("CM",1)]];
      b_c,[],[Free_site [Direction s;Tag ("CM",1)]]];
      c,-0.6,-.0.6,[],
      [c_a,[],[Free_site [Direction nw;Tag ("CM",1)]];
      c_b,[],[Free_site [Direction s;Tag ("CM",1)]]]]
    signature


let remanent =
  add_link_list
    [
      cm_a_b,cm_b_a;
      cm_b_c,cm_c_b;
      cm_c_a,cm_a_c
    ]
    remanent

let contact_map = remanent


let _ = dump "abc_contact_map.ladot" contact_map
let _ = dump "abc_triangle.ladot" ~flags:["CM",0] contact_map

let
  [p_a,[p_a_b,_];
   p_b, [p_b_a,_;p_b_c,_];
   p_c, [p_c_a,_;p_c_b,_];
   p_a',[p_a_c,_]], pattern =
   add_in_graph
     [
       a,0.,0.,[],
       [a_b,[Direction e],[]];
       b,1.,0.,[],
       [b_a,[Direction w],[];
        b_c,[Direction e],[]];
       c,2.,0.,[],
       [c_a,[Direction e],[];
        c_b,[Direction w],[]];
        a,3.,0.,[],
        [a_c,[Direction w],[]]]
     signature


let pattern =
       add_link_list
         [
           p_a_b,p_b_a;
           p_b_c,p_c_b;
           p_c_a,p_a_c
         ]
         pattern

let _ = dump "abc_pattern.ladot" pattern


let
  [p_a,[p_a_b,_];
   p_b, [p_b_a,_;p_b_c,_];
   p_c, [p_c_a,_;p_c_b,_]], pattern =
   add_in_graph
     [
       a,0.,0.,[],
       [a_b,[Direction e],[]];
       b,1.,0.,[],
       [b_a,[Direction w],[];
        b_c,[Direction e],[]];
       c,2.,0.,[],
       [c_a,[Direction e],[];
        c_b,[Direction w],[]]]
     signature


let pattern =
       add_link_list
         [
           p_a_b,p_b_a;
           p_b_c,p_c_b;
         ]
         pattern

let _ = dump "abc_pattern_b.ladot" pattern

let site, pattern =
  add_site p_a a_c pattern
let _, pattern = add_free site pattern

let _ = dump "abc_pattern_a.ladot" pattern

let
  [
    cm_a,[cm_a_b,_;cm_a_c,_];
    cm_b,[cm_b_a,_;cm_b_c,_];
    cm_c,[cm_c_a,_;cm_c_b,_];
    sp_a,[sp_a_b,_;sp_a_c,_];
    sp_b,[sp_b_a,_;sp_b_c,_];
    sp_c,[sp_c_a,_;sp_c_b,_];
  ],
  remanent
  =
  add_in_graph
    [
      a,2.,0.,[],
      [a_b,[Direction s],[Free_site [Direction sw;Tag ("CM",1)]];
       a_c,[Direction n],[Free_site [Direction nw;Tag ("CM",1)]]];
      b,2.6,-.0.6,[],
      [b_a,[Direction w],[Free_site [Direction sw;Tag ("CM",1)]];
       b_c,[Direction n],[Free_site [Direction e;Tag ("CM",1)]]];
      c,2.6,+.0.6,[],
      [c_a,[Direction w],[Free_site [Direction nw;Tag ("CM",1)]];
       c_b,[Direction s],[Free_site [Direction e;Tag ("CM",1)]]];
      a,0.,0.,[],
      [a_b,[Direction s],[];
       a_c,[Direction n],[];];
      b,0.6,-.0.6,[],
      [b_a,[Direction w],[];
       b_c,[Direction n],[];];
      c,0.6,+.0.6,[],
      [c_a,[Direction w],[];
       c_b,[Direction s],[]]]
    signature


let remanent =
  add_link_list
    [
      cm_a_b,cm_b_a;
      cm_b_c,cm_c_b;
      cm_c_a,cm_a_c;
      sp_a_b,sp_b_a;
      sp_b_c,sp_c_b;
      sp_c_a,sp_a_c
    ]
    remanent

let remanent =
  add_proj
    [sp_a,cm_a;
     sp_b,cm_b;
     sp_c,cm_c
    ]
    remanent

let _ = dump "abc_embed.ladot" remanent



let plot_site (a,b,name) =
  let _,er =
    add_in_graph
      [a,0.,0.,[],[b,[],[]]]
      signature
  in
  dump (name^".ladot") er

let () =
  List.iter
    plot_site
    [
      a,a_b,"a_b";
      a,a_c,"a_c";
      b,b_a,"b_a";
      b,b_c,"b_c";
      c,c_a,"c_a";
      c,c_b,"c_b";
]


let plot_link (a,b,c,d,name) =
  let [_,[sa,_];_,[sb,_]],er =
    add_in_graph
      [a,0.,0.,[],[b,[Direction e],[]];
       c,0.8,0.,[],[d,[Direction w],[]]]
      signature

  in
  let er =
    add_link_list [sa,sb] er
  in
  dump (name^".ladot") er

let () =
  List.iter
    plot_link
    [
      a,a_b,b,b_a,"link_a_b";
      a,a_c,c,c_a,"link_a_c";
      c,c_b,b,b_c,"link_b_c";
      b,b_a,a,a_b,"link_b_a";
      c,c_a,a,a_c,"link_c_a";
      c,c_b,b,b_c,"link_c_b"
    ]
