open Config
open Geometry


let show_binding_type = false
let space_between_proteins = 0.4
let config =
  {
    config
    with
      site_width = 0.25*.config.site_width;
      site_height = 0.25 *. config.site_height;
      free_width = 0.9 *. config.free_width ;
      free_height = 0.9 *. config.free_height ;
      bound_height = 0.5 *. config.bound_height ;
      rule_length = 0.5 *. config.rule_length ;
      rule_margin = 0.05 *. config.rule_margin ;
      show_agent_names = true ;
      show_site_names = false ;
      show_state_names = false ;
      weak_flow_color = "cyan";
      weak_flow_style = "dashed";
      flow_width = 1;
      txt_font = 6;
      site_colors = ["white"];(*"brown";"yellow";"pink"];*)
      agent_colors = ["white"];
  }

let build_rule = build_rule ~hgap:(Some 0.8)

let rotate_pos x y = of_degree ((to_degree y) +. x)
let rotate_neg x y = rotate_pos (-.x) y

let
  [
    a,
    [
      sa,[];
      sa',[];
      sa'',[]];
    b,
    [sb,[];
     sb',[];
     sb'',[];
     sb''',[]];
    c,
    [sc,[];
     sc',[]]],
  signature
  =
  add_in_signature
    [
      "$\text{\agent{A}{}}$",
      [Shape "ellipse";Width (0.2*.config.agent_width);Height (0.5*.config.agent_width)],
      [
        "$\text{\site{a1}{}{}}$",[Direction (rotate_neg 5. ne)],[];
        "$\text{\site{a2}{}{}}$",[Direction (rotate_pos 5. e)],[];
        "$\text{\site{a3}{}{}}$",[Direction (rotate_neg 10. se)],[];
      ];
      "$\text{\agent{B}{}}$",
      [Shape "rectangle";Width (0.2*.config.agent_width);Height (0.5*.config.agent_width)],
      [
        "$\text{\site{b1}{}{}}$",[Direction (rotate_pos 15. nw)],[];
        "$\text{\site{b2}{}{}}$",[Direction (rotate_neg 17. w)],[];
        "$\text{\site{b3}{}{}}$",[Direction (rotate_neg 17. sw)],[];
        "$\text{\site{b4}{}{}}$",[Direction n],[]
      ];
      "$\text{\agent{C}{}}$",
      [Shape "circle";Width (0.3*.config.agent_width);Height (0.3*.config.agent_width)],
      [
        "$\text{\site{x}{}{}}$",[Direction s],[];
        "$\text{\site{y}{}{}}$",[Direction (rotate_neg 10. w)],[]];
    ]
    (snd (init config))

type agent = A of int | B | C
type site_identifier = int
type site = agent * site_identifier
type link_identifier = int

let is_a s =
  match s with A _ -> true | _ -> false
let is_c s =
  match s with C _ -> true | _ -> false

module AgentSet =
  Set.Make
    (struct type t = agent let compare = compare end)
module SiteSet =
  Set.Make
    (struct type t = site let compare = compare end)
module SiteMap =
  Map.Make
    (struct type t = site let compare = compare end)
module LinkSet =
  Set.Make
    (struct type t = link_identifier let compare = compare end)

let label ?kind:(kind=1) i =
  let l =
    match kind,i with
    | 1,1 -> "5.2"
    | 1,2 ->"-12.5"
    | 1,4 -> "-13.4"
    | 1,3 -> "4.9"
    | 1,_ -> "5.3"
    | 2,1 -> "4.8"
    | 2,2 ->"-13.2"
    | 2,4 -> "5.2"
    | 2,_ -> "5.3"
    | _ -> "5.3"
  in
  (* \\hspace*{"^l^"cm}{}_ *)
  Some ("$\\hspace*{"^l^"cm}{}"
        ^(string_of_int i)^"\\hspace*{-"^l^"cm}{}$")

let nolabel = None
let links ?kind:(kind=1) () =
  [
    1,label ~kind 1,label ~kind 1,(A 1,3),(B,3);
    2,label ~kind 2,label ~kind 2,(A 1,2),(B,2);
    3,label ~kind 3,label ~kind 3,(A 1,2),(B,1);
    4,label ~kind 4,label ~kind 4,(A 1,1),(B,1);
    5,label ~kind 5,label ~kind 5,(A 1,1),(C,2);
    6,nolabel,nolabel,(B,4),(C,1);
    11,label ~kind 6,label ~kind 6,(A 1,3),(B,3);
    21,label ~kind 7,label ~kind 7,(A 1,2),(B,2);
    31,label ~kind 8,label ~kind 8,(A 1,2),(B,1);
    41,label ~kind 9,label ~kind 9,(A 1,1),(B,1);
    51,label ~kind 10,label ~kind 10,(A 1,1),(C,2);
    22,label ~kind 11,label ~kind 11,(A 2,2),(B,2);
    32,label ~kind 12,label ~kind 12,(A 2,2),(B,1);
    42,label ~kind 13,label ~kind 13,(A 2,1),(B,1);
    52,label ~kind 14,label ~kind 14,(A 2,1),(C,2);
    33,label ~kind 15,label ~kind 15,(A 3,2),(B,1);
    43,label ~kind 16,label ~kind 16,(A 3,1),(B,1);
    53,label ~kind 17,label ~kind 17,(A 3,1),(C,2);
    44,label ~kind 18,label ~kind 18,(A 4,1),(B,1);
    54,label ~kind 19,label ~kind 19,(A 4,1),(C,2);

  ]

let agent_of_site site = fst site

let get_link ?kind:(kind=1) f l =
  let rec aux l links =
    match links with
    | [] -> raise Not_found
    | (a,b,c,d,e)::_ when a=l -> f (a,b,c,d,e)
    | _::tail -> aux l tail
  in aux l (links ~kind ())

let labels_of_link ?kind:(kind=1) l = get_link ~kind (fun (_,b,c,_,_) -> b,c) l
let translate_link l = get_link (fun (_,_,_,d,e) -> d,e) l

let is_involved i l =
  let a,b = translate_link l in
  agent_of_site  a=B || agent_of_site b=B

let blinksid ?kind:(kind=1) () =
  List.rev_map (fun (a,_,_,_,_) -> a) (links ~kind ())

let convert_list f title l =
  if l=[] then "" else "_"^title^(List.fold_left (fun s a -> s^"_"^(f a)) "" l)

let string_of_agent ag =
  match ag with
  | A i -> "a"^(string_of_int i)
  | B -> "b"
  | C -> "c"
let string_of_site s =
  (string_of_agent (fst s))^(string_of_int (snd s))

let compute_name ?with_c:(with_c=false) ~agents ~free_sites ~with_id ~bound_sites ~links ~dotted_links =
  (if with_c then "_with_c" else "")^(convert_list string_of_site  "free_sites" free_sites)^(convert_list string_of_site  "bound_sites" bound_sites)^(convert_list string_of_int "links" links)^(convert_list string_of_int "dotted_links" dotted_links)^".ladot"

let direction n_a site =
  match site,n_a with

  | (A _,1),_ -> [Direction (rotate_neg 10. n)]
  | (A _,3),1 -> [Direction e]
  | (A 2,2),_ -> [Direction (rotate_pos 5. e)]
  | (A _,2),1 -> [Direction e]
  | (A _,3),_ -> [Direction se]
  | (A _,2),_ -> [Direction se]
  | (B,2),1 -> [Direction (rotate_neg 10. sw)]
  | (B,3),1 -> [Direction sw]
  | (B,3),_ -> [Direction nw]
  | (B,1),1 -> [Direction (rotate_pos 15. nw)]
  | (B,1),_ -> [Direction (rotate_neg 22. sw)]
  | (B,2),_ -> [Direction sw]
  | (B,4),_ -> [Direction ne]
  | (C,1),_ -> [Direction se]
  | (C,2),_ -> [Direction (rotate_neg 20. n)]
  (*  | (C,2),x when x>1 -> [Direction (rotate_neg 10. n)]*)
  | _ -> []

let inc map s =
  let old =
    try
      SiteMap.find s map
    with
      Not_found -> 0
  in
  SiteMap.add s (succ old) map

let inc2 ?kind:(kind=1) map link =
  let s,s' = translate_link link in
  inc (inc map s) s'

let site_graph ~kind ~free_sites ~bound_sites ~links ~dotted_links =
  dotted_links = []
  &&
  SiteMap.for_all
    (fun _ i -> i<=1)
    (List.fold_left
       inc
       (List.fold_left inc
          (List.fold_left (inc2 ~kind)
              SiteMap.empty links
          )
          bound_sites)
       free_sites)

let add_agent ag set = AgentSet.add ag set

let make_gen ~name ?with_c:(with_c=false) ?with_id:(with_id=false)
    ?ommitted_agents ?kind:(kind=1) ~agents ~free_sites ?bound_sites:(bound_sites=[]) ~links ?dotted_links:(dotted_links=[]) () =
  let ommitted_agents =
    match ommitted_agents with
    | None -> []
    | Some list -> list
  in
  let sites = SiteSet.empty in
  let link_sites = SiteSet.empty in
  let fic_sites = SiteSet.empty in
  let map = SiteMap.empty in
  let add_inv a b = SiteSet.add b a in
  let add_inv2 a b =
    let (b1,b2) = translate_link b in
    SiteSet.add b1 (SiteSet.add b2 a)
  in
  let sites = List.fold_left add_inv sites free_sites in
  let sites = List.fold_left add_inv sites bound_sites in
  let link_sites = List.fold_left add_inv2 link_sites links in
  let fic_sites = List.fold_left add_inv2 fic_sites dotted_links in
  let sites = SiteSet.union sites link_sites in
  let agents =
    List.fold_left
      (fun set agent  -> AgentSet.add agent set)
      AgentSet.empty agents
  in
  let agents =
    SiteSet.fold
      (fun site agents ->
         AgentSet.add (agent_of_site site) agents)
      sites agents
  in
  let with_c =
    with_c || AgentSet.mem C agents
  in
  let links = if with_c then 6::links else links in
  let coef =
    if dotted_links = [] then 1. else 2.
  in
  let ommitted_agents =
      List.fold_left
        (fun set agent -> AgentSet.add agent set)
        AgentSet.empty ommitted_agents
  in
  let showed_agents = AgentSet.diff agents ommitted_agents in
  let agent_list =
    AgentSet.fold (fun elt list -> elt::list) agents [] in
  let n_a =
    List.fold_left
      (fun count agent ->
         match agent with
           A i -> max i count
         | B | C -> count)
      0 agent_list
  in
  let showed_agents =
    AgentSet.fold (fun elt list -> elt::list) showed_agents []
  in
  let add_site_opt ~directives agent site g =
    match agent with
    | None -> None, g
    | Some agent ->
      let s,g = add_site ~directives agent site g in
      Some s,g
  in
  let l,g =
    List.fold_left
      (fun (l,g) agent ->
         match agent with
         | C ->
           if n_a<=1
           then
             let [ag_c,_],g =
             add_in_graph [c,0.5*.coef,1.2,[],[]] g
           in
           ag_c::l,g
           else
           let [ag_c,_],g =
           add_in_graph [c,0.5*.coef,0.6,[],[]] g
         in
         ag_c::l,g

         | B ->
           if n_a <= 1 then
             let [ag_b,_],g =
             add_in_graph
               [b,0.5*.coef,0.,[],[]] g
           in
           ag_b::l,g
           else
           let [ag_b,_],g =
           add_in_graph
             [b,0.5*.coef,-0.6,[],[]] g
         in
         ag_b::l,g

         | A 1 ->
         let [ag_a,_],g =
           add_in_graph
             (if n_a<=1 then
                [a,-0.2*.coef,0.15,[],[]]
              else if n_a=2 then
                [a,-0.3*.coef,-.0.6*.coef,[],[]]
              else if n_a=3 then
                [a,-0.3*.coef,-.1.2*.coef,[],[]]
              else
                [a,-0.3*.coef,-.1.8*.coef,[],[]])
             g
         in ag_a::l,g
         | A 2 ->
         let [ag_a,_],g =
           add_in_graph
             (if n_a <=2 then
                [a,-0.5*.coef,0.6*.coef,[],[]]
              else if n_a=3 then
                [a,-0.3*.coef,0.*.coef,[],[]]
              else
                [a,-0.3*.coef,-.0.6*.coef,[],[]])
             g
         in ag_a::l,g
         | A 3 ->
         let [ag_a,_],g =
           add_in_graph
             (if  n_a=3 then
                [a,-0.5*.coef,1.2*.coef,[],[]]
              else
                [a,-0.3*.coef,0.6*.coef,[],[]])
             g
         in ag_a::l,g
         | A 4 ->
         let [ag_a,_],g =
           add_in_graph
             [a,-0.2*.coef,1.8*.coef,[],[]]
             g
         in ag_a::l,g)
      ([],signature) showed_agents
  in
  let l = List.rev l in
  let node_of_agent agent =
    let rec aux agent l l'=
      match l,l' with
      | [],[] -> None
      | h::t,h'::t' when h=agent -> Some h'
      | _::t,_::t' -> aux agent t t'
    in
    aux agent showed_agents l
  in
  let translate_site ?directives:(directives=[]) site map g =
    try
      let fresh = SiteMap.find site map in
      Some fresh,map,g
    with
      Not_found ->
      begin
        let fresh_site,g  =
          match
            site
          with
          | A i,1 ->
            add_site_opt ~directives (node_of_agent (A i)) sa g
          | A i,2 ->
            add_site_opt ~directives (node_of_agent (A i)) sa' g
          | A i,3 ->
            add_site_opt ~directives (node_of_agent (A i)) sa'' g
          | B,1 ->
            add_site_opt ~directives (node_of_agent B) sb g
          | B,2 ->
            add_site_opt ~directives (node_of_agent B) sb' g
          | B,3 ->
            add_site_opt ~directives (node_of_agent B) sb'' g
          | B,4 ->
            add_site_opt ~directives (node_of_agent B) sb''' g
          | C,1 ->
            add_site_opt ~directives (node_of_agent C) sc g
          | C,2 ->
            add_site_opt ~directives (node_of_agent C) sc' g
        in
        let map =
          match fresh_site with
          | None -> map
          | Some fresh_site ->
            SiteMap.add site fresh_site map
        in
        fresh_site, map, g
      end
  in
(*if SiteSet.is_empty (SiteSet.inter fic_sites link_sites)
  then*)
    let fic_sites = SiteSet.diff fic_sites sites in
    let map,g =
      SiteSet.fold
        (fun site (map,g) ->
           let _,map,g = translate_site  site map g in
           map,g)
        sites (map,g)
    in
    let map,g =
      SiteSet.fold
        (fun site (map,g) ->
           let _,map,g = translate_site ~directives:[Color "cyan"]  site map g
          in
          map,g)
        fic_sites (map,g)
    in
    let map,g =
      List.fold_left
      (fun (map,g) site ->
        let site',map,g = translate_site site map g in
        match site' with
        | None -> map,g
        | Some site' ->
        let _,g = add_free_list [site',direction n_a site] g in
        map,g
      )
      (map,g) free_sites
    in
    let map,g =
      List.fold_left
        (fun (map,g) site ->
           let site',map,g = translate_site site map g in
           match site' with
           | None -> map,g
           | Some site' ->
           let _,g = add_bound ~directives:(direction n_a site) site' g in
           map,g
        )
        (map,g) bound_sites
    in
    let map,g =
      List.fold_left
        (fun (map,g) link ->
           let site1_,site2_ = translate_link link in
           let site1, map, g = translate_site site1_ map g in
           let site2, map, g = translate_site site2_ map g in
           match site1,site2 with
           | None,None -> map,g
           | Some site',None ->
             let _,g =
               add_free_list
                 [site',direction n_a site1_] g
             in
             map,g
           | None, Some site' ->
             let _,g =
               add_free_list
                 [site', direction n_a site2_]  g
             in
           map,g
           | Some site1, Some site2 ->
             let g = add_link_list [site1, site2] g in
             map,g)
        (map,g) links
    in
    let map,g =
      List.fold_left
        (fun (map,g) link ->
           let site1,site2 = translate_link link in
           let _,label = labels_of_link ~kind link in
           let site1, map, g = translate_site site1 map g in
           let site2, map, g = translate_site site2 map g in
           match site1,site2 with
           | None,_ | _,None -> map,g
           | Some site1, Some site2 ->
             let g =
               match with_id, label with
               | true, Some s ->
               add_site_relation_list
                 ~directives:[Comment s;Color "cyan";Shape "none"]
                 [site1, site2] g
               | _ ->
                 add_site_relation_list
                   ~directives:[Color "cyan";Shape "none"]
                   [site1, site2] g
             in
             map,g)
        (map,g) dotted_links
    in
    name,
    node_of_agent,
    g

let make_pattern
    ?kind:(kind=1)
    ?name ?with_c:(with_c=false) ?with_id:(with_id=false)
    ?ommitted_agents ?agents:(agents=[]) ?free_sites:(free_sites=[]) ?bound_sites:(bound_sites=[]) ?links:(links=[]) ?dotted_links:(dotted_links=[]) () =
  let add_inv a b = SiteSet.add b a in
  let add_inv2 a b =
    let (b1,b2) = translate_link b in
    SiteSet.add b1 (SiteSet.add b2 a)
  in
  let free_sites_set = List.fold_left add_inv SiteSet.empty free_sites in
  let bound_sites_set = List.fold_left add_inv SiteSet.empty bound_sites in
  let link_sites = List.fold_left add_inv2 SiteSet.empty links in
  let free_sites_set =
    SiteSet.diff
      (SiteSet.diff free_sites_set bound_sites_set)
      link_sites
  in
  let free_sites =
    List.rev
      (SiteSet.fold (fun a l -> a::l) free_sites_set [])
  in
  let bound_sites_set =
    SiteSet.diff bound_sites_set link_sites
  in
  let bound_sites =
    List.rev
      (SiteSet.fold (fun a l -> a::l) bound_sites_set [])
  in
  let name =
    match name with
    | Some name -> name
    | None ->
      "pattern"^(compute_name
                   ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links ~dotted_links)
  in
  make_gen
    ~kind
    ~name ~with_c ~with_id
    ?ommitted_agents
    ~agents
    ~free_sites
    ~bound_sites ~links ~dotted_links ()

let make_species
    ?name ?ommitted_agents ?agents:(agents=[]) ?links:(links=[]) () =
  let name =
    match name with
    | Some name -> name
    | None ->
      let dotted_links = [] in
      let with_c = false in
      let with_id = false in
      let free_sites = [] in
      let bound_sites = [] in
      "species"^(compute_name
                   ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links
                   ~dotted_links)
  in
  let agent_set =
    List.fold_left
      (fun set ag -> AgentSet.add ag set)
      AgentSet.empty
      agents
  in
  let agent_set =
    List.fold_left
      (fun set link ->
         let (ag1,_),(ag2,_) = translate_link link in
         AgentSet.add ag1 (AgentSet.add ag2 set))
      agent_set
      links
  in
  let with_c = AgentSet.mem C agent_set in
  let link_set =
    List.fold_left
      (fun set link -> LinkSet.add link set)
      LinkSet.empty
      links
  in
  let link_set =
    if AgentSet.mem C agent_set
    then LinkSet.add 6 link_set
    else link_set
  in
  let links =
    LinkSet.fold (fun link list -> link::list) link_set []
  in
  let potential_sites =
    AgentSet.fold
      (fun ag set ->
         List.fold_left
           (fun set site ->
              SiteSet.add (ag,site) set)
           set
           (
             match ag
             with
             | A i -> [1;2;3]
             | B -> [1;2;3;4]
             | C -> [1;2]))
      agent_set
      SiteSet.empty
  in
  let agents =
    AgentSet.fold
      (fun ag list -> ag::list)
      agent_set
      []
  in
  let sites =
    List.fold_left
      (fun set link ->
         let s1,s2 = translate_link link in
         SiteSet.add s1 (SiteSet.add s2 set))
      SiteSet.empty
      links
  in
  let free_sites =
    SiteSet.fold
      (fun site list -> site::list)
      (SiteSet.diff potential_sites sites)
      []
  in
  let kind=1
  in
  make_gen ?ommitted_agents
      ~kind
      ~name
      ~with_c
      ~agents
      ~free_sites
      ~links ()

let make_reaction agent ?name ?with_c:(with_c=false) ?agents:(agents=[]) ?links:(links=[]) () =
  let name =
    match name with
    | Some name -> name
    | None ->
      let dotted_links = [] in
      let with_c = false in
      let with_id = false in
      let free_sites = [] in
      let bound_sites = [] in
      "reaction_deg_"^(string_of_agent agent)^(compute_name
                 ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links
                 ~dotted_links)
  in
  let _,agent_of_precondition,precondition =
    make_species
      ~agents ~links ()
  in
  let links =
    List.filter
      (fun i ->
         let (ag,_),(ag',_) = translate_link i in
         ag <> agent && ag' <> agent)
      links
  in
  let ommitted_agents = [agent] in
  let _,_,postcondition =
    make_species ~ommitted_agents
      ~agents ~links ()
  in
  let sigmal,_,_,g =
    build_rule
      signature
      (fun _ -> ([],[],[]),precondition)
      (fun _ -> ([],[],[]),postcondition)
  in
  let get_agent ag =
    match
      agent_of_precondition ag
    with
    | None -> None
    | Some ag ->
      Some (lift_agent sigmal ag)
  in
  name, get_agent, g


let make_rule
    agent
    ?name ?with_c:(with_c=false)
    ?agents:(agents=[]) ?free_sites:(free_sites=[]) ?bound_sites:(bound_sites=[]) ?links:(links=[]) () =
  let name =
      match name with
      | Some name -> name
      | None ->
        let dotted_links = [] in
        let with_id = false in
        "rule_deg_"^(string_of_agent agent)^(compute_name
                   ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links
                   ~dotted_links)
    in
    let _,agent_of_precondition,precondition =
      make_pattern
        ~with_c
        ~agents ~links ~free_sites ~bound_sites ()
    in
    let free_sites =
      List.fold_left
        (fun free_sites i ->
           let (ag,site),(ag',site') = translate_link i in
           match ag=agent,ag'=agent with
           | true,true -> free_sites
           | false,false -> free_sites
           | true,_ -> (ag',site')::free_sites
           | _,true -> (ag,site)::free_sites)
        free_sites links
    in
    let links =
      List.filter
        (fun i ->
           let (ag,_),(ag',_) = translate_link i in
           ag <> agent && ag' <> agent)
        links
    in
    let ommitted_agents = [agent] in
    let kind = 1 in
    let _,_,postcondition =
      make_pattern
        ~kind
        ~ommitted_agents
        ~with_c
        ~agents ~links ~free_sites ~bound_sites ()
    in
    let sigmal,_,_,g =
      build_rule
        signature
        (fun _ -> ([],[],[]),precondition)
        (fun _ -> ([],[],[]),postcondition)
    in
    let get_agent ag =
      match
        agent_of_precondition ag
      with
      | None -> None
      | Some ag ->
        Some (lift_agent sigmal ag)
    in
    name, get_agent, g

let make_square_reaction
    agent ?name ?with_c:(with_c=false) ?agents:(agents=[])
    ?links:(links=[]) ()
  =
  let name =
    match name with
    | Some name -> name
    | None ->
      let dotted_links = [] in
      let with_c = false in
      let with_id = false in
      let free_sites = [] in
      let bound_sites = [] in
      "apply_reaction_deg_"^(string_of_agent agent)^(compute_name
                 ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links
                 ~dotted_links)
  in

  let _,get_agent_reaction,reaction =
    make_reaction agent ~with_c ~agents ~links ()
  in
  let agents = [A 1] in
  let _,get_agent_rule,rule =
    make_rule agent ~agents ()
  in
  let rule = move_remanent_bellow 0.8 rule reaction in
  let rule = translate_graph {abscisse=0.85;ordinate=0.} rule in
  let sigmad,sigmau,rule_apply = disjoint_union rule reaction in
  let rule_apply =
    match get_agent_rule (A 1), get_agent_reaction (A 1) with
    | None, _ | _, None -> rule_apply
    | Some agrule, Some agreaction ->
    add_proj
      [lift_agent sigmad agrule,
       lift_agent sigmau agreaction]
      rule_apply
  in
  name, get_agent_reaction, rule_apply

  let make_square_rule
      agent
      ?name ?with_c:(with_c=false)
      ?agents:(agents=[]) ?free_sites:(free_sites=[]) ?bound_sites:(bound_sites=[]) ?links:(links=[]) () =
    let name =
      match name with
      | Some name -> name
      | None ->
        let dotted_links = [] in
        let with_id = false in
        "apply_rule_deg_"^(string_of_agent agent)^(compute_name
                   ~with_c ~with_id ~agents ~free_sites ~bound_sites ~links
                   ~dotted_links)
    in

    let _,get_agent_rule_up,rule_up =
      make_rule agent ~with_c ~agents ~links ~free_sites ~bound_sites ()
    in
    let agents = [A 1] in
    let _,get_agent_rule_down,rule_down =
      make_rule agent ~agents ()
    in
    let rule_down = move_remanent_bellow 0.8 rule_down rule_up in
    let rule_down = translate_graph {abscisse=0.85;ordinate=0.} rule_down in
    let sigmad,sigmau,rule_apply = disjoint_union rule_down rule_up in
    let rule_apply =
      match get_agent_rule_down (A 1), get_agent_rule_up (A 1) with
      | None, _ | _, None -> rule_apply
      | Some agrule, Some agreaction ->
      add_proj
        [lift_agent sigmad agrule,
         lift_agent sigmau agreaction]
        rule_apply
    in
    name, get_agent_rule_up, rule_apply

let name,_,degradation_rule =
  let agents = [A 1] in
  let agent = A 1 in
  let name = "degradation_rule.ladot" in
  make_rule agent ~agents ~name ()

let () = dump name degradation_rule

let name,agent_cm, g_cm =
  make_gen
    ~name:"contact_map.ladot"
    ~agents:[A 1;B;C]
    ~free_sites:[A 1,1;A 1,2;A 1,3;
                 B,1;B,2;B,3;B,4;
                 C,1;C,2]
    ~links:[1;2;3;4;5;6] ()
let () = dump name g_cm

let name,agent,g =
  make_species
    ~agents:[A 1;B;C]
    ~links:[1;2] ()
let () = dump name g

let name,agent,g =
  make_species
    ~agents:[A 1;A 2;B;C]
    ~links:[11;22;52] ()
let () = dump name g

let name,agent,g =
  make_reaction
    (A 1)
    ~agents:[A 1;B;C]
    ~links:[1;2] ()
let () = dump name g

let name,agent,g =
  make_reaction
    (A 1)
    ~agents:[A 1;A 2;B;C]
    ~links:[11;22;52] ()
let () = dump name g

let name,agent,g =
  make_reaction
    (A 2)
    ~agents:[A 1;A 2;B;C]
    ~links:[11;22;52] ()
let () = dump name g

let with_id=true
let name,agent,g = make_pattern
    ~with_id
    ~agents:[A 1;B;C]
    ~free_sites:[A 1,1]
    ~bound_sites:[B,1]
    ~links:[1;2;6]
    ~dotted_links:[3;4;5] ()
let () = dump name g
let name,agent,g = make_pattern
    ~name:"positive_extended_pattern.ladot"
    ~with_id
    ~agents:[A 1;B;C]
    ~free_sites:[B,1;B,2;B,3;C,2]
    ~bound_sites:[]
    ~links:[6]
    ~dotted_links:[1;2;3;4;5] ()
let () = dump name g
let name,agent,g = make_pattern
    ~name:"negative_extended_pattern.ladot"
    ~with_id
    ~agents:[A 1;B;C]
    ~free_sites:[]
    ~bound_sites:[B,3;B,2;B,1]
    ~links:[5;6]
    ~dotted_links:[1;2;3] ()
let () = dump name g
let name,agent,g = make_pattern
    ~ommitted_agents:[A 1]
    ~agents:[A 1;B;C]
    ~free_sites:[A 1,1]
    ~links:[1;2;3;4;5;6]
    ()
let () = dump name g

let name,agent,g =
  make_pattern
    ~agents:[A 1;B;C]
    ~free_sites:[B,1]
    ~bound_sites:[B,3]
    ~links:[1;2;3;4;6]
    ()
let () = dump name g

let name,agent,g =
  make_square_reaction
    (A 1)
    ~agents:[A 1;A 2;B;C]
    ~links:[11;22;52] ()
let () = dump name g

let name,agent,g =
  make_rule
    (A 1)
    ~agents:[A 1;B;C]
    ~free_sites:[A 1,1]
    ~bound_sites:[B,1]
    ~links:[1;2;6]
    ()
let () = dump name g

let name,agent,g =
  make_square_rule
    (A 1)
    ~agents:[A 1;B;C]
    ~free_sites:[A 1,1]
    ~bound_sites:[B,1]
    ~links:[1;2;6]
    ()
let () = dump name g

let name,agent_sigma,g_sigma =
  make_gen
    ~name:"sigma_graph.ladot"
    ~agents:[A 1;A 2;B;C]
    ~free_sites:[A 1,2;A 2,1;A 2,2;A 2,3;B,1;B,2;B,3;B, 4;C,1;C,2]
    ~links:[11;21;31;41;22;32;42;51;52;6]
    ()
let () = dump name g_sigma

let cm = move_remanent_right_to 1. g_cm g_sigma
let cm = translate_graph {abscisse=0.;ordinate=(-.0.4)} cm
let sigma_sigma, sigma_cm, both = disjoint_union g_sigma cm
let map =
  List.fold_left
    (fun map (site1,site2) ->
       match agent_sigma site1, agent_cm site2 with
       | None,_ | _,None -> map
       | Some s1, Some s2 ->
         (lift_agent sigma_sigma s1, lift_agent sigma_cm s2)::map)
    [] [A 1,A 1;A 2,A 1;B,B;C,C]
let morphism =
  add_proj
    map
    both

let () = dump "morphism.ladot" morphism

let name,agent_of_p,p =
  make_pattern
    ~name:"pattern.ladot"
    ~agents:[A 1]
    ~bound_sites:[A 1,3]
    ~free_sites:[A 1,1]
    ()

let () = dump name p

let name,agent_of_s,s =
  make_species
    ~name:"species.ladot"
    ~agents:[A 1;A 2;B;C]
    ~links:[11;21;32]
    ()


let () = dump name s

let tp = translate_graph {abscisse=0.;ordinate=(-.0.3)} p
let sp = move_remanent_right_to 0.8 s p
let sp = translate_graph {abscisse=0.;ordinate=(-.0.4)} sp
let sigma_p, sigma_sp, both = disjoint_union tp sp
let map =
  List.fold_left
    (fun map (site1,site2) ->
       match agent_of_p site1, agent_of_s site2 with
       | None,_ | _,None -> map
       | Some s1, Some s2 ->
         (lift_agent sigma_p s1, lift_agent sigma_sp s2)::map)
    [] [A 1,A 1]
let embedding =
  add_proj
    map
    both

let () = dump "embedding.ladot" embedding

let name,agent_of_p,p =
  make_pattern
    ~name:"patternprime.ladot"
    ~agents:[A 1]
    ~free_sites:[A 1,1]
    ()

let () = dump name p


let sp = move_remanent_right_to 1. s p
let sp = translate_graph {abscisse=0.;ordinate=(-.0.4)} sp
let sigma_p, sigma_sp, both = disjoint_union p sp
let map =
  List.fold_left
    (fun map (site1,site2) ->
       match agent_of_p site1, agent_of_s site2 with
       | None,_ | _,None -> map
       | Some s1, Some s2 ->
         (lift_agent sigma_p s1, lift_agent sigma_sp s2)::map)
    [] [A 1,A 1]
let embedding =
  add_proj
    ~name:(Some [Some "w"])
    map
    both

let () = dump "weak_embedding.ladot" embedding

let name,agent_of_ep_cons,ep_cons =
  make_pattern
    ~kind:1
    ~name:"extended_pattern_consumption.ladot"
    ~with_id:true
    ~agents:[A 1;B;C]
    ~free_sites:[C,2]
    ~bound_sites:[B,1;B,2;B,3]
    ~dotted_links:[1;2;3;4]
    ()

let () = dump name ep_cons

let name,agent_of_ep_cons,ep_cons =
  make_pattern
    ~kind:1
    ~name:"ext_pat_cons.ladot"
    ~with_id:false
    ~agents:[A 1;B;C]
    ~free_sites:[B,1]
    ~bound_sites:[B,2;B,3;C,2]
    ~dotted_links:[1;2;5]
    ()

let () = dump name ep_cons


let name,_,ep_prod =
  make_pattern
    ~kind:2
    ~name:"extended_pattern_production.ladot"
    ~with_id:true
    ~agents:[A 1;B;C]
    ~free_sites:[B,1]
    ~bound_sites:[B,2;B,3]
    ~links:[5;6]
    ~dotted_links:[1;2]
    ()

let () = dump name ep_prod

let name,_,ep_prod =
  make_pattern
    ~kind:2
    ~name:"ext_pat_prod.ladot"
    ~with_id:false
    ~agents:[A 1;B;C]
    ~free_sites:[B,1]
    ~bound_sites:[B,2;B,3]
    ~links:[5]
    ~dotted_links:[1;2]
    ()

let () = dump name ep_prod

let l = [1;2;3;4]
let wp l =
  List.fold_left
    (fun wp l ->
       List.fold_left
         (fun wp suf -> (l::suf)::suf::wp)
         [] wp)
    [[]] (List.rev l)
let p l =
  if List.mem 3 l then not (List.mem 2 l || List.mem 4 l)
  else true

let f l =
  let name,_,g =
    make_pattern
      ~agents:[A 1;B;C]
      ~free_sites:[C,2]
      ~bound_sites:[B,1;B,2;B,3]
      ~links:l
      ()
  in dump name g
let () = List.iter f (List.filter p (wp l))


let _,agent_of_p_cons,p_cons =
  make_pattern
    ~agents:[A 1;B;C]
    ~free_sites:[C,2]
    ~bound_sites:[B,1;B,2;B,3]
    ()

let s = move_remanent_right_to 1. s p_cons
let sigma_p,sigma_sp,both =
  disjoint_union p_cons s
let deal_with l ag  =
  match
    agent_of_p_cons ag,
    agent_of_s ag
  with
  | None, _ | _,None -> l
  | Some a,Some b -> (lift_agent sigma_p a,lift_agent sigma_sp b)::l

let both =
  add_proj
    (List.fold_left deal_with [] [A 1;B;C])
    both

let () = dump "realisation_embedding.ladot" both

let f l =
  let name,_,g =
    make_pattern
      ~with_id:true
      ~agents:[A 1;B;C]
      ~free_sites:[B,1]
      ~bound_sites:[B,2;B,3]
      ~links:(l@[5;6])
      ()
  in dump name g
let () = List.iter f (wp [1;2])

let l = []

let name (a,b) =
  let with_c =
    List.exists (fun a -> match a with C _ -> true | _ -> false) a
    || List.exists (fun a -> a=5 || a=6) b
  in
  let b = List.filter (fun a -> a<>6) b in
  "$n"^(if with_c then "_{\\agentfont{C}," else "_{")^(if b = [] then "_{\\emptyset}" else ("_{\\{"^(fst (List.fold_left (fun (s,b) a ->
      s^(if b then "," else "")^(string_of_int a),true) ("",false) b ))^"\\}}}$"))


let fold_l l =
  List.fold_left
    (fun g (agents,links,name_opt,hshift) ->
       let _,_,g' = make_species ~agents ~links () in
       let name =
         match name_opt with
         | None -> name (agents,links)
         | Some name -> name
       in
       let Some (x,x',y,y') = corners g' in
       let dy = y-.y' in
       let g' = insert_text_here ~directives:[Fontsize 20] name 0.1 (y-.0.2) g' in
       let g' = translate_graph {abscisse=0.;ordinate=(-.y)} g' in
       let g' = move_remanent_right_to 0.3 g' g in
       let _,_,g = disjoint_union g g' in
       g)
    signature l

let state =
  fold_l
    [
      [A 1;A 2;B;C],[1;2;52],Some ("$n'_{\\agentfont{C},\\{1,2,5\\}}$"),0.;
      [A 1;B;C],[1;2;5],None,0.4;
      [A 1;B],[1;2],None,0.4;
      [A 1;B;C],[1],None,0.4
    ]

let _ = dump "state.ladot" state

let l = [1;2;5]
let wp = wp  l
let make links =
  let agents = if links=[] then [B;C] else [A 1;B;C] in
  let free_sites = [B,1] in
  let bound_sites =
    let fone l =
      if List.mem 1 links then l else (B,3)::l
    in
    let ftwo l =
      if List.mem 2 links then l else (B,2)::l
    in
    let ffive l =
      if List.mem 5 links then l else (C,2)::l
    in
    fone (ftwo (ffive []))
  in
  let name = "pat"^(List.fold_left  (fun string link  -> string^"_"^(string_of_int link)) "" links)^".ladot" in
  let _,_,g = make_pattern ~agents ~bound_sites ~free_sites ~links () in
  dump name g

let () = List.iter make wp

let name,_,g =
  make_pattern ~bound_sites:[B,2;B,3;C,2] ~free_sites:[B,1] ~name:"pat_cons.ladot" ()
let _ = dump name g

let name,_,g = make_pattern
     ~free_sites:[B,1;B,2;B,3] ~bound_sites:[C,2] ~name:"pat_prod.ladot" ()
let _ = dump name g

let name,_,g = make_rule (A 1)  ~agents:[A 1]  ~name:"case_deg_a.ladot" ()
let _ = dump name g

let name,_,g = make_rule (A 1)  ~free_sites:[B,1]  ~links:[1;2;52]
    ~name:"case_ref_deg_a.ladot" ()

let _ = dump name g
