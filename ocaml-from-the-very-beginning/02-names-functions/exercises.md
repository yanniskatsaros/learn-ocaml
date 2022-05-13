# Exercises

> Note, none of these solutions use pattern matching or optimize for tail-recursion yet (on purpose) as these are concepts introduced in later chapters.


1. Write a function which multiplies a given number by ten. What is its type?
    ```ocaml
    let times10 x = 10 * x
    ```

    which has type

    ```ocaml
    int -> int
    ```

2. Write a function which returns true if both of its arguments are non-zero, and false otherwise. What is the type of your function?
    ```ocaml
    let both_nonzero a b =
      if (a <> 0) && (b <> 0) then true else false
    ```

    which has type

    ```ocaml
    int -> int -> bool
    ```

3. Write a recursive function which, given a number `n`, calculates the sum 1 + 2 + 3 +...+ n. What is its type?
    ```ocaml
    let rec sum n =
      if n = 0 then 0 else n + sum (n - 1)
    ```

    which has type

    ```ocaml
    int -> int
    ```

4. Write a function `power x n` which raises `x` to the power `n`. Give its type.
    ```ocaml
    let rec power x n =
      if n = 0 then 1 else x * power x (n - 1)
    ```

    which has type

    ```ocaml
    int -> int -> int
    ```

5. Write a function `isconsonant` which, given a lower-case character in the range `'a' ... 'z'`, determines if it is a consonant.

    ```ocaml
    let isconsonant c =
      if c = 'a'
      || c = 'e'
      || c = 'o' 
      || c = 'u' then false else true
    ```

    which has type

    ```ocaml
    char -> bool
    ```

6. What is the result of the expression  `let x = 1 in let x = 2 in x + x` ?

    `4`. This looks confusing at first, but makes more sense when we break it into peices:

    ```ocaml
    let x = 1 in (let x = 2 in x + x)
    ```

    ```ocaml
    let x = 1 in (4)
    ```

    ```ocaml
    Line 1, characters 4-5:
    Warning 26 [unused-var]: unused variable x.
    - : int = 4
    ```

    As we can see, `x` is actually unused in the outer-most scope since the expression evaluates to `4`!


7. Can you suggest a way of preventing the non-termination of the factorial function in the case of a zero or negative argument?

    Checking, and returning a base case of `0` for any argument less than `1`, for example:

    ```ocaml
    let rec factorial n =
      if n < 1 then 0
      else if n = 1 then 1
      else n * factorial (n - 1)
    ```
