
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

let empty = Signature_egfr_sos.signature_egfr




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
       [Internal_state (egfr_Y68_u,[Direction s]);
        Internal_state (egfr_Y68_p,[Direction (of_degree 160.)]);
        Free_site [Direction (of_degree (to_degree sw-.10.))]];
       egfr_Y48,[Direction (of_degree 330.)],
       [Internal_state (egfr_Y48_u,[Direction w]);
        Internal_state (egfr_Y48_p,[Direction (of_degree (-.110.))]);
        Free_site [Direction ne]]];
      shc,-.0.85,12.5,[],
       [shc_pi,[Direction (of_degree 110.)],
        [Free_site []];
        shc_Y7,[Direction (of_degree 250.)],
        [Free_site [Direction sw];
        Internal_state (shc_Y7_u,[Direction w]);
         Internal_state (shc_Y7_p,[Direction (of_degree (-.70.))])]];
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

let remanent = add_fictitious_link [1.5,10.75;0.8,10.2(*10.1*)] remanent


let cp = remanent
let contact_map = cp

let _ = dump "sos_contact_map.ladot" cp


let
  [
    cm_egf,[cm_egf_r,_];
    cm_egfr,[cm_egfr_l,_;cm_egfr_r,_;cm_egfr_c,_;cm_egfr_n,_;
             (*cm_egfr_Y68,_;cm_egfr_Y48,_*)];
    (*cm_shc,[cm_shc_pi,_;cm_shc_Y7,_];
    cm_grb2,[cm_grb2_a,_;cm_grb2_b,_];
      cm_sos,[cm_sos_d,_]*)
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
       (*egfr_Y68,[Direction (of_degree 225.)],
       [Internal_state (egfr_Y68_u,[Direction s]);
        Internal_state (egfr_Y68_p,[Direction (of_degree 160.)]);
        Free_site [Direction (of_degree (to_degree sw-.10.))]];
       egfr_Y48,[Direction (of_degree 330.)],
       [Internal_state (egfr_Y48_u,[Direction w]);
        Internal_state (egfr_Y48_p,[Direction (of_degree (-.110.))]);
         Free_site [Direction ne]]*)];
      (*  shc,-.0.85,12.5,[],
      [shc_pi,[Direction (of_degree 110.)],
       [Free_site []];
       shc_Y7,[Direction (of_degree 250.)],
       [Free_site [Direction sw];
        Internal_state (shc_Y7_u,[Direction w]);
        Internal_state (shc_Y7_p,[Direction (of_degree (-.70.))])]];
      grb2,-.0.85,9.65,[],
      [grb2_a,[Direction n],
       [Free_site [Direction nw]];
       grb2_b,[Direction e],
       [Free_site [Direction se]]];
      sos,2.2,9.65,[],
      [sos_d,[Direction w],
          [Free_site [Direction sw]]]*)]
    empty


let x,remanent = add_empty_graph 1.8 10. remanent
let y,remanent = add_empty_graph 0. 9. remanent

let () =
let remanent =
  add_link_list
    [
      cm_egf_r,cm_egfr_l;
      cm_egfr_l,cm_egf_r;
      cm_egfr_r,cm_egfr_r;
      cm_egfr_c,cm_egfr_n;
      (*
        cm_egfr_Y48,cm_shc_pi;
      cm_shc_Y7,cm_grb2_a;
      cm_grb2_b,cm_sos_d;
      cm_egfr_Y68,cm_grb2_a;*)
    ]
    remanent in

let remanent = add_fictitious_link [1.5,10.75;0.8,10.2(*10.1*)] remanent
in
let cp = remanent in
let contact_map = cp in

let _ = dump "invariant_cm.ladot" cp in ()

let add_flow_cm p remanent =
  add_flow_list
    [
      p cm_egf_r,p cm_egfr_l;
      p cm_egfr_l,p cm_egf_r;
      p cm_egfr_r,p cm_egfr_r;
      p cm_egfr_r,p cm_egfr_c;
      p cm_egfr_r,p cm_egfr_n;
      p cm_egfr_Y48,p cm_shc_pi;
      p cm_shc_Y7,p cm_grb2_a;
      p cm_grb2_b,p cm_sos_d;
      p cm_egfr_Y68,p cm_grb2_a;
      p cm_egfr_r,p cm_egfr_l;
      p cm_egfr_l,p cm_egfr_r;
      p cm_egfr_c,p cm_egfr_Y48;
      p cm_egfr_c,p cm_egfr_Y68;
      p cm_egfr_n,p cm_egfr_Y48;
      p cm_egfr_n,p cm_egfr_Y68;
      p cm_shc_pi,p cm_shc_Y7;
      p cm_shc_Y7,p cm_shc_pi;
      p cm_grb2_a,p cm_grb2_b;
      p cm_grb2_b,p cm_grb2_a
    ]
    remanent

let annotated_contact_map= add_flow_cm (fun x->x) contact_map
let _ = dump "contact_map.dot" contact_map
let _ = dump "contact_map_annotated.dot" annotated_contact_map


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
       egfr_Y68,[Direction (of_degree (to_degree sw-.10.))],
       [Internal_state (egfr_Y68_u,[Direction s]);Free_site ([Direction sw])];
       egfr_Y48,[Direction w;Tag ("frag",2)],[Internal_state (egfr_Y48_p,[Direction nw]);]
      ];
      egf,3.5,13.8,[],
      [egf_r,[Direction s],[]];
      egfr,3.5,12.,[],
       [egfr_l,[Direction n],[];
        egfr_r,[Direction (of_degree (-.45.))],[];
        egfr_c,[Direction (of_degree (-.90.))],[Free_site []];
        egfr_n,[Direction (of_degree (-.135.))],[];
        egfr_Y68,[Direction (of_degree (to_degree se+.10.));Tag ("frag",3)],[Internal_state (egfr_Y68_p,[Direction e])];
        egfr_Y48,[Direction ne;Tag ("frag",4)],[Internal_state (egfr_Y48_p,[Direction e])]
       ];
      shc,-0.4,10.5,[Tag ("frag",2)],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction se],[Internal_state (shc_Y7_p,[Direction s])]];
      shc,5.,13.5,[Tag ("frag",4)],
      [shc_pi,[Direction sw],[];
       shc_Y7,[Direction n],[Free_site [];Internal_state (shc_Y7_p,[Direction ne])]];
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
let sigma_cm,sigma_sp,trans_sp_with_cm = disjoint_union cp trans_sp



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
                     egfr_r,[Direction e],[]];
     egfr,4.4,0.,[],[egfr_r,[Direction w],[]]
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
    add_oriented_link_list [sa,sb] er
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


let
  [
    egf1,[egf1_r,_];
    egfr1,[egfr1_l,_;egfr1_r,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egf,0.,0.,[],
      [egf_r,[Direction e],[]];
      egfr,2.5,0.,[],
      [egfr_l,[Direction w],[];
       egfr_r,[Direction s],[]]]
    signature_egfr

let half_domain = add_link_list [egfr1_l,egf1_r] half_domain
let other_half_domain = move_remanent_bellow 0.5 (horizontal_swap half_domain) half_domain

let sigma1,sigma2,lhs_domain = disjoint_union half_domain other_half_domain

let _,_,_,remanent =
  build_rule ~file:"dimerisation.ladot" ~vgap:(Some 2.) lhs_domain
    (fun remanent ->
       ([],[],[]),snd (add_free_list [lift_site sigma1 egfr1_r,[];
                                      lift_site sigma2 egfr1_r,[]] remanent))
    (fun remanent ->
       ([],[],[]),add_link_list [lift_site sigma1 egfr1_r,lift_site sigma2 egfr1_r] remanent)


let dimer = add_link_list [lift_site sigma1 egfr1_r,lift_site sigma2 egfr1_r] lhs_domain

let _ = dump "dimer.ladot" dimer




let
  [
    egf1,[egf1_r,_];
    egfr1,[egfr1_l,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egf,0.,0.,[],
      [egf_r,[Direction (of_degree 20.)],[]];
      egfr,0.5,2.0,[],
      [egfr_l,[Direction s],[];

      ]
    ]
    signature_egfr

let _ =
  build_rule ~file:"rule1.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_free_list [egf1_r,[];
                                      egfr1_l,[]] remanent))
    (fun remanent ->
       ([],[],[]),add_link_list [egf1_r,egfr1_l] remanent)


let
  [
    egfr1,[egfr1_l,_;egfr1_r,_];
    egfr2,[egfr2_l,_;egfr2_r,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_l,[Direction (of_degree 20.)],[Bound_site []];
       egfr_r,[Direction e],[]];
      egfr,2.,0.,[],
      [egfr_l,[Direction (of_degree (-.20.))],[Bound_site []];
       egfr_r,[Direction w],[]]]
    signature_egfr

let _ =
  build_rule ~file:"rule11.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_free_list [egfr1_r,[];
                                      egfr2_r,[]] remanent))
    (fun remanent ->
       ([],[],[]),add_link_list [egfr1_r,egfr2_r] remanent)


let
  [
    egfr1,[egfr1_r,_;egfr1_c,_;egfr1_n,_];
    egfr2,[egfr2_r,_;egfr2_c,_;egfr2_n,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_r,[Direction (of_degree 20.)],[];
       egfr_c,[Direction e],[];
       egfr_n,[Direction (of_degree 160.)],[Free_site []]];
      egfr,2.,0.,[],
      [egfr_r,[Direction (of_degree (-.20.))],[];
        egfr_c,[Direction w],[Free_site []];
       egfr_n,[Direction (of_degree 200.)],[]]]
    signature_egfr

let half_domain =
  add_link_list [egfr1_r,egfr2_r] half_domain

let _ =
  build_rule ~file:"rule12.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),
       snd (add_free_list
              [egfr1_c,[];
               egfr2_n,[]]
              remanent))
    (fun remanent ->
       ([],[],[]),add_link_list [egfr1_c,egfr2_n] remanent)

let
  [
    egfr1,[egfr1_r,_;_;_];
    (*  egfr2,[egfr2_r,_;_;_];*)
  ],
  half_domain
  =
  add_in_graph
    [  egfr,0.,0.,[],
      [egfr_r,[Direction (of_degree 20.)],[];
       egfr_c,[Direction e],[Free_site []];
       egfr_n,[Direction (of_degree 160.)],[Free_site []]];
       (*  egfr,2.,0.,[],
      [egfr_r,[Direction (of_degree (-.20.))],[];
       egfr_c,[Direction w],[Free_site []];
           egfr_n,[Direction (of_degree 200.)],[Free_site []]]*)]
    signature_egfr

let _ =
  build_rule ~file:"ruledse12.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),(snd (add_bound egfr1_r(*,egfr2_r*) remanent)))
    (fun remanent ->
       ([],[],[]),snd (add_free_list [egfr1_r,[];
                                      (*egfr2_r,[]*)] remanent))


let
  [
    egfr1,[egfr1_l,_;egfr1_r,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.5,2.0,[],
      [egfr_l,[Direction s],[];
       egfr_r,[Direction e],[Free_site []]]]
    signature_egfr

let _ =
  build_rule ~file:"ruledse13.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_bound egfr1_l remanent))
    (fun remanent ->
       ([],[],[]),snd (add_free_list [
                                      egfr1_l,[]] remanent))




let
  [
    egfr1,[egfr1_c,_];
    (*  egfr2,[egfr2_n,_];*)
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [
       egfr_c,[Direction e],[];
     ];
      (*  egfr,2.,0.,[],
      [
          egfr_n,[Direction (of_degree 200.)],[]]*)]
    signature_egfr

let _ =
  build_rule ~file:"ruledse11.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_bound egfr1_c(*,egfr2_n*) remanent))
    (fun remanent ->
       ([],[],[]),
       snd (add_free_list
              [egfr1_c,[];
               (*   egfr2_n,[]*)]
              remanent))



let
  [
    egfr1,[egfr1_r,_];
      egfr2,[egfr2_r,_];
  ],
  half_domain
  =
  add_in_graph
    [  egfr,0.,0.,[],
       [egfr_r,[Direction (of_degree 20.)],[];

      ];
        egfr,2.,0.,[],
           [egfr_r,[Direction (of_degree (-.20.))],[];
      ]]
    signature_egfr

let _ =
  build_rule ~file:"rulewd.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),( (add_link_list [egfr1_r,egfr2_r] remanent)))
    (fun remanent ->
       ([],[],[]),snd (add_free_list [egfr1_r,[];
                                      egfr2_r,[]] remanent))

let
  [
    egfr1,[egfr1_r,_;_;_];
    egfr2,[egfr2_r,_;_;_];
  ],
  half_domain
  =
  add_in_graph
    [  egfr,0.,0.,[],
       [egfr_r,[Direction (of_degree 20.)],[];
        egfr_c,[Direction e],[Free_site []];
        egfr_n,[Direction (of_degree 160.)],[Free_site []]];
       egfr,2.,0.,[],
       [egfr_r,[Direction (of_degree (-.20.))],[];
        egfr_c,[Direction w],[Free_site []];
        egfr_n,[Direction (of_degree 200.)],[Free_site []]]]
    signature_egfr

let _ =
  build_rule ~file:"ruled12.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),( (add_link_list [egfr1_r,egfr2_r] remanent)))
    (fun remanent ->
       ([],[],[]),snd (add_free_list [egfr1_r,[];
                                      egfr2_r,[]] remanent))


let
  [
    egfl,[egfl_r,_];
    egfr1,[egfr1_l,_;egfr1_r,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egf,-1.5,2.0,[],
      [egf_r,[Direction e],[];
      ];
      egfr,0.5,2.0,[],
      [egfr_l,[Direction w],[];
       egfr_r,[Direction e],[Free_site []]]]
    signature_egfr

let _ =
  build_rule ~file:"ruled13.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),(add_link_list [egfl_r,egfr1_l] remanent))
    (fun remanent ->
       ([],[],[]),snd (add_free_list [
           egfr1_l,[];egfl_r,[]] remanent))




let
  [
    egfr1,[egfr1_c,_];
    egfr2,[egfr2_n,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [
        egfr_c,[Direction e],[];
      ];
      egfr,2.,0.,[],
          [
          egfr_n,[Direction (of_degree 200.)],[]]]
    signature_egfr

let _ =
  build_rule ~file:"ruled11.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]), (add_link_list [egfr1_c,egfr2_n] remanent))
    (fun remanent ->
       ([],[],[]),
       snd (add_free_list
              [egfr1_c,[];
                 egfr2_n,[]]
              remanent))

let
  [
    egfr0,[egfr0_n,_];
    egfr1,[egfr1_c,_;egfr1_48,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.,0.,[],
      [egfr_n,[Direction (of_degree 20.)],[]];
      egfr,0.5,2.0,[],
      [egfr_c,[Direction s],[];
       egfr_Y48,[Direction e],[]]]
    signature_egfr
let half_domain = add_link_list [egfr0_n,egfr1_c] half_domain

let _ =
  build_rule  ~file:"rule2.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_u  remanent)
    )
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_p  remanent))

let
  [
    egf1,[egf1_r,_];
    egfr1,[egfr1_l,_;egfr1_48,_];
    egf2,[egf2_r,_];
    egfr2,[egfr2_l,_;egfr2_48,_]],
  half_domain
  =
  add_in_graph
    [
      egf,0.,0.,[],
      [egf_r,[Direction (of_degree 20.)],[]];
      egfr,0.5,2.0,[],
      [egfr_l,[Direction s],[];
       egfr_Y48,[Direction se],[Free_site [Direction e];Internal_state (egfr_Y48_u,[])]];
      egf,5.,-0.5,[],
      [egf_r,[Direction (of_degree 20.)],[]];
      egfr,5.5,2.5,[],
      [egfr_l,[Direction s],[];
       egfr_Y48,[Direction se],[Free_site [Direction e];Internal_state (egfr_Y48_u,[])]]
    ]
    signature_egfr

let _,half_domain = add_binding_type egf2_r egfr_l half_domain
let _,half_domain = add_binding_type egfr2_l egf_r half_domain
let half_domain = add_link_list [egf1_r,egfr1_l] half_domain

let half_domain = add_proj [egf1,egf2;egfr1,egfr2] half_domain
let _ = dump "local_view.ladot" half_domain


let
  [
    egfr1,[egfr1_l,_;egfr1_48,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.5,2.0,[],
      [egfr_c,[Direction s],[Free_site []];
       egfr_Y48,[Direction e],[]]]
    signature_egfr


let _ =
  build_rule ~file:"rule3.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_u  remanent)
    )
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_p  remanent))

let
  [
    egfr1,[egfr1_48,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.5,2.0,[],
      [   egfr_Y48,[Direction e],[]]]
    signature_egfr


let _ =
  build_rule ~file:"rule4.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_u  remanent)
    )
    (fun remanent ->
       ([],[],[]),snd (add_internal_state egfr1_48 egfr_Y48_p  remanent))


let
  [
    egfr1,[egfr1_l,_;egfr1_48,_];
  ],
  half_domain
  =
  add_in_graph
    [
      egfr,0.5,2.0,[],
      [egfr_r,[Direction s],[];
       egfr_Y48,[Direction e],[Free_site [Direction ne]]]]
    signature_egfr


let _ =
  build_rule  ~file:"rule5.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),snd (add_bound egfr1_l (snd (add_internal_state egfr1_48 egfr_Y48_u  remanent)))
    )
    (fun remanent ->
       ([],[],[]),snd (add_free egfr1_l (snd (add_internal_state egfr1_48 egfr_Y48_p  remanent))))

let
  half_domain
  =
    signature_egfr


let _ =
  build_rule ~file:"rule6.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),remanent)
    (fun remanent ->
       ([],[],[]),
       let _,rem =
         add_in_graph
           [egfr,2.5,2.0,[],
            [egfr_r,[Direction (of_degree 45.)],[Free_site []];
             egfr_l,[Direction n],[Free_site []];
             egfr_c,[Direction e],[Free_site []];
             egfr_n,[Direction (of_degree 135.)],[Free_site []];
             egfr_Y48,[Direction (of_degree (to_degree sw-.10.))],[Free_site [];Internal_state (egfr_Y48_u,[])];
            egfr_Y68,[Direction w],[Free_site [];Internal_state (egfr_Y68_u,[])]];
           ]
           remanent
       in
       rem)


let _ =
  build_rule ~file:"rule7.ladot" ~vgap:(Some 2.) half_domain
    (fun remanent ->
       ([],[],[]),
       let _,rem =
         add_in_graph
           [egfr,0.,0.,[],[]]
             remanent
       in
        rem)
    (fun remanent ->
       ([],[],[]),remanent)

let [agr1,[siter1,_];agr2,[siter2,_]],agrdomain =
  add_in_graph
    [egfr,-1.,0.,[],[egfr_r,[Direction e],[]];
     egfr,1.,0.,[],[egfr_r,[Direction w],[]]]
    signature_egfr

let _,_,_,ruletop =
  build_rule ~vgap:(Some 2.) agrdomain
    (fun remanent ->
       ([],[],[]),
       add_link_list [siter1,siter2] remanent)
    (fun remanent ->
       ([],[],[]),
       snd (add_free_list [siter1,[Direction se];siter2,[Direction sw]] remanent))

let [agr1,[siter1,_;sitel1,_;_];agr2,[siter2,_;sitel2,_;_]],agrdomain =
  add_in_graph
    [egfr,-1.,0.,[],[egfr_r,[Direction (of_degree 160.)],[];
                     egfr_l,[Direction sw],[Free_site []];
                     egfr_Y48,[Direction e],[Free_site [];Internal_state (egfr_Y48_u,[Direction se])]];
     egfr,1.,0.,[],[egfr_r,[Direction (of_degree 160.)],[];
                    egfr_l,[Direction sw],[];
                    egfr_Y48,[Direction e],[Free_site [];Internal_state (egfr_Y48_p,[Direction se])]
                   ]]
    signature_egfr

let agrdomain = snd (add_binding_type sitel2 egf_r agrdomain)

let _,_,_,rulebottom =
  build_rule ~vgap:(Some 2.) agrdomain
    (fun remanent ->
       ([],[],[]),
       let _,rem = add_binding_type siter1 egfr_r remanent in
       let rem = snd (add_binding_type siter2 egfr_r remanent) in
       let rem = snd (add_binding_type siter1 egfr_r rem) in
       rem)
    (fun remanent ->
       ([],[],[]),
       snd(add_free_list [siter1,[];siter2,[]] remanent))

let rulebottom = insert_text_here "$\\sharp$" 3.04 0.12 ~directives:[Fontsize  12] rulebottom

let rulebottom = move_remanent_bellow 1. (translate_graph {abscisse=(-0.2599999);ordinate=0.} rulebottom) ruletop

let _,_,rules = disjoint_union ruletop rulebottom
let _ = dump "abstractrule.ladot" rules


let [egf1,[egf1_l,_];
     egfr1,[l1,_;r1,_;c1,_;n1,_;_;_];
     egf2,[egf2_l,_];
     egfr2,[l2,_;r2,_;c2,_;n2,_;_;_];
     egf3,[egf3_l,_];
          egfr3,[l3,_;r3,_;c3,_;n3,_;_;_];
    ],
     trimer =
add_in_graph
  [ egf,0.6,9.8,[],[egf_r,[Direction s],[]];
    egfr,0.6,8.,[],
  [egfr_l,[Direction n],
   [];
   egfr_r,[Direction (of_degree 90.)],
   [];
   egfr_c,[Direction (of_degree 120.)],
   [Free_site []];
   egfr_n,[Direction (of_degree 150.)],
   [Free_site []];
   egfr_Y68,[Direction sw],
   [Internal_state (egfr_Y68_u,[Direction s]);
    Free_site [Direction (of_degree (to_degree sw-.10.))]];
   egfr_Y48,[Direction nw],
   [Internal_state (egfr_Y48_u,[Direction w]);
    Free_site [Direction n]]];
    egf,2.6,9.8,[],[egf_r,[Direction s],[]];
    egfr,2.6,8.,[],
    [egfr_l,[Direction n],
     [];
     egfr_r,[Direction w],
     [];
     egfr_c,[Direction (of_degree 120.)],
     [];
     egfr_n,[Direction (of_degree 150.)],
     [Free_site []];
     egfr_Y68,[Direction sw],
     [Internal_state (egfr_Y68_u,[Direction s]);
      Free_site [Direction (of_degree (to_degree sw-.10.))]];
     egfr_Y48,[Direction nw],
     [Internal_state (egfr_Y48_u,[Direction w]);
      Free_site [Direction n]]];
    egf,4.6,9.8,[],[egf_r,[Direction s],[]];
    egfr,4.6,8.,[],
    [egfr_l,[Direction n],
     [];
     egfr_r,[Direction (of_degree 90.)],
     [Bound_site [Direction e]];
     egfr_c,[Direction (of_degree (-.150.))],
     [Free_site []];
     egfr_n,[Direction (of_degree (-.120.))],
     [];
     egfr_Y68,[Direction se],
     [Internal_state (egfr_Y68_u,[Direction s]);
      Free_site [Direction (of_degree (to_degree sw-.10.))]];
     egfr_Y48,[Direction nw],
     [Internal_state (egfr_Y48_u,[Direction w]);
      Free_site [Direction n]]]] empty

let trimer =
  add_link_list
    [egf1_l,l1;
     egf2_l,l2;
     egf3_l,l3;
     r1,r2;
     c2,n3;
    ]
    trimer

let _ = dump "trimera.ladot" trimer

let [egf1,[egf1_l,_];
     egfr1,[l1,_;r1,_;c1,_;n1,_;_;_];
     egf2,[egf2_l,_];
     egfr2,[l2,_;r2,_;c2,_;n2,_;_;_];
     egf3,[egf3_l,_];
     egfr3,[l3,_;r3,_;c3,_;n3,_;_;_];
    ],
    trimer =
  add_in_graph
    [ egf,4.6,9.8,[],[egf_r,[Direction s],[]];
      egfr,4.6,8.,[],
      [egfr_l,[Direction n],
       [];
       egfr_r,[Direction w],
       [];
       egfr_c,[Direction (of_degree (-.120.))],
       [Free_site []];
       egfr_n,[Direction (of_degree (-.150.))],
       [Free_site []];
       egfr_Y68,[Direction se],
       [Internal_state (egfr_Y68_u,[Direction s]);
        Free_site [Direction (of_degree (to_degree se+.10.))]];
       egfr_Y48,[Direction ne],
       [Internal_state (egfr_Y48_u,[Direction e]);
        Free_site [Direction n]]];
      egf,2.6,9.8,[],[egf_r,[Direction s],[]];
      egfr,2.6,8.,[],
      [egfr_l,[Direction n],
       [];
       egfr_r,[Direction e],
       [];
       egfr_c,[Direction (of_degree (-.120.))],
       [];
       egfr_n,[Direction (of_degree (-.150.))],
       [Free_site []];
       egfr_Y68,[Direction se],
       [Internal_state (egfr_Y68_u,[Direction s]);
        Free_site [Direction (of_degree (to_degree se+.10.))]];
       egfr_Y48,[Direction ne],
       [Internal_state (egfr_Y48_u,[Direction e]);
        Free_site [Direction n]]];
      egf,0.6,9.8,[],[egf_r,[Direction s],[]];
      egfr,0.6,8.,[],
      [egfr_l,[Direction n],
       [];
       egfr_r,[Direction w],
       [Bound_site [Direction w]];
       egfr_c,[Direction (of_degree (150.))],
       [Free_site []];
       egfr_n,[Direction (of_degree (120.))],
       [];
       egfr_Y68,[Direction sw],
       [Internal_state (egfr_Y68_u,[Direction s]);
        Free_site [Direction (of_degree (to_degree se+.10.))]];
       egfr_Y48,[Direction ne],
       [Internal_state (egfr_Y48_u,[Direction e]);
        Free_site [Direction n]]]] empty

let trimer =
  add_link_list
    [egf1_l,l1;
     egf2_l,l2;
     egf3_l,l3;
     r1,r2;
     c2,n3;
    ]
    trimer


    let _ = dump "trimerb.ladot" trimer

let [
     egfr1,[r1,_];
     egfr2,[r2,_;c2,_];
     egfr3,[n3,_];
    ],
    trimer =
  add_in_graph
    [
      egfr,0.6,8.,[],
       [egfr_r,[Direction e],
        []];
      egfr,2.6,8.,[],
      [
       egfr_r,[Direction w],
       [];
       egfr_c,[Direction e],
       []];
      egfr,4.6,8.,[],
      [
        egfr_n,[Direction w],
       [];
      ]] empty

let trimer =
  add_link_list
    [r1,r2;
     c2,n3;
    ]
    trimer


let _ = dump "repeatable_dimers.ladot" trimer
