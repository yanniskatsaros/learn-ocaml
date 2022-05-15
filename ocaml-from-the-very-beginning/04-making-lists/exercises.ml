(* Write a function evens which does the opposite to odds, returning the
   even numbered elements in a list. For example, evens [2; 4; 2; 4; 2]
   should return [4; 4]. What is the type of your function? *)
let rec evens = function
  | [] -> []
  | [a] -> []
  | first :: second :: tail -> second :: evens tail


(* Write a function count_true which counts the number of true elements in
   a list. For example, count_true [true; false; true] should return 2.
   What is the type of your function? Can you write a tail recursive version? *)
let rec count_true = function
  | [] -> 0
  | h :: t -> match h with
    | true -> 1 + count_true t
    | false -> count_true t

(* below we have a more optimized, tail recursive version to the above *)
let rec count_true_tr lst =
  (* we use the standard convention of [acc] for the accumulator integer *)
  let rec count_true' lst acc = match lst with
    | [] -> acc
    | h :: t -> match h with
      | true -> count_true' t (acc + 1)
      | false -> count_true' t acc
  in count_true' lst 0

(* Write a function which, given a list, builds a palindrome from it.
   A palindrome is a list which equals its own reverse. You can assume
   the existence of rev and @. Write another function which determines
   if a list is a palindrome. *)
  
(* not quite sure what the author is looking for here, but here we go.
   we'll first need a function to reverse a list so we'll use List.rev
   as an example of using the stdlib *)
  
(* a simple version below just concatenates the original list with its reverse
   which produces output such as:
    palindrome [1; 2; 3; 4] => [1; 2; 3; 4; 4; 3; 2; 1]*)
let palindrome = function
  | [] -> []
  | [a] -> [a]
  | lst -> lst @ List.rev lst

(* if we don't want the tail value repeated in the middle, we need a more complex implementation *)
let palindrome2 = function
  | [] -> []
  | [a] -> [a]
  | lst -> lst @ List.tl (List.rev lst)

(* finally, we need a function to check whether a given list is a palindrome or not *)
let is_palindrome lst =
  lst = List.rev lst

(* Write a function drop_last which returns all but the last element of a list.
   If the list is empty, it should return the empty list. So, for example,
   drop_last [1; 2; 4; 8] should return [1; 2; 4]. What about a tail recursive version? *)
let rec drop_last = function
  | [] -> []
  | [a] -> []
  | h :: t -> h :: drop_last t

(* and here goes the tail recursive version *)
let rec drop_last_tr lst =
  let rec drop_last' head tail =
    match tail with
    | [] -> head
    | [a] -> head
    | h :: t -> drop_last' (head @ [h]) t
  in drop_last' [] lst

(* although not quite sure how efficient this is after all with the head @ [h] operation... *)


(* Write a function member of type α → α list → bool which returns true if an element
   exists in a list, or false if not. For example, member 2 [1; 2; 3] should evaluate
    to true, but member 3 [1; 2] should evaluate to false. *)
let rec member el lst =
  match lst with
  | [] -> false
  | h :: t ->
    if h = el then true else member el t

(* Use your member function to write a function make_set which, given a list, returns
   a list which contains all the elements of the original list, but has no duplicate
   elements. For example, make_set [1; 2; 3; 3; 1] might return [2; 3; 1].
   What is the type of your function? *)

(* we'll use explicit type annotations to answer both parts of the question at once *)
let rec make_set (lst: 'a list) : 'a list =
  let rec make_set' set remaining =
    match remaining with
    | [] -> set
    | h :: t ->
      if (member h set)
        then make_set' set t
        else make_set' (set @ [h]) t
        (* if we dont need to preserve the order seen we can instead use h :: set *)
  in
  make_set' [] lst

(* Can you explain why the rev function we defined is inefficient? How does the time it
   takes to run relate to the size of its argument? Can you write a more efficient
   version using an accumulating argument? What is its efficiency in terms of time taken
   and space used? *)

   (* the initial [rev] implementation is inefficient because the append operator takes
      time proportional to the length of the list on the LHS, in addition to the time
      taken to reverse the actual list *)

let rec rev lst =
  let rec rev' lst acc =
    match lst with
    | [] -> acc
    | h :: t -> rev' t (h :: acc)
  in
  rev' lst []
