(* The exercises in this chapter were a bit menial, so here are a few notes and exercises with 
   the most important ideas and takeways *)

(* "custom exceptions" can easily be defined as such: *)
exception Not_prime

(* they can also be parameterized (wording?) to carry information along with them *)
exception Not_prime of int

(* and can be raised as follows: *)

(* Write a function smallest which returns the smallest positive element of a list of integers.
   If there is no positive element, it should raise the built-in Not_found exception. *)
let rec smallest = function
  | [] -> raise Not_found
  | h::[] -> if h > 0 then h else raise Not_found
  | a::b::t -> smallest ((min a b) :: t)

(* additionally you can handle exceptions by using a try/with block: *)
let rec smallest_or_zero lst =
  try smallest lst
    with Not_found -> 0
