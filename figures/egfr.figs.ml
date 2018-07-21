
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
open Signature_egfr

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
       [Free_site [Direction se]];
       egfr_c,[Direction (of_degree 120.)],
       [Free_site [Direction se]];
       egfr_n,[Direction (of_degree 150.)],
       [Free_site [Direction se]];
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
      cm_egfr_Y68,cm_grb2_a]
    remanent

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
       shc_Y7,[Direction n],[]];
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


    let _ = dump "species_cm.ladot"   species_cm
    (*
(* RULE *)
let
  [
    rule_shc,[rule_shc_Y7,_;rule_shc_pi,_];
    rule_egfr,[rule_egfr_r,_;rule_egfr_Y48,_];
  ],
  lhs_domain
  =
  add_in_graph
    [
      shc,-5.,13.5,[],
      [shc_Y7,[Direction n],[Free_site [Direction n]];
       shc_pi,[Direction se],[]];
      egfr,-3.,12.,[],
      [egfr_r,[Direction s],[Bound_site [Direction s]];
      egfr_Y48,[Direction (of_degree (to_degree nw+.5.))],[Internal_state (egfr_Y48_p,[Direction (of_degree (to_degree nw+.20.))])]]]
    empty

let lhs_domain = add_link_list [rule_egfr_Y48,rule_shc_pi] lhs_domain

let sigmal,_,_,rule =
  build_rule
    lhs_domain
    (fun remanent ->
      ([],[],[]),snd (add_internal_state rule_shc_Y7 shc_Y7_u ~directives:[Direction ne] remanent))
    (fun remanent ->
      ([],[],[]),snd (add_internal_state rule_shc_Y7 shc_Y7_p ~directives:[Direction ne] remanent))
    ~directives:[Direction s]

let _ = dump "flow_rule.dot" ~flags:["contact_map",0;"flow",0]  rule

let annotated_rule =
  add_flow_list
    [
      rule_egfr_r,rule_egfr_Y48;
      rule_egfr_Y48,rule_shc_pi;
      rule_shc_pi,rule_shc_Y7
    ]
    rule

let _ = dump "flow_annotated_rule.dot" annotated_rule

(* RULE + CM *)

let proj_list sigmar sigmal =
  List.map (fun (x,y) -> lift_agent sigmar x,lift_agent sigmal y)

let proj_list_cm sigmar sigmal =
  proj_list sigmar sigmal
    [
      rule_shc,cm_shc;
      rule_egfr,cm_egfr
    ]

let proj_list_sp sigmar sigmal =
  proj_list sigmar sigmal
    [
      rule_shc,sp_shc2;
      rule_egfr,sp_egfr2
    ]

let add_flow sigma =
  List.map (fun (x,y) -> lift_site sigma x,lift_site sigma y)

let add_flow_cm sigmal  =
  add_flow sigmal
    [
      cm_egfr_r,cm_egfr_Y48;
      cm_egfr_Y48,cm_shc_pi;
      cm_shc_pi,cm_shc_Y7
    ]

let add_flow_species sigmal =
  add_flow sigmal
    [
      sp_egfr2_r,sp_egfr2_Y48;
      sp_egfr2_Y48,sp_shc2_pi;
      sp_shc2_pi,sp_shc2_Y7
    ]

let _ = proj_flow_on_a_species ~file:"flow_rule_proj_sp_"  ~padding:20. annotated_rule (vertical_swap species) [rule_shc,sp_shc2;rule_egfr,sp_egfr2]
let _ = proj_flow_on_a_species ~file:"flow_rule_proj_contact_map_" ~padding:20. annotated_rule contact_map [rule_shc,cm_shc;rule_egfr,cm_egfr]

(* frag3 + CM *)

let exaa = [Tag ("Exab",0);Tag("Exac",0);Tag("Exad",0)]

let
  [
    sp_egf1,[sp_egf1_r,_];
    sp_egfr1,[sp_egfr1_l,_;sp_egfr1_r,_;sp_egfr1_Y68,_;sp_egfr1_Y48,_];
    sp_egf2,[sp_egf2_r,_];
    sp_egfr2,[sp_egfr2_l,_;sp_egfr2_r,_;sp_egfr2_Y68,_]  ;
  ],
  short_species
  =
  add_in_graph
    [
      egf,1.,13.8,[],
      [egf_r,[Direction s],[]];
      egfr,1.,12.,[],
      [egfr_l,[Direction n],[];
       egfr_r,[Direction e],[];
       egfr_Y68,[Direction s;Tag ("Exaa",0);Tag ("Exab",0);Tag("Exac",0)],[Free_site ([Direction sw]);Internal_state (egfr_Y68_u,[Direction (se)])];
       egfr_Y48,[Direction w;Tag ("Exad",0);Tag ("Exac",0)],[Free_site ([Direction (of_degree 305.)]);Internal_state (egfr_Y48_p,[Direction (of_degree 225.)])]
      ];
      egf,3.5,13.8,[],
      [egf_r,[Direction s],[]];
      egfr,3.5,12.,[],
       [egfr_l,[Direction n],[];
	egfr_r,[Direction w],[];
	egfr_Y68,[Direction s;Tag ("Exaa",0);Tag ("Exad",0);Tag("Exac",0)],[Free_site [Direction sw];Internal_state (egfr_Y68_p,[Direction se])];
       ]]
    empty

let short_species =
  add_link_list
    [
      sp_egfr1_r,sp_egfr2_r;
      sp_egf2_r,sp_egfr2_l;
      sp_egf1_r,sp_egfr1_l;
    ]
    short_species

let short_species =
   add_flow_list
    [
      sp_egfr1_r,sp_egfr2_r;
      sp_egfr2_r,sp_egfr1_r;
      sp_egf2_r,sp_egfr2_l;
      sp_egf1_r,sp_egfr1_l;
      sp_egfr1_l,sp_egf1_r;
      sp_egfr2_l,sp_egf2_r;
      sp_egfr1_l,sp_egfr1_r;
      sp_egfr1_r,sp_egfr1_Y48;
      sp_egfr1_r,sp_egfr1_Y68;
      sp_egfr2_l,sp_egfr2_r;
      sp_egfr2_r,sp_egfr2_Y68
    ]
     short_species

let _ = dump "short_species_exa_annotated.dot" ~flags:["Exaa",1]  short_species
let _ = dump "short_species_exa.dot" ~flags:["Exaa",1;"flow",0]  short_species
let _ = dump "short_species_exb_annotated.dot" ~flags:["Exab",1]  short_species
let _ = dump "short_species_exb.dot" ~flags:["Exab",1;"flow",0]  short_species
let _ = dump "short_species_exc_annotated.dot" ~flags:["Exac",1]  short_species
let _ = dump "short_species_exc.dot" ~flags:["Exac",1;"flow",0]  short_species
let _ = dump "short_species_exd_annotated.dot" ~flags:["Exad",1]  short_species
let _ = dump "short_species_exd.dot" ~flags:["Exad",1;"flow",0]  short_species
let _ = dump "short_species_exb_annotated_crossed.dot" ~flags:["Exab",1]  (cross short_species)
let _ = dump "short_species_exb_crossed.dot" ~flags:["Exab",1;"flow",0]  (cross short_species )
let _ = dump "short_species_exc_annotated_crossed.dot" ~flags:["Exac",1]  (cross short_species)
let _ = dump "short_species_exc_crossed.dot" ~flags:["Exac",1;"flow",0]  (cross short_species )


(* FRAG CONS / PROD  *)
let
  [
    cons_shc,[cons_shc_Y7,_;cons_shc_pi,_];
    cons_egfr,[cons_egfr_r,_;cons_egfr_Y48,_];
  ],
  lhs_domain
  =
  add_in_graph
    [
      shc,-5.,12.,[],
      [shc_Y7,[Direction w],[Free_site[Direction nw]];
       shc_pi,[Direction e],[]];
      egfr,-3.,12.,[],
      [egfr_r,[Direction e],[Bound_site [Direction se]];
      egfr_Y48,[Direction w],[]]]
    empty

let lhs_domain = add_link_list [cons_egfr_Y48,cons_shc_pi] lhs_domain

let sigmal,sigmar,_,rule =
  build_rule
    lhs_domain
    (fun remanent ->
      ([],[],[]),snd (add_internal_state cons_shc_Y7 shc_Y7_u ~directives:[Direction sw] remanent))
    (fun remanent ->
      ([],[],[]),snd (add_internal_state cons_shc_Y7 shc_Y7_p ~directives:[Direction sw] remanent))
    ~directives:[Direction e]


let _ = dump "flow_cons_rule_e.dot" ~flags:["contact_map",0;"flow",0]  rule

let cons_egfr_l,fragment = add_site cons_egfr egfr_l ~directives:[Direction s] lhs_domain
let _,fragment = add_bound cons_egfr_l ~directives:[Direction se] fragment


let sigmarule,sigmafragment,cons =   disjoint_union rule (move_remanent_bellow 1. fragment lhs_domain)

let sigmalrule = compose_lift sigmarule sigmal
let lift =
  List.map
    (fun x -> lift_agent sigmalrule x,lift_agent sigmafragment x)
let pairing = lift [cons_egfr;cons_shc]
let cons1 = add_match pairing cons

let cons2 = add_proj pairing
  (snd (add_internal_state
     (lift_site sigmafragment cons_shc_Y7)
     shc_Y7_u
     ~directives:[Direction sw;Color "red"]
     cons ))

let _ = dump "flow_cons_match.dot" ~flags:["contact_map",0;"flow",0]  cons1
let _ = dump "flow_cons_proj.dot" ~flags:["contact_map",0;"flow",0]  cons2


let
  [
    frag_shc,[frag_shc_Y7,_;frag_shc_pi,_];
    frag_egfr,[frag_egfr_l,_;frag_egfr_Y48,_];
  ],
  fragment
  =
  add_in_graph
    [
      shc,-5.,12.,[],
      [shc_Y7,[Direction w],[Bound_site[Direction nw]];
       shc_pi,[Direction e],[]];
      egfr,-3.,12.,[],
      [egfr_l,[Direction s],[Bound_site  [Direction se]];
      egfr_Y48,[Direction w],[]]]
    empty

let _,fragment = add_bound frag_egfr_l ~directives:[Direction se] fragment
let fragment = add_link_list [frag_egfr_Y48,frag_shc_pi] fragment

let sigmarule,sigmafragment,prod =   disjoint_union rule (move_remanent_bellow 1. (translate_graph {abscisse = 6.;ordinate =  0.} fragment) lhs_domain)
let sigmaruler = compose_lift sigmarule sigmar
let sigmarulel = compose_lift sigmarule sigmal
let lift =
  List.map (fun (x,y) -> lift_agent sigmaruler x,lift_agent sigmafragment y)
let prod1 = add_match (lift [cons_egfr,frag_egfr;cons_shc,frag_shc]) prod
let st,prod2 = add_site (lift_agent sigmaruler cons_egfr) egfr_l  ~directives:[Direction s;Color "red"] prod1
let _,prod2 = add_bound st ~directives:[Color "red";Direction se] prod2
let st,prod2 = add_site (lift_agent sigmarulel cons_egfr) egfr_l ~directives:[Direction s;Color "red"] prod2
let _,prod2 = add_bound st ~directives:[Color "red";Direction se] prod2
let _ = dump "flow_prod_match.dot" ~flags:["contact_map",0;"flow",0]  prod1
let _ = dump "flow_prod_overlap.dot" ~flags:["contact_map",0;"flow",0]  prod2

let
  [
    sp_egf1,[sp_egf1_r,_];
    sp_egfr1,[sp_egfr1_l,_;sp_egfr1_r,_;sp_egfr1_Y68,_;sp_egfr1_Y48,_];
    sp_egf2,[sp_egf2_r,_];
    sp_egfr2,[sp_egfr2_l,_;sp_egfr2_r,_;sp_egfr2_Y68,_;sp_egfr2_Y48,_];
    sp_shc,[sp_shc_pi,_;sp_shc_Y7,_]],
  short_species
  =
  add_in_graph
    [
      egf,1.,13.8,[Tag ("species",1)],
      [	egf_r,[Direction s],[]];
      egfr,1.,12.,[Tag ("species",1)],
      [egfr_l,[Direction n],[];
       egfr_r,[Direction e],[];
       egfr_Y68,[Direction s;Tag ("Exaa",0);Tag ("Exab",0);Tag("Exac",0)],[Free_site ([Direction sw]);Internal_state (egfr_Y68_u,[Direction (se)])];
       egfr_Y48,[Direction w;Tag ("Exad",0);Tag ("Exac",0)],[Free_site ([Direction (of_degree 305.)]);Internal_state (egfr_Y48_p,[Direction (of_degree 225.)])]
      ];
      egf,3.5,13.8,[],
      [egf_r,[Direction s],[]];
       egfr,3.5,12.,[],
       [egfr_l,[Direction n],[];
	egfr_r,[Direction w],[];
	egfr_Y68,[Direction e;Tag ("Exaa",0);Tag ("Exad",0);Tag("Exac",0)],[Free_site [Direction s];Internal_state (egfr_Y68_p,[Direction se])];
	egfr_Y48,[Direction s],[]
       ];
       shc,3.5,10.2,[],
      [shc_pi,[Direction n],[];
       shc_Y7,[Direction s],[Internal_state (shc_Y7_u,[Direction se]);Free_site [Direction s]]]]
    empty


let short_species =
  add_link_list
    [
      sp_egfr1_r,sp_egfr2_r;
      sp_egf2_r,sp_egfr2_l;
      sp_egf1_r,sp_egfr1_l;
      sp_egfr2_Y48,sp_shc_pi
    ]
    short_species

let _ = dump "flow_species.dot" short_species
let _ = dump "flow_species_sp.dot" ~flags:["species",0]  (snd (add_free sp_egfr2_r short_species))

let short_species =
  add_flow_list
    [sp_egfr2_r,sp_egfr2_Y48;
    sp_egfr2_Y48,sp_shc_pi;
    sp_shc_pi,sp_shc_Y7]
    short_species

let _ = dump "flow_species_annotated.dot" short_species

let
  [
    cons_shc,[cons_shc_Y7,_;cons_shc_pi,_];
    cons_egfr,[cons_egfr_r,_;cons_egfr_Y48,_];
  ],
  lhs_domain
  =
  add_in_graph
    [
      shc,-5.,12.,[],
      [shc_Y7,[Direction w],[Free_site[Direction nw]];
       shc_pi,[Direction e],[]];
      egfr,-3.,12.,[],
      [egfr_r,[Direction e],[Bound_site [Direction se]];
      egfr_Y48,[Direction w],[]]]
    empty

let lhs_domain = add_link_list [cons_egfr_Y48,cons_shc_pi] lhs_domain
let _,_,_,rule =
  build_rule
    lhs_domain
    (fun remanent ->
      ([],[],[]),snd (add_internal_state cons_shc_Y7 shc_Y7_u ~directives:[Direction sw] remanent))
    (fun remanent ->
      ([],[],[]),snd (add_internal_state cons_shc_Y7 shc_Y7_p ~directives:[Direction sw] remanent))
    ~directives:[Direction s]


let _ = dump "flow_cons_rule_s.dot" ~flags:["contact_map",0;"flow",0]  rule

let [_,[l,_;r,_;quatrehuit,_;_];sh,[pi,_;yseven,_]],rsh =
  add_in_graph
    [
      egfr,0.,0.,[],
      [
	egfr_l,[Direction ne],[Free_site []];
	egfr_r,[Direction nw],[Free_site []];
	egfr_Y48,[Direction s],[Internal_state (egfr_Y48_p,[Direction sw])];
	egfr_Y68,[Direction se],[Free_site [Direction s];Internal_state (egfr_Y68_p,[])];
      ];
      shc,0.,-2.,[],
      [
       shc_pi,[Direction n],[];
       shc_Y7,[Direction (of_degree 250.)],
       [Free_site [Direction sw];
	Internal_state (shc_Y7_p,[Direction (of_degree (to_degree nw-.10.))])]]
    ]
    empty

let rsh =
  let remanent =
  add_link_list
    [pi,quatrehuit]
    rsh
  in remanent

let _,gfr =
  add_in_graph
    [
      egfr,0.,0.,[],
      [
	egfr_l,[Direction ne],[Free_site []];
	egfr_r,[Direction nw],[Free_site []];
	egfr_Y48,[Direction s],[Free_site [];Internal_state (egfr_Y48_p,[Direction sw])];
	egfr_Y68,[Direction se],[Free_site [Direction s];Internal_state (egfr_Y68_p,[Direction se])]
      ]]
    empty

let _,sh =
    add_in_graph
    [
      shc,0.,-2.,[],
      [
       shc_pi,[Direction n],[Free_site []];
       shc_Y7,[Direction (of_degree 250.)],
       [Free_site [Direction sw];
	Internal_state (shc_Y7_p,[Direction (of_degree (to_degree nw-.10.))])]]
    ]
    empty

let _,grb =
  add_in_graph
    [
      grb2,0.,-2.,[],
      [
	grb2_a,[Direction n],[Free_site []];
	grb2_b,[Direction s],[Free_site []];
      ]]
    empty

let [_,[l,_;r,_];sh,[pi,_;yseven,_]],gsh =
  add_in_graph
    [
      grb2,0.,-2.,[],
      [
	grb2_a,[Direction n],[];
	grb2_b,[Direction s],[Free_site []];
      ];
      shc,0.,0.,[],
      [
       shc_pi,[Direction n],[Free_site [Direction n]];
       shc_Y7,[Direction s],
       [	Internal_state (shc_Y7_p,[Direction sw])]]

    ]
    empty

let disj a b = let _,_,g = disjoint_union a b in g
let gsh =
  let remanent =
    add_link_list
      [yseven,l]
      gsh
  in remanent

let graph =
  disj
    (disj
       (translate_graph {abscisse=4.;ordinate=2.} gfr )
       (translate_graph {abscisse=1.5;ordinate=3.} gsh))
    (disj
       (translate_graph {abscisse=4.5;ordinate=0.} rsh)
       (translate_graph {abscisse=6.;ordinate=3.} grb))

let _ = dump "rsh.dot" graph




let graph =
  disj
    (disj
       (translate_graph {abscisse=3.;ordinate=0.} rsh )
       (translate_graph {abscisse=1.5;ordinate=3.} gsh))
    (disj
       (translate_graph {abscisse=4.5;ordinate=0.} gsh)
       (translate_graph {abscisse=6.;ordinate=3.} rsh))

let _ = dump "rsh_crowed.dot" graph

let [a_egf,[r,_];a_egfr,[l,_;_]],lhs =
  add_in_graph
    [
      egf,-1.,0.8,[],
      [egf_r,[Direction (of_degree 160.)],[]];
      egfr,1.,-0.8,[],
      [
	egfr_l,[Direction (of_degree (-30.))],[];
	egfr_r,[Direction e],[Free_site []]
      ]]
    empty

let _,lhs = add_binding_type l egf_r lhs
let _,lhs = add_binding_type r egfr_l lhs

let [a_egfr,[l,_;r,_]],rhs =
  add_in_graph
    [
      egfr,0.,0.,[],
      [
	egfr_l,[Direction (of_degree (-30.))],[];
	egfr_r,[Direction ne],[]
      ]]
    empty

let _,rhs = add_binding_type r egfr_r rhs
let _,rhs = add_binding_type l egf_r  rhs

 let _ = build_rule ~file:"static_analysis.ladot" ~hgap:(Some 1.5) empty (fun _ -> ([],[],[]),lhs) (fun _ -> ([],[],[]),rhs)
*)
