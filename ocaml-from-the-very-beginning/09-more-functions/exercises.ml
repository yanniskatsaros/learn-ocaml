(* 1. Rewrite the summary paragraph at the end of this chapter for the three argument function g a b c. *)
  (* The function g a b c has type 'a -> 'b -> 'c -> 'd which can also be written as 'a -> ('b -> ('c -> 'd)) *)

(* therefore, these are the same thing: *)
(* let g a b c = ... *)
(* let g = fun a -> fun b -> fun c -> ... *)


(* 2. Recall the function member x l which determines if an element x is contained in a list l.
   What is its type? What is the type of member x? Use partial application to write a function
   member_all x ls which determines if an element is a member of all the lists in the list of lists ls. *)
let rec member x = function
   | [] -> false
   | h :: t ->
    if x = h
      then true
      else member x t

(* rewriting the function [member] above we can see that it has type 'a -> 'a list -> bool *)

(* approach A - doesn't use any partial application *)
let rec member_all x = function
  | [] -> false
  | h :: t -> match h with
    | [] -> false
    | h' :: t' ->
      if x = h'
        then true
        else member_all x (t'::t)

(* approach B - uses some partial application, is this what the author wants? *)
let member_all x ls =
  let rec all = function
    | [] -> true
    | false :: t -> false
    | true :: t -> all t
  in all (List.map (member x) ls)


(* 3. Why can we not write a function to halve all the elements of a list like this:
   map (( / ) 2) [10; 20; 30]? Write a suitable division function which can be partially
   applied in the manner we require. *)
let divide_by a b = b / a

(* which can then be partially applied like: *)
let _ = List.map (divide_by 2) [2; 4; 6]

(* although we could have easily done: *)
let _ = List.map (fun a -> a / 2) [2; 4; 6]


(* 4. Write a function mapll which maps a function over lists of lists of lists.
   You must not use the let rec construct. *)
let mapll f = List.map (List.map (List.map f))

(* Is it possible to write a function which
   works like map, mapl, or mapll depending upon the list given to it? *)
  
   (* unless we defined a special type that would support arbitary mapping of functions
      through an unknown depth (such as a tree) we cannot *)


(* 5. Write a function truncate which takes an integer and a list of lists,
   and returns a list of lists, each of which has been truncated to the
   given length. If a list is shorter than the given length, it is unchanged.
   Make use of partial application.  *)
let rec truncate l n = match l, n with
  | _, n' when n' < 0 -> raise (Invalid_argument "n must be > 0")
  | [], _ -> []
  | l', 0 -> l'
  | h::t, n' -> h :: truncate t (n' - 1)

let truncate n l =
  let rec go a b n = match (a, b, n) with
    | _, _, n' when n' < 0 -> raise (Invalid_argument "n must be > 0")
    | keep, _, 0 | keep, [], _-> List.rev keep
    | keep, head::tail, n' -> go (head::keep) tail (n' - 1)
  in go [] l n

(* this is what we really wanted *)
let truncatel n = List.map (truncate n)


(* 6. Write a function which takes a list of lists of integers and returns the
   list composed of all the first elements of the lists. If a list is empty,
   a given number should be used in place of its first element. *)

(* we want: val f : int list list -> int list *)
let heads ?(default = 0) l =
  (* we have to redefine List.hd in our own way *)
  let hd d = function
    | [] -> d
    | h::t -> h
  in List.map (hd default) l

(* example usage:
    heads [[1; 2; 3]; [4; 5]] => [1; 4]
    heads [[1; 2; 3]; []] => [1; 0]
    heads ~default:10 [[1; 2; 3]; []] => [1; 10]
   *)
