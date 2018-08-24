
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
    [r_x,[]]],
  signature
  =
  add_in_signature
    [
      "R",[Width 0.5;Height 0.4;Shape "rectangle";FillColor "\"#6767f2\""],
      [
        "r",[Direction w],[]
      ]
]
    init


(* CONTACT MAP *)
let
  [
    cm_r,[cm_r_x,_]
  ],
  remanent
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_x,[],[Free_site [Direction nw;]]]]

    signature

let _ = dump "self_monomer.ladot" remanent

let remanent =
  add_link_list
    [
      cm_r_x,cm_r_x;
    ]
    remanent

let contact_map = remanent


let _ = dump "self_contact_map.ladot" contact_map

let
  [
    _,[x,_];
    _,[y,_]
  ],
  dimer
  =
  add_in_graph
    [
      r,0.,0.,[],
      [r_x,[],[]];
      r,-.1.,0.,[],
      [r_x,[Direction e],[]];
    ]
    signature


let dimer =
       add_link_list
         [
           x,y
         ]
      dimer

let _ = dump "self_dimer.ladot" dimer
