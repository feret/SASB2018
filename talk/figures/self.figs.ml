
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



let signature = signature_egfr

(* CONTACT MAP *)
let
  [
    cm_r,[cm_r_x,_]
  ],
  remanent
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_r,[Direction e],[Free_site [Direction ne;]]]]

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
      egfr,0.,0.,[],
      [egfr_r,[Direction w],[]];
      egfr,-.2.,0.,[],
      [egfr_r,[Direction e],[]];
    ]
    signature


let dimer =
       add_link_list
         [
           x,y
         ]
      dimer

let _ = dump "self_dimer.ladot" dimer
