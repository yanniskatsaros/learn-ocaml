(* 1. Design a new type rect for representing rectangles. Treat squares as a special case.  *)
type rect =
  | Rectangle of int * int
  | Square of int


(* 2. Now write a function of type rect -> int to calculate the area of a given rect. *)
let area = function
  | Rectangle (w, h) -> w * h
  | Square (a) -> a * a


(* 3. Write a function which rotates a rect such that it is at least as tall as it is wide. *)
let rotate = function
  | Square a -> Square a
  | Rectangle (w, h) ->
    if w >= h
      then Rectangle (h, w)
      else Rectangle (w, h)


(* 4. Write take, drop, and map functions for the sequence type. *)

(* we'll need at least one of these helpers *)
let width = function
  | Square w -> w
  | Rectangle (w, _) -> w

let height = function
  | Square h -> h
  | Rectangle (_, h) -> h

(* according to the docs, List.sort takes a comparison function that returns an integer > 0
   if the first argument is greater, an integer < 0 if the second argument is greater and
   0 if the two arguments are the "same" *)
let rect_sort l =
  let cmp a b =
    if (width a) > (width b)
      then 1
      else -1
  in l |> (List.map rotate) |> (List.sort cmp)

(* example usage:
   rect_sort [Rectangle(5, 4); Rectangle(4, 5); Rectangle(1, 2); Rectangle(2, 1); Rectangle(0, 10)] =>
    [Rectangle (0, 10); Rectangle (1, 2); Rectangle (1, 2); Rectangle (4, 5); Rectangle (4, 5)]
   *)

(* side note: I realize it doesn't make much sense for a rectangle to have 0 width/height but we'll
   leave that as a further exercise *)


(* 5. Write take, drop, and map functions for the sequence type. *)

(* first, recall our sequence type was defined as: *)
type 'a sequence =
  | Nil
  | Cons of 'a * 'a sequence

(* which can be used as such *)
let myseq = Cons (1, Cons (2, Cons (3, Cons (4, Nil))))

(* I made the explicit decision to just return the items as-is if there
   are no more items to take from the list. this might not be a good idea
   in situations where the user expects that: take 3 myseq will always return
   exactly 3 elements. *)
let rec take n l =
  if n < 0
    then raise (Invalid_argument "n cannot be negative")
    else
      if n = 0
        then Nil
        else match l with
          | Nil -> Nil
          | Cons (h, t) -> Cons (h, (take (n-1) t))

(* I wrote this one a little cleaner than above, pattern matching
   directly on both n and l instead of using an if-else *)
let rec drop n l =
  if n < 0
    then raise (Invalid_argument "n cannot be negative")
    else match (n, l) with
      | (0, t) -> t
      | (_, Nil) -> Nil
      | (_, Cons (h, t)) -> drop (n-1) t
  
(* finally, the famous map *)
let rec map f = function
  | Nil -> Nil
  | Cons (h, t) -> Cons (f h, map f t)


(* 6. extend the [expr] type and the [evaluate] function to allow raising
   a number to a power *)

(* let's begin by re-defining the [expr] type and the [evaluate] function
   from the text (but in a more terse format) *)
type expr =
  | Num of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr
  | Pow of expr * expr

let rec eval = function
  | Num i -> i
  | Add (a, b) -> (eval a) + (eval b)
  | Sub (a, b) -> (eval a) - (eval b)
  | Mul (a, b) -> (eval a) * (eval b)
  | Div (a, b) -> (eval a) / (eval b)
  | Pow (a, b) -> match (a, b) with
    | (_, Num 0) -> 1
    | (x, Num 1) -> eval x
    | (x, n) -> (eval x) * (eval (Pow (Num (eval x), Num ((eval n) - 1))))
