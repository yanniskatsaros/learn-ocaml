(* first, begin by re-writing our own definition of a tree *)
type 'a tree =
  | Leaf
  | Node of 'a tree * 'a * 'a tree


(* 1. write a function of type 'a -> 'a tree -> bool to determine if
   a given element is in a tree *)
let rec member x = function
  | Leaf -> false
  | Node (left, value, right) ->
    if value = x
      then true
      else (member x left) || (member x right)


(* 2. write a function which flips a tree left to right such that, if
   it were drawn on paper, it would appear to be a mirror image *)
let rec flip = function
  | Leaf -> Leaf
  | Node (left, value, right) -> Node ((flip right), value, (flip left))


(* 3. write a function to determine if two trees have the same shape,
   irrespective of the actual values of the elements *)
let rec same_shape a b = match (a, b) with
  | (Leaf, Leaf) -> true
  | (_, Leaf) | (Leaf, _) -> false
  | ( Node(la, _, ra), Node(lb, _, rb)  ) -> (same_shape la lb) && (same_shape ra rb)


(* 4. write a function tree_of_list which builds a tree representation
   of a dictionary from a list representation of a dictionary *)

let rec insert k v = function
  | Leaf -> Node(Leaf, (k, v), Leaf)
  | Node(l, (k', v'), r) ->
    if k' = k then Node(l, (k, v), r)
    else
      if k' < k
        then Node((insert k v l), (k', v'), r)
        else Node(l, (k', v'), (insert k v r))

let tree_of_list lst = List.fold_left (fun tree (k, v) -> insert k v tree) Leaf lst


(* 5. Write a function to combine two dictionaries represented as trees into one.
   In the case of clashing keys, prefer the value from the first dictionary *)
let merge () =
  failwith "todo"

(* 6. Can you define a type for trees, which instead of branching exactly two ways 
   each time, can branch zero or more ways, possibly different at each branch?
   Write simple functions like [size], [total], and [map] using your new type of tree *)

let sum = List.fold_left (+) 0

type 'a btree =
  | Br of 'a * 'a btree list

let rec size = function
  | Br (_, []) -> 1
  | Br (_, h :: t) -> 
    1 + (size h) + (sum (List.map size t))

let rec total = function
  | Br(value, []) -> value
  | Br(value, h::t) -> value + (total h) + (sum (List.map total t))
