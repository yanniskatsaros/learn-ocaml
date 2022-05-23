(* 1. Write a function to determine the number of different keys in a dictionary. *)
let numkeys d =
  let rec go d seen = match d with
    | [] -> List.length seen
    | (k, v) :: t ->
      if List.exists (fun i -> i = k) seen
        then go t seen
        else go t (k :: seen)
      in go d []


(* 2. Define a function replace which is like add, but raises Not_found if the key is not already there. *)
let rec replace k v = function
  | [] -> raise Not_found
  | (k', v') :: t ->
    if k' = k
      then (k, v) :: t
      else (k', v') :: replace k v t

(* let's see if we can do this with option types instead *)
let rec replace2 k v = function
  | [] -> None
  | (k', v') :: t ->
    if k' = k
      then Some ((k, v) :: t)
      (* this feels awkward, is there a better way? *)
      else match replace2 k v t with
        | None -> None
        | Some lst -> Some((k', v') :: t)


(* 3. Write a function to build a dictionary from two equal length lists, one containing keys and another
   containing values. Raise the exception Invalid_argument if the lists are not of equal length. *)
let rec zip_dict keys values = match keys, values with
   | [], [] -> []
   | kh :: kt, vh :: vt -> (kh, vh) :: (zip_dict kt vt)
   | _, [] -> raise (Invalid_argument "too many keys")
   | [], _-> raise (Invalid_argument "too many values")


(* 4. Now write the inverse function: given a dictionary, return the pair of two lists -
   the first containing all the keys, and the second containing all the values. *)
let rec unzip_dict d =
  let rec keys = function
    | [] -> []
    | (k, v) :: t -> k :: keys t in
  let rec values = function
    | [] -> []
    | (k, v) :: t -> v :: values t in
  match d with
    | [] -> [], []
    | (k, v) :: t -> (k :: keys t, v :: values t)


(* 5. Define a function to turn any list of pairs into a dictionary. If duplicate keys are found,
   the value associated with the first occurrence of the key should be kept. *)
let rec dict d =
  let rec go d keys values = match d with
    | [] -> zip_dict keys values
    | (k, v) :: t ->
      if List.exists (fun i -> i = k) keys
        then go t keys values
        else go t (k :: keys) (v :: values)
      in go d [] []

(* note this is essentially the same logic as the [numkeys] function above with the main difference
   that we maintain both [keys] and [values] seen thus far, and make use of our previously
   defined [zip_dict] function to build a dictionary from our unique key-values encountered *)


(* 6. Write the function union a b which forms the union of two dictionaries. The union of two dictionaries
   is the dictionary containing all the entries in one or other or both. In the case that a key is contained in both dictionaries, the value in the first should be preferred. *)

(* first way is ~cheating~ but here it is *)
let union a b = dict (a @ b)

(* ok the "real" way now - first we'll need the function to see if a key exists in a dictionary *)
let key_exists k d =
  let rec lookup x = function
    | [] -> None
    | (k, v) :: t ->
      if k = x
        then Some v
        else lookup x t in
  match lookup k d with
    | None -> false
    | Some _ -> true

(* as well as the function to remove a key from a dictionary *)
let rec remove k = function
  | [] -> []
  | (k', v') :: t ->
    if k = k'
      then t
      else (k', v') :: remove k t

(* and voila, the grand finale *)
let rec union a b = match a, b with
  | [], [] -> []
  | a', [] -> a'
  | [], b' -> b'
  | _ -> match a with
    | [] -> union b []
    | (k, v) :: t ->
      if key_exists k b
        then (k, v) :: (union t (remove k b))
        else (k, v) :: (union t b)
