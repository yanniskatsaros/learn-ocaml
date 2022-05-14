(* Rewrite the not function from the previous chapter in pattern matching style. *)
let not x =
  match x with
  | true -> false
  | false -> true


(* Use pattern matching to write a recursive function which, given a
   positive integer n, returns the sum of all the integers from 1 to n. *)
let rec sum n =
  if n < 0 then raise (Invalid_argument "n cannot be negative") else
    match n with
    | 0 -> 0
    | 1 -> 1
    | x -> x + sum (x - 1)


(* Use pattern matching to write a function which,
   given two numbers x and n, computes x to the power of n. *)
let rec pow x n =
  if n < 0 then raise (Invalid_argument "n cannot be negative") else
    match n with
    | 0 -> 1
    | n' -> x * pow x (n' - 1)


(* For each of the previous three questions, comment on whether you think it is
   easier to read the function with or without pattern matching. How might you
   expect this to change if the functions were much larger? *)

    (* Pattern matching makes it very clear how the function branches for various cases
      of the data, which is preferable to multiple nested if-then-else statements
      which become difficult to read (and more verbose) for more complex cases *)


(* What does match 1 + 1 with 2 -> match 2 + 2 with 3 -> 4 | 4 -> 5 evaluate to? *)

    (* This evaluates to 5 which can be verified in utop. The main takeway from this
       question (in my opinion) is understanding how match statements structurally match
       values and take specific paths/branches depending on the match. 1 + 1 evaluates to 2
       which is why the branch matching 2 returns a new match statement which matches on 4
       so the match branch with 3 does not succeed, and the match branch with 4 matches, returning 5 *)

(* There is a special pattern x..y to denote continuous ranges of characters, for example
   'a'..'z' will match all lowercase letters. Write functions islower and isupper, each of
   type char → bool, to decide on the case of a given letter. *)
let islower c =
  match c with
  | 'a'..'z' -> true
  | _ -> false

let isupper c =
  match c with
  | 'A'..'Z' -> true
  | _ -> false

(* note, it is tempting to write isupper as the compliment of islower (below) but this would not
   be correct because characters such as '1' or '2' would return true instead of false *)
let isupper_incorrect c = not (islower c)
