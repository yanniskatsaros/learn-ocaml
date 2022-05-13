(* Note, none of these solutions use pattern matching or optimize for tail-recursion
 * yet as these are concepts introduced in later chapters
 *)
let times10 x = 10 * x

let both_nonzero a b =
  if (a <> 0) && (b <> 0) then true else false

let rec sum n =
  if n = 0 then 0 else n + sum (n - 1)

let rec power x n =
  if n = 0 then 1 else x * power x (n - 1)

let isconsonant c =
  if c = 'a'
    || c = 'e'
    || c = 'o' 
    || c = 'u' then false else true

let rec factorial n =
  if n < 1 then 0
  else if n = 1 then 1
  else n * factorial (n - 1)
