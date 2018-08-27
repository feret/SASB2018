
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
open Signature_egfr_sos



let signature= signature_egfr


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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[Free_site [Direction (of_degree 60.);]];
       egfr_Y48,[Direction s],[Free_site [Direction sw;]]];
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[Free_site [Direction nw]]];
      shc,0.8,-.1.5,[],
      [shc_pi,[Direction n],[Free_site [Direction n]];
       shc_Y7,[Direction (of_degree 60.)],[Free_site [Direction e]]]]
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[Free_site [Direction e;]];
       egfr_Y48,[Direction s],[Free_site [Direction e;]]]]
    signature

let _ = dump "conflict_r.ladot" pattern

let
  _,
  pattern
  =
  add_in_graph
    [
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[Free_site [Direction nw]]];
    ]
    signature

let _ = dump "conflict_g.ladot" pattern

let _, pattern =
    add_in_graph
      [
        shc,0.8,-.1.5,[],
        [shc_pi,[Direction n],[Free_site [Direction e;]];
         shc_Y7,[Direction (of_degree 60.)],[Free_site [Direction e;]]]]
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
      grb2,2.0,0.,[],
      [grb2_a,[Direction w],[]];
      shc,0.8,-.1.5,
      [],
      [shc_pi,[Direction n],[Free_site [Direction nw]];
       shc_Y7,[Direction (of_degree 60.)],[]
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[];
       egfr_Y48,[Direction s],[Free_site [Direction e]]];
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[]];
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[Free_site []];
       egfr_Y48,[Direction s],[]];
        shc,0.8,-.1.5,[],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction (of_degree 60.)],[Free_site []]
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[];
       egfr_Y48,[Direction s],[]];
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[]];
      shc,0.8,-.1.5,[],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction (of_degree 60.)],[Free_site [Direction e]]
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[Free_site [Direction e]];
       egfr_Y48,[Direction s],[]];
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[]];
      shc,0.8,-.1.5,[],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction (of_degree 60.)],[]
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
      egfr,0.,0.,[],
      [egfr_Y68,[Direction e],[];
       egfr_Y48,[Direction s],[]];
      grb2,2.,0.,[],
      [grb2_a,[Direction w],[]];
      grb2,2.8,-.1.5,[],
      [grb2_a,[Direction w],[]];
      shc,0.8,-.1.5,[],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction (of_degree 60.)],[]
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
