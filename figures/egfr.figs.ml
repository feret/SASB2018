
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

let _ = dump "species_cm.ladot"   species_cm

    (* graph of sites *)

let col i = (float_of_int i)*.1.4
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

let _ = dump "egfr_graph_site.ladot" graph_site

    (*
  egfr_n	 [_draw_="c 7 -#000000 e 404.6 234 28.7 18 ",
                 _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 404.6 230.3 0 28 6 -egfr_n ",
                 height=0.5,
                 pos="404.6,234",
                 width=0.79437];
        egf_l -> egfr_n	 [_draw_="c 7 -#000000 B 7 270.05 445.97 298.96 440.14 344.47 426.49 369.6 396 401.2 357.67 406.1 297.36 405.94 262.15 ",
                          _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 409.43 262.01 405.75 252.08 402.44 262.15 ",
                          pos="e,405.75,252.08 270.05,445.97 298.96,440.14 344.47,426.49 369.6,396 401.2,357.67 406.1,297.36 405.94,262.15"];
        egfr_a	 [_draw_="c 7 -#000000 e 460.6 162 27.9 18 ",
                 _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 460.6 158.3 0 27 6 -egfr_a ",
                 height=0.5,
                 pos="460.6,162",
                 width=0.77632];
        egf_l -> egfr_a	 [_draw_="c 7 -#000000 B 10 270.09 446.2 302.59 440.37 357.87 426.51 394.6 396 451.6 348.66 459.27 323.53 478.6 252 484.26 231.07 478.82 206.97 \
                                  472.48 188.98 ",
                          _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 475.67 187.5 468.83 179.41 469.13 190 ",
                          pos="e,468.83,179.41 270.09,446.2 302.59,440.37 357.87,426.51 394.6,396 451.6,348.66 459.27,323.53 478.6,252 484.26,231.07 478.82,206.97 \
                               472.48,188.98"];
        egfr_b	 [_draw_="c 7 -#000000 e 205.6 162 28.7 18 ",
                 _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 205.6 158.3 0 28 6 -egfr_b ",
                 height=0.5,
                 pos="205.6,162",
                 width=0.79437];
        egf_l -> egfr_b	 [_draw_="c 7 -#000000 B 10 217.88 444.09 193.92 437.07 159.57 422.77 143.6 396 102.62 327.29 110.46 288.81 143.6 216 150.33 201.22 163.32 \
                                  188.92 175.68 179.8 ",
                          _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 177.82 182.58 184.05 174.01 173.83 176.82 ",
                          pos="e,184.05,174.01 217.88,444.09 193.92,437.07 159.57,422.77 143.6,396 102.62,327.29 110.46,288.81 143.6,216 150.33,201.22 163.32,188.92 \
                               175.68,179.8"];
        egfr_r	 [_draw_="c 7 -#000000 e 300.6 306 27.1 18 ",
                 _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 300.6 302.3 0 26 6 -egfr_r ",
                 height=0.5,
                 pos="300.6,306",
                 width=0.75827];
        egfr_r -> egfr_l	 [_draw_="c 7 -#000000 B 4 300.48 287.76 300.31 263.2 300 219.25 299.8 190.35 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 303.3 190.07 299.73 180.09 296.3 190.11 ",
                           pos="e,299.73,180.09 300.48,287.76 300.31,263.2 300,219.25 299.8,190.35"];
        egfr_r -> egfr_c	 [_draw_="c 7 -#000000 B 4 292.74 323.34 286.03 333.11 276.43 345.41 267.41 355.86 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 264.71 353.63 260.69 363.43 269.95 358.28 ",
                           pos="e,260.69,363.43 292.74,323.34 286.03,333.11 276.43,345.41 267.41,355.86"];
        egfr_r -> egfr_n	 [_draw_="c 7 -#000000 B 4 316.56 291.08 331.85 279.49 355.01 263.39 373.83 251.25 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 375.83 254.13 382.39 245.81 372.07 248.22 ",
                           pos="e,382.39,245.81 316.56,291.08 331.85,279.49 355.01,263.39 373.83,251.25"];
        egfr_r -> egfr_a	 [_draw_="c 7 -#000000 B 7 310.04 289.1 321.5 269.68 342.34 237.7 366.6 216 384.84 199.68 408.81 186.01 427.97 176.51 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 429.73 179.54 437.22 172.05 426.69 173.24 ",
                           pos="e,437.22,172.05 310.04,289.1 321.5,269.68 342.34,237.7 366.6,216 384.84,199.68 408.81,186.01 427.97,176.51"];
        egfr_r -> egfr_b	 [_draw_="c 7 -#000000 B 4 289.7 289.48 273.19 264.44 241.68 216.69 222.27 187.27 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 225.09 185.19 216.67 178.77 219.25 189.04 ",
                           pos="e,216.67,178.77 289.7,289.48 273.19,264.44 241.68,216.69 222.27,187.27"];
        egfr_c -> egfr_l	 [_draw_="c 7 -#000000 B 7 247.57 360.02 251.63 341.81 258.25 312.87 264.6 288 273.29 253.97 284.26 215.06 291.58 189.59 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 294.97 190.46 294.38 179.88 288.25 188.52 ",
                           pos="e,294.38,179.88 247.57,360.02 251.63,341.81 258.25,312.87 264.6,288 273.29,253.97 284.26,215.06 291.58,189.59"];
        egfr_c -> egfr_r	 [_draw_="c 7 -#000000 B 4 251.52 360.57 258.28 350.75 267.93 338.4 276.97 327.93 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 279.67 330.16 283.71 320.36 274.44 325.51 ",
                           pos="e,283.71,320.36 251.52,360.57 258.28,350.75 267.93,338.4 276.97,327.93"];
        egfr_c -> egfr_c	 [_draw_="c 7 -#000000 B 7 263.92 390.43 276.98 393.68 289.55 389.53 289.55 378 289.55 369.53 282.77 365.05 274 364.55 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 273.51 361.08 263.92 365.57 274.22 368.04 ",
                           pos="e,263.92,365.57 263.92,390.43 276.98,393.68 289.55,389.53 289.55,378 289.55,369.53 282.77,365.05 274,364.55"];
        egfr_c -> egfr_a	 [_draw_="c 7 -#000000 B 7 270.06 371.8 318.2 358.94 418.98 324.3 460.6 252 471.34 233.35 470.52 208.72 467.48 189.93 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 470.88 189.07 465.56 179.91 464 190.39 ",
                           pos="e,465.56,179.91 270.06,371.8 318.2,358.94 418.98,324.3 460.6,252 471.34,233.35 470.52,208.72 467.48,189.93"];
        egfr_c -> egfr_b	 [_draw_="c 7 -#000000 B 7 234.3 361.02 229.07 350.64 222.93 336.92 219.6 324 207.83 278.32 205.46 223.25 205.24 190.51 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 208.74 190.31 205.23 180.31 201.74 190.31 ",
                           pos="e,205.23,180.31 234.3,361.02 229.07,350.64 222.93,336.92 219.6,324 207.83,278.32 205.46,223.25 205.24,190.51"];
        egfr_n -> egfr_l	 [_draw_="c 7 -#000000 B 4 384.85 220.46 368.52 209.26 345.13 193.22 326.99 180.78 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 328.78 177.77 318.56 175 324.82 183.54 ",
                           pos="e,318.56,175 384.85,220.46 368.52,209.26 345.13,193.22 326.99,180.78"];
        egfr_n -> egfr_r	 [_draw_="c 7 -#000000 B 4 388.3 249.18 372.75 260.94 349.3 277.22 330.46 289.34 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 328.49 286.44 321.91 294.75 332.24 292.36 ",
                           pos="e,321.91,294.75 388.3,249.18 372.75,260.94 349.3,277.22 330.46,289.34"];
        egfr_n -> egfr_n	 [_draw_="c 7 -#000000 B 7 425.69 246.55 438.76 249.57 451.2 245.39 451.2 234 451.2 225.64 444.49 221.16 435.75 220.57 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 435.34 217.09 425.69 221.45 435.96 224.06 ",
                           pos="e,425.69,221.45 425.69,246.55 438.76,249.57 451.2,245.39 451.2,234 451.2,225.64 444.49,221.16 435.75,220.57"];
        egfr_n -> egfr_a	 [_draw_="c 7 -#000000 B 4 417.31 217.66 424.54 208.36 433.74 196.54 441.79 186.19 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 444.57 188.32 447.95 178.27 439.04 184.02 ",
                           pos="e,447.95,178.27 417.31,217.66 424.54,208.36 433.74,196.54 441.79,186.19"];
        egfr_n -> egfr_b	 [_draw_="c 7 -#000000 B 4 379.8 225.03 344.55 212.27 279.82 188.85 239.97 174.43 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 241 171.08 230.4 170.97 238.62 177.67 ",
                           pos="e,230.4,170.97 379.8,225.03 344.55,212.27 279.82,188.85 239.97,174.43"];
        shc_y	 [_draw_="c 7 -#000000 e 345.6 90 27 18 ",
                _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 345.6 86.3 0 25 5 -shc_y ",
                height=0.5,
                pos="345.6,90",
                width=0.75];
        egfr_a -> shc_y	 [_draw_="c 7 -#000000 B 4 440.31 149.29 421.88 137.76 394.53 120.63 373.95 107.75 ",
                          _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 375.64 104.68 365.31 102.34 371.93 110.61 ",
                          pos="e,365.31,102.34 440.31,149.29 421.88,137.76 394.53,120.63 373.95,107.75"];
        g_b	 [_draw_="c 7 -#000000 e 289.6 18 27 18 ",
              _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 289.6 14.3 0 16 3 -g_b ",
              height=0.5,
              pos="289.6,18",
              width=0.75];
        egfr_b -> g_b	 [_draw_="c 7 -#000000 B 4 215.57 144.92 230.16 119.91 257.44 73.14 274.5 43.89 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 277.63 45.46 279.65 35.06 271.59 41.94 ",
                        pos="e,279.65,35.062 215.57,144.92 230.16,119.91 257.44,73.14 274.5,43.892"];
        shc_pi	 [_draw_="c 7 -#000000 e 81.6 450 28.7 18 ",
                 _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 81.6 446.3 0 28 6 -shc_pi ",
                 height=0.5,
                 pos="81.602,450",
                 width=0.79437];
        shc_pi -> egfr_l	 [_draw_="c 7 -#000000 B 7 91.87 433.06 116.2 393.42 180.22 292.21 244.6 216 254.1 204.76 265.59 193.21 275.6 183.69 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 278 186.24 282.91 176.85 273.22 181.13 ",
                           pos="e,282.91,176.85 91.866,433.06 116.2,393.42 180.22,292.21 244.6,216 254.1,204.76 265.59,193.21 275.6,183.69"];
        shc_pi -> egfr_r	 [_draw_="c 7 -#000000 B 7 99.82 435.97 123.8 417.73 167.5 385.22 206.6 360 227.44 346.56 251.73 332.66 270.39 322.32 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 272.25 325.29 279.33 317.41 268.88 319.16 ",
                           pos="e,279.33,317.41 99.825,435.97 123.8,417.73 167.5,385.22 206.6,360 227.44,346.56 251.73,332.66 270.39,322.32"];
        shc_pi -> egfr_c	 [_draw_="c 7 -#000000 B 4 105.16 439.53 133.15 427.09 180.01 406.27 211.35 392.33 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 212.83 395.51 220.54 388.25 209.98 389.11 ",
                           pos="e,220.54,388.25 105.16,439.53 133.15,427.09 180.01,406.27 211.35,392.33"];
        shc_pi -> egfr_n	 [_draw_="c 7 -#000000 B 7 109.41 445.68 160.79 437.27 268.14 417.64 298.6 396 346.94 361.66 379 297.72 394.25 261.28 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 397.59 262.36 398.11 251.78 391.11 259.73 ",
                           pos="e,398.11,251.78 109.41,445.68 160.79,437.27 268.14,417.64 298.6,396 346.94,361.66 379,297.72 394.25,261.28"];
        shc_pi -> egfr_b	 [_draw_="c 7 -#000000 B 10 62.4 436.35 50.48 426.63 36.22 412.42 29.6 396 -0.31 321.8 -17.95 280.33 29.6 216 46.07 193.72 120.97 176.85 167.59 \
                                   168.28 ",
                           _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 168.42 171.69 177.65 166.48 167.19 164.8 ",
                           pos="e,177.65,166.48 62.4,436.35 50.484,426.63 36.222,412.42 29.602,396 -0.31371,321.8 -17.951,280.33 29.602,216 46.073,193.72 120.97,\
                                176.85 167.59,168.28"];
        shc_y -> g_b	 [_draw_="c 7 -#000000 B 4 332.9 73.66 325.66 64.36 316.47 52.54 308.41 42.19 ",
                       _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 311.16 40.02 302.26 34.27 305.64 44.32 ",
                       pos="e,302.26,34.273 332.9,73.662 325.66,64.364 316.47,52.543 308.41,42.187"];
        g_a	 [_draw_="c 7 -#000000 e 474.6 450 27 18 ",
              _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 474.6 446.3 0 16 3 -g_a ",
              height=0.5,
              pos="474.6,450",
              width=0.75];
        g_a -> egfr_l	 [_draw_="c 7 -#000000 B 7 479.89 432.19 491.43 389.32 513.79 279.22 460.6 216 444.38 196.72 378.06 179.12 335.77 169.54 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 336.35 166.09 325.83 167.34 334.84 172.92 ",
                        pos="e,325.83,167.34 479.89,432.19 491.43,389.32 513.79,279.22 460.6,216 444.38,196.72 378.06,179.12 335.77,169.54"];
        g_a -> egfr_r	 [_draw_="c 7 -#000000 B 4 457.6 435.93 426.81 410.44 361.66 356.53 325.72 326.79 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 327.61 323.81 317.67 320.13 323.14 329.2 ",
                        pos="e,317.67,320.13 457.6,435.93 426.81,410.44 361.66,356.53 325.72,326.79"];
        g_a -> egfr_c	 [_draw_="c 7 -#000000 B 4 449.88 442.29 408.68 429.45 325.83 403.63 278.63 388.92 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 279.43 385.5 268.85 385.87 277.35 392.19 ",
                        pos="e,268.85,385.87 449.88,442.29 408.68,429.45 325.83,403.63 278.63,388.92"];
        g_a -> egfr_n	 [_draw_="c 7 -#000000 B 7 474.09 431.7 472.64 400.82 467.06 336.93 445.6 288 440.82 277.11 433.43 266.4 426.23 257.43 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 428.86 255.12 419.75 249.72 423.51 259.63 ",
                        pos="e,419.75,249.72 474.09,431.7 472.64,400.82 467.06,336.93 445.6,288 440.82,277.11 433.43,266.4 426.23,257.43"];
        g_a -> egfr_a	 [_draw_="c 7 -#000000 B 10 490.71 435.33 501.58 424.95 515.85 410.38 526.6 396 575.86 330.13 612.97 285.89 569.6 216 553.94 190.77 522.6 \
                                176.96 497.52 169.64 ",
                        _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 498.14 166.18 487.57 166.97 496.33 172.94 ",
                        pos="e,487.57,166.97 490.71,435.33 501.58,424.95 515.85,410.38 526.6,396 575.86,330.13 612.97,285.89 569.6,216 553.94,190.77 522.6,176.96 \
                             497.52,169.64"];
        sos_a	 [_draw_="c 7 -#000000 e 474.6 522 27 18 ",
                _ldraw_="F 14 11 -Times-Roman c 7 -#000000 T 474.6 518.3 0 24 5 -sos_a ",
                height=0.5,
                pos="474.6,522",
                width=0.75];
        sos_a -> g_a	 [_draw_="c 7 -#000000 B 4 474.6 503.83 474.6 496.13 474.6 486.97 474.6 478.42 ",
                       _hdraw_="S 5 -solid c 7 -#000000 C 7 -#000000 P 3 478.1 478.41 474.6 468.41 471.1 478.41 ",
                       pos="e,474.6,468.41 474.6,503.83 474.6,496.13 474.6,486.97 474.6,478.42"];
      }
    *)

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
