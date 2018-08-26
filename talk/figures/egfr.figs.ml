
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

let empty = Signature_egfr.signature_egfr




(* CONTACT MAP *)
let
  [
    cm_egf,[cm_egf_r,_];
    cm_egfr,[cm_egfr_l,_;cm_egfr_r,_;cm_egfr_c,_;cm_egfr_n,_;
             cm_egfr_Y68,_;cm_egfr_Y48,_];
    cm_shc,[cm_shc_pi,_;cm_shc_Y7,_];
    cm_grb2,[cm_grb2_a,_;cm_grb2_b,_];
    cm_sos,[cm_sos_d,_]
  ],
  remanent
  =
  add_in_graph
    [
      egf,2.2,12.5,[],[egf_r,[Direction (of_degree 220.)],[Free_site [Direction se ]]];
      egfr,0.6,11.,[],
      [egfr_l,[Direction (of_degree 30.)],
       [Free_site [Direction e]];
       egfr_r,[Direction (of_degree 90.)],
       [Free_site [Direction ne]];
       egfr_c,[Direction (of_degree 120.)],
       [Free_site [Direction e]];
       egfr_n,[Direction (of_degree 150.)],
       [Free_site [Direction s]];
       egfr_Y68,[Direction (of_degree 225.)],
       [Free_site [Direction (of_degree (to_degree sw-.10.))]];
       egfr_Y48,[Direction (of_degree 330.)],
       [Free_site [Direction ne]]];
      shc,-.0.85,12.5,[],
       [shc_pi,[Direction (of_degree 110.)],
        [Free_site []];
        shc_Y7,[Direction (of_degree 250.)],
        [Free_site [Direction sw]]];
      grb2,-.0.85,9.65,[],
       [grb2_a,[Direction n],
        [Free_site [Direction nw]];
        grb2_b,[Direction e],
        [Free_site [Direction se]]];
      sos,2.2,9.65,[],
        [sos_d,[Direction w],
       [Free_site [Direction sw]]]]
    empty


let x,remanent = add_empty_graph 1.8 10. remanent
let y,remanent = add_empty_graph 0. 9. remanent

let remanent =
  add_link_list
    [
      cm_egf_r,cm_egfr_l;
      cm_egfr_l,cm_egf_r;
      cm_egfr_r,cm_egfr_r;
      cm_egfr_c,cm_egfr_n;
      cm_egfr_Y48,cm_shc_pi;
      cm_shc_Y7,cm_grb2_a;
      cm_grb2_b,cm_sos_d;
      cm_egfr_Y68,cm_grb2_a;
    ]
    remanent

let remanent = add_fictitious_link [1.6,10.8;0.75,10.1] remanent


let contact_map = remanent


let _ = dump "contact_map.ladot" contact_map


(*SPECIES*)

let
  [
    sp_egf1,[sp_egf1_r,_];
    sp_egfr1,[sp_egfr1_l,_;sp_egfr1_r,_;sp_egfr1_c,_;sp_egfr1_n,_;sp_egfr1_Y68,_;sp_egfr1_Y48,_];
    sp_egf2,[sp_egf2_r,_];
    sp_egfr2,[sp_egfr2_l,_;sp_egfr2_r,_;sp_egfr2_c,_;sp_egfr2_n,_;sp_egfr2_Y68,_;sp_egfr2_Y48,_]  ;
    sp_shc1,[sp_shc1_pi,_;sp_shc1_Y7,_] ;
    sp_shc2,[sp_shc2_pi,_;sp_shc2_Y7,_] ;
    sp_grb21,[sp_grb21_a,_;sp_grb21_b,_] ;
    sp_grb22,[sp_grb22_a,_;sp_grb22_b,_] ;
    sp_sos1,[sp_sos1_d,_]
  ],
  remanent
  =
  add_in_graph
    [
      egf,1.,13.8,[],
      [egf_r,[Direction s],[]];
      egfr,1.,12.,[],
      [egfr_l,[Direction n],[];
       egfr_r,[Direction (of_degree 45.)],[];
       egfr_c,[Direction (of_degree 90.)],[];
       egfr_n,[Direction (of_degree 135.)],[Free_site []];
       egfr_Y68,[Direction (of_degree (to_degree sw-.10.))],[Free_site ([Direction sw])];
       egfr_Y48,[Direction w;Tag ("frag",2)],[]
      ];
      egf,3.5,13.8,[],
      [egf_r,[Direction s],[]];
      egfr,3.5,12.,[],
       [egfr_l,[Direction n],[];
        egfr_r,[Direction (of_degree (-.45.))],[];
        egfr_c,[Direction (of_degree (-.90.))],[Free_site []];
        egfr_n,[Direction (of_degree (-.135.))],[];
        egfr_Y68,[Direction (of_degree (to_degree se+.10.));Tag ("frag",3)],[];
        egfr_Y48,[Direction ne;Tag ("frag",4)],[]
       ];
      shc,-0.4,10.5,[Tag ("frag",2)],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction se],[]];
      shc,5.,13.5,[Tag ("frag",4)],
      [shc_pi,[Direction sw],[];
       shc_Y7,[Direction n],[Free_site []]];
      grb2,1.8,9.,[Tag ("frag",2)],
      [grb2_a,[Direction nw],[];
       grb2_b,[Direction e],[]];
      grb2,2.8,10.,[Tag ("frag",3)],
      [grb2_a,[Direction n],[];
       grb2_b,[Direction w],[Free_site [Direction sw]]];
      sos,4.5,9.,[Tag ("frag",2)],
      [sos_d,[Direction w],[]]]
    empty

let remanent =
  add_link_list
    [
      sp_egfr1_r,sp_egfr2_r;
      sp_egfr2_r,sp_egfr1_r;
      sp_egf2_r,sp_egfr2_l;
      sp_egf1_r,sp_egfr1_l;
      sp_egfr1_l,sp_egf1_r;
      sp_egfr2_l,sp_egf2_r;
      sp_egfr1_c,sp_egfr2_n;
      sp_egfr1_Y48,sp_shc1_pi;
      sp_egfr2_Y48,sp_shc2_pi;
      sp_shc1_Y7,sp_grb21_a;
      sp_grb21_b,sp_sos1_d;
      sp_egfr2_Y68,sp_grb22_a
    ]
    remanent

let species = remanent

let _ = dump "species.ladot" ~flags:["flow",0]  species
(* SPECIES + CM *)

let trans_sp = translate_graph {abscisse = -9.;ordinate =  0.} species
let sigma_cm,sigma_sp,trans_sp_with_cm = disjoint_union contact_map trans_sp



let proj =
  List.rev_map
    (fun (x,y) -> lift_agent sigma_sp x,lift_agent sigma_cm y)
    [sp_grb22,cm_grb2;
     sp_grb21,cm_grb2;
     sp_egfr2,cm_egfr;
     sp_egfr1,cm_egfr;
     sp_egf2,cm_egf;
     sp_egf1,cm_egf;
     sp_shc2,cm_shc;
     sp_shc1,cm_shc;
     sp_sos1,cm_sos]

let proj_inv = List.map (fun (x,y) -> (y,x)) proj

let species_cm =
  add_proj
    proj
    trans_sp_with_cm

let _ = dump "egfr_embed.ladot"   species_cm

    (* graph of sites *)

(*let col i = (float_of_int i)*.1.4
let row i = (float_of_int i)*.1.4
let [
  egf_l,_;
  egfr_l,_;
  egfr_c,_;
  egfr_r,_;
  egfr_n,_;
  egfr_Y48,_;
  egfr_Y68,_;
  grb2_a,_;
  grb2_b,_;
  shc_pi,_;
  shc_Y7,_;
  sos_d,_
], graph_site
  =
  add_in_graph
    [
      egf,col 1,row 3,[],[egf_r,[],[]];
      egfr,col 1,row 1,[],[egfr_l,[],[]];
      egfr,col 0,row 2,[],[egfr_c,[],[]];
      egfr,col 1,row 2,[],[egfr_r,[],[]];
      egfr,col 2,row 2,[],[egfr_n,[],[]];
      egfr,col 3,row 1,[],[egfr_Y48,[],[]];
      egfr,col 0,row 1,[],[egfr_Y68,[],[]];
      grb2,col 2,row 3,[],[grb2_a,[],[]];
      grb2,col 2,row 0,[],[grb2_b,[],[]];
      shc,col 0,row 3 ,[],[shc_pi,[],[]];
      shc,col 2,row 1 ,[],[shc_Y7,[],[]];
      sos,col 2,row 3, [],[sos_d,[],[]];
    ]
    empty

let graph_site =
  add_proj ~color:"black"
    [
      egf_l,egfr_l;
      egf_l,egfr_c
    ]
    graph_site

  let _ = dump "egfr_graph_site.ladot" graph_site*)

let plot_site (a,b,name) =
  let _,er =
    add_in_graph
      [a,0.,0.,[],[b,[],[]]]
      empty
  in
  dump (name^".ladot") er

let () =
  List.iter
    plot_site
    [
      segf,segf_r,"egf_r";
      segfr,segfr_l,"egfr_l";
      segfr,segfr_r,"egfr_r";
      segfr,segfr_c,"egfr_c";
      segfr,segfr_n,"egfr_n";
      segfr,segfr_Y48,"egfr_Y48";
      segfr,segfr_Y68,"egfr_Y68";
      sgrb2,sgrb2_a,"grb2_a";
      sgrb2,sgrb2_b,"grb2_b";
      sshc,sshc_pi,"shc_pi";
      sshc,sshc_Y7,"shc_Y7";
      ssos,ssos_d,"sos_d"]

let [_,[sa,_];
     _,[sb,_;sc,_];
     _,[sd,_]],g
  =
  add_in_graph
    [egfr,0.,0.,[],[egfr_c,[Direction e],[]];
     egfr,2.2,0.,[],[egfr_n,[Direction w],[];
                     egfr_c,[Direction e],[]];
     egfr,4.4,0.,[],[egfr_n,[Direction w],[]]
    ]
    empty
let g =
add_link_list [sa,sb;sc,sd] g

let () = dump "egfr_egfr_egfr.ladot" g

let plot_link (a,b,c,d,name) =
  let [_,[sa,_];_,[sb,_]],er =
    add_in_graph
      [a,0.,0.,[],[b,[Direction e],[]];
       c,1.8,0.,[],[d,[Direction w],[]]]
      empty
  in
  let er =
    add_link_list [sa,sb] er
  in
  dump (name^".ladot") er

let () =
        List.iter
          plot_link
          [
            segf,segf_r,segfr,segfr_l,"egf_egfr";
            segfr,segfr_l,segf,segf_r,"egfr_egf";
            segfr,segfr_r,segfr,segfr_r,"egfr_egfr_r";
            segfr,segfr_c,segfr,segfr_n,"egfr_egfr_c";
            segfr,segfr_n,segfr,segfr_c,"egfr_egfr_n";
            segfr,segfr_Y48,sshc,sshc_pi,"egfr_shc";
            segfr,segfr_Y68,sgrb2,sgrb2_a,"egfr_grb2";
            sgrb2,sgrb2_a,sshc,sshc_Y7,"grb2_shc";
            sgrb2,sgrb2_a,segfr,segfr_Y68,"grb2_egfr";
            sgrb2,sgrb2_b,ssos,ssos_d,"grb2_sos";
            sshc,sshc_pi,segfr,segfr_Y48,"shc_egfr";
            sshc,sshc_Y7,sgrb2,sgrb2_a,"shc_grb2";
            ssos,ssos_d,sgrb2,sgrb2_b,"sos_grb2"]

let plot_two_links (a,b,c,d,e',f,g,name) =
  let [_,[sa,_];_,[sb,_;sc,_];_,[sd,_]],er =
    add_in_graph
      [a,0.,0.,[],[b,[Direction e],[]];
       c,1.8,0.,[],[d,[Direction w],[];
                    e',[Direction e],[]];
       f,3.6,0.,[],[g,[Direction w],[]]]
      empty
  in
  let er =
    add_link_list [sa,sb;sc,sd] er
  in
  dump (name^".ladot") er

let () =
  List.iter
    plot_two_links
    [
      segfr,segfr_r,segfr,segfr_r,segfr_c,segfr,segfr_n,"egfr_r_c";
      segfr,segfr_r,segfr,segfr_r,segfr_n,segfr,segfr_c,"egfr_r_n";
      segfr,segfr_n,segfr,segfr_c,segfr_n,segfr,segfr_c,"egfr_n_c";
      ]
