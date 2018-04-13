open Printf
open Array

let erase file retained =
  let f_in = open_in (file ^ ".csv") in
  let f_out = open_out (file ^ "2.csv") in
  let _ = input_line f_in in

  let ret = of_list retained in
  let inpar = ref 0 in (* if we are in parenthesis *)
  let cpt = ref 0 in

  let i = ref 0 in
  try let c = ref (input_char f_in) in
  while true do

    if !c = '\"' then begin inpar := 1 - !inpar end ;
    if !c = ',' && !inpar = 0 then begin incr i end ;
    if ret.(!i)=1 then begin output_char f_out !c end ;
    if !c = '\n' then begin
      output_char f_out '\n';
      i := 0 ;
      incr cpt ;
      if !cpt mod 100000 = 0 then begin printf "0" ; flush stdout end ;
      flush f_out
    end ;

    c := input_char f_in
  done with End_of_file -> () ;

  close_in f_in ;
  close_out f_out ;
  printf "\n"

(**
let categories = erase "categories" [1;1;1;0]
let cities = erase "cities" [1;1;1;0;1;0;1;0;0;1;0]
let members = erase "members" [1;1;1;0;0;1;0;0;0;1;0;1;1;0]
let groups = erase "groups" [1;1;0;0;1;0;0;1;1;0;0;0;1;0;0;1;0;0;0;0;1;1;0;0;0;0;0;0;0;0;0;0;0;0;1;1]
let topics = erase "topics" [1;1;0;0;1;1;1]
let groups_topics = erase "groups_topics" [1;0;0;1]
let events = erase "events" [1;1;1;1;0;1;1;0;0;0;1;0;0;0;1;0;0;0;0;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0;0;1;0;0;0;0;0;1;0;0;1;1;1;1]
let venues = erase "venues" [1;1;1;0;0;0;0;0;1;1;1;0;0;0]
let members_topics = erase "members_topics" [1;0;0;1]
*)
