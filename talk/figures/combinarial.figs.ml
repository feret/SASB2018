
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



let [a,[a1,_;a2,_;a3,_;a4,_;a5,_;a6,_;a7,_;a8,_]], signature =
  add_in_signature
    [
      "",[Width 2.;Height 2.;Shape "circle";FillColor "\"#ffffff\""],
      [
        "n",[Direction n],[];
        "ne",[Direction ne],[];
        "e",[Direction e],[];
        "se",[Direction se],[];
        "s",[Direction s],[];
        "sw",[Direction sw],[];
        "w",[Direction w],[];
        "nw",[Direction nw],[]]]
    init

(* CONTACT MAP *)
let
  [
    cm_r,[cm_r1,_;cm_r2,_;cm_r3,_;cm_r4,_;cm_r5,_;cm_r6,_;cm_r7,_;cm_r8,_]
  ],
  remanent
  =
  add_in_graph
    [
      a,0.,0.,[],
      [a1,[],[Free_site []];
       a2,[],[Free_site []];
       a3,[],[Free_site []];
       a4,[],[Free_site []];
       a5,[],[Free_site []];
       a6,[],[Free_site []];
       a7,[],[Free_site []];
       a8,[],[Free_site []];]]
    signature

let list = [cm_r1;cm_r2;cm_r3;cm_r4;cm_r5;cm_r6;cm_r7;cm_r8]
let links =
  List.fold_left
    (fun rep a ->
       List.fold_left
         (fun rep b ->
            if a<>b then
              (a,b)::rep else rep)
         rep list)
    [] list

let remanent = add_link_list links remanent
let _ = dump "clique.ladot" remanent
