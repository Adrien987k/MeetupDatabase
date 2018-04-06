open Printf
open Array


let category =
  let categories_in = open_in "categories.csv" in
  let categories_out = open_out "categories2.csv" in
  let _ = input_line categories_in in

  let selected = make 4 true in
  selected.(3) <- false;

  let i = ref 0 in
  try let c = ref (input_char categories_in) in
  while true do

    if !c = ',' then begin incr i end ;
    if selected.(!i) then begin output_char categories_out !c end ;
    if !c = '\n' then begin
      output_char categories_out '\n';
      i := 0 ;
      flush categories_out
    end ;

    c := input_char categories_in
  done with End_of_file -> () ;

  close_in categories_in ;
  close_out categories_out
