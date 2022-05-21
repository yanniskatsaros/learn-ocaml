(* 1a. Write a simple recursive function calm to replace exclamation marks in a char list with periods. *)
let rec calm = function
  | [] -> []
  | '!' :: t -> '.' :: calm t
  | h :: t -> h :: calm t

(* 1b. Now rewrite your function to use map instead of recursion. What are the types of your functions? *)
let calm = List.map (fun c -> if c = '!' then '.' else c)


(* 2a. Write a function clip which, given an integer, clips it to the range 1..10 so that integers bigger
   than 10 round down to 10, and those smaller than 1 round up to 1. *)
let clip i =
  if i < 1
    then 1
    else if i > 10
      then 10
      else i


(* 2b. Write another function cliplist which uses this first function together with map to apply this
   clipping to a whole list of integers. *)
let cliplist = List.map clip

(* 3. Express your function cliplist again, this time using an anonymous function instead of clip. *)
let cliplist = List.map (fun i -> min (max i 1) 10)


(* or instead, this time using the pipe operator! |> *)
let cliplist = List.map (fun i -> i |> max 1 |> min 10)


(* 4. Write a function apply which, given another function, a number of times to apply it, and an
   initial argument for the function, will return the cumulative effect of repeatedly applying the function. *)
let rec apply f n x =
  match n with
  | 0 -> f x
  | _ -> f (apply f (n-1) x)


(* 5. Modify the insertion sort function from the preceding chapter to take a comparison function, in the same
   way that we modified merge sort in this chapter. What is its type? *)
let rec insertion_sort cmp l =
  let rec insert x l =
    match l with
    | [] -> [x]
    | h::t ->
      if cmp x h
        then x :: h :: t
        else h :: insert x t
      in
  match l with
  | [] -> []
  | h::t -> insert h (insertion_sort cmp t)


(* 6. Write a function filter which takes a function of type α → bool and an α list and returns
   a list of just those elements of the argument list for which the given function returns true. *)
let rec filter f lst =
  match lst with
  | [] -> []
  | h :: t ->
    if f h
      then h :: filter f t
      else filter f t

(* 7. Write the function for_all which, given a function of type α → bool and an argument list of
   type α list evaluates to true if and only if the function returns true for every element of the list.
    Give examples of its use. *)
let rec forall f lst =
  match lst with
  | [] -> true
  | h :: t -> (f h) && forall f t

(* examples:
     check whether all elements of a list are even:
     forall (fun a -> a mod 2 = 0) [2; 4; 6; 8];; => true
     forall (fun a -> a mod 2 = 0) [2; 4; 6; 8; 9];; => false
 *)


(* 8. Write a function mapl which maps a function of type α → β over a list of type α list list to produce
   a list of type β list list. *)
let rec mapl f mat =
  match mat with
  | [] -> []
  | [[]] -> [[]]
  | h :: t -> (List.map f h) :: mapl f t

(* took a peak at Derrick's exercises, and there's a much more "functionally pure" way to do this: *)
let mapl f = List.map (List.map f)

(* bonus: write a function flatten which will takes α list list and returns α list *)
let rec flatten = function
  | [] | [[]] -> []
  | first :: others ->
    match first with
    | [] -> flatten others
    | h :: t -> h :: flatten (t :: others)
