
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



(* CONTACT MAP *)
let
  [
    cm_r,[cm_r_x,_;cm_r_y,_]
  ],
  remanent
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_r,[Direction w],[Free_site [Direction nw;]];
       egfr_c,[Direction e],[Free_site [Direction ne;]]]]
    signature_egfr

let remanent =
  add_link_list
    [
      cm_r_x,cm_r_x;
      cm_r_y,cm_r_y
    ]
    remanent

let contact_map = remanent


let _ = dump "twoself_contact_map.ladot" contact_map

let
  [
    _,[a,_];
    _,[b,_;c,_];
    _,[d,_]
  ],
  dimer
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_r,[Direction e],[]];
      egfr,2.,0.,[],
      [egfr_c,[Direction e],[];
       egfr_r,[Direction w],[]];
      egfr,4.,0.,[],
      [egfr_c,[Direction w],[]];
    ]
    signature_egfr


let dimer =
       add_link_list
         [
           a,c; b,d;
         ]
      dimer

let _ = dump "twoself_pattern.ladot" dimer

let
  [
    _,[a,_];
    _,[b,_;c,_];
    _,[d,_]
  ],
  dimer
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_r,[Direction e],[]];
      egfr,2.,0.,[],
      [egfr_c,[Direction e],[];
       egfr_r,[Direction w],[]];
      egfr,4.,0.,[],
      [egfr_n,[Direction w],[]];
    ]
    signature_egfr


let dimer =
  add_link_list
    [
      a,c; b,d;
    ]
    dimer

let _ = dump "invariant_pattern.ladot" dimer
