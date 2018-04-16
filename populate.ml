open Array
open Printf
open Random
let _ = init 1365435434354

(* Populate tables by random associations *)

let pop file n =
  let f_out = open_out (file ^ "2.csv") in

  for i = 0 to n do
    let m1 = (int 25000000) + 1000000 in
    let m2 =  (int 25000000) + 1000000 in
    fprintf f_out "%d,%d\n" m1 m2 ;
    flush f_out
  done ;

  close_out f_out


let group_followed = pop "group_followed" 100000
