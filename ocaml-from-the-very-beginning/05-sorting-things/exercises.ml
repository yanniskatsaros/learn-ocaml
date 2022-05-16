(* 1. In msort, we calculate the value of the expression length l / 2 twice. Modify msort to remove this inefficiency. *)

(* if we're going to do this, might as well re-write it. we first need a few of the functions
   we wrote earlier in the chapter such as [take], [drop], [merge] *)
let rec length lst =
  let rec go lst acc =
    match lst with
      | [] -> acc
      | h :: t -> go t (acc + 1)
  in go lst 0

let rec take n lst =
  match n with
  | 0 -> []
  | _ ->
    match lst with
    | [] -> raise ( Failure "no more elements to take" )
    | h :: t -> h :: take (n - 1) t
  
let rec drop n lst =
  match n with
  | 0 -> lst
  | _ ->
    match lst with
    | [] -> raise ( Failure "no more elements to drop" )
    | h :: t -> drop (n - 1) t

let rec merge a b =
  match (a, b) with
  | [], lst -> lst
  | lst, [] -> lst
  | (ha::ta, hb::tb) ->
    if ha < hb
      then ha :: merge ta b
      else hb :: merge a tb

let rec mergesort lst = match lst with
  | [] -> []
  | [x] -> [x]
  | _ ->
    let n_half = (List.length lst) / 2 in
    let left = take n_half lst in
    let right = drop n_half lst in
    merge (mergesort left) (mergesort right)

(* phew, that was a lot of work but voila! *)

(* 2. We know that take and drop can fail if called with incorrect arguments. Show that this is never the case in msort. *)

  (* [mergesort] (or [msort]) begins by pattern matching on [lst], checking for an empty list
     so a call to take/drop from an empty list will never happen. we can convince ourselves of this
     simply by calling mergesort [] or mergesort [1] *)

(* 3. Write a version of insertion sort which sorts the argument list into reverse order. *)

(* the simplest fix is to change the comparison in the [insert] function *)
let rec insertion_sort_reverse l =
  let rec insert x l =
    match l with
    | [] -> [x]
    | h::t ->
      if x > h
        then x :: h :: t
        else h :: insert x t
      in
  match l with
  | [] -> []
  | h::t -> insert h (insertion_sort_reverse t)

(* 4. Write a function to detect if a list is already in sorted order. *)

let rec is_sorted = function
  | [] -> true
  | [_] -> true
  | fst :: snd :: t -> (fst < snd) && is_sorted (snd :: t)


(* 5. We mentioned that the comparison functions like  <  work for many OCaml types.
   Can you determine, by experimentation, how they work for lists? For example,
   what is the result of [1; 2] < [2; 3]? What happens when we sort the following
   list of type char list list? Why? *)

  (* kinda, not really-ish? best I can tell without looking any docs up, the comparison
    happens "element-wise" for each item in the list calling a < b, but this isn't
    fully clear to me because operations like [1; 2; 3] < [4; 5] don't throw an error,
    they return a bool. so my best guess is that every element in the LHS is compared
    to every element on the right-hand side with the given operator. For example,
    [1; 2; 3] < [4; 5] => true because every element on the LHS is < every element on
    the RHS. However an example such as [1; 2; 3] < [3; 4; 5; 6] => false because 
    3 < 3 => false (even though all other comparisons return true) *)

(* 6. Combine the sort and insert functions into a single sort function. *)
  (* basically did this already in [insertion_sort_reverse] above*)
