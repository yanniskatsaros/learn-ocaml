# Exercises

1. What are the types of the following expressions and what do they evaluate to, and why?
    - `17`
      
        Type `int`, evaluates to `17` which will be written in the same form as the toplevel output: `- : int = 17`

    -  `1 + 2 * 3 + 4`

        `- : int = 11`

    - `800 / 80 / 8`

        `- : int = 1`
    
    - `400 > 200`

        `- : bool = true`

    - `1 <> 1`

        `- : bool = false`
    
    - `true || false`

        `- : bool = true`
    
    - `true && false`

        `- : bool = false`
    
    - `if true then false else true`

        `- : bool = false`. This is an expression where the first "arm" is returned in the condition evaluates to `true`, and the second arm otherwise.

    - `'%'`

        `- : char = %`

    - `'a' + 'b'`

        `Error: This expression has type char but an expression was expected of type int`. Self-explanatory type-error, but OCaml defines the `+` operator strictly for type `int` (and does not support operator overloading). To "concatenate" two characters into a `string` use: `String.make 1 'a' ^ String.make 1 'b'` which can be wrapped into a simple function if we wish:

        ```ocaml
        let concat_char a b = (String.make 1 a) ^ (String.make 1 b)
        ```

        which has type signature:

        ```ocaml
        val concat_char : char -> char -> string = <fun>
        ```

2. Consider the evaluations of the expressions `1 + 2 mod 3`, `(1 + 2) mod 3`, and `1 + (2 mod 3)`. What can you conclude about the `+` and `mod` operators?

    - `+` and `mod` are binary operators for `int`
    - `mod` has higher precedence than `+`

3. A programmer writes `1+2 * 3+4`. What does this evaluate to? What advice would you give him?

    Due to order of operations (operator precedence), `*` takes place before `+` thus this expression is equivalent to: `1 + (2 * 3) + 4`. If instead the programmer intended to add each pair _first_, then multiply, consider: `(1 + 2) * (3 + 4)`

4. The range of numbers available is limited. There are two special numbers: `min_int` and `max_int`. What are their values on your computer? What happens when you evaluate the expressions `max_int + 1` and `min_int - 1`?

    The values evaluate to: `-4611686018427387904` and `4611686018427387903`. If we attempt to go above or below these limits we see integer overflow takes place and the value wraps around. For example `max_int + 1` evaluates to `-4611686018427387904` (which is the same value of `min_int`).

    > __Note__ to handle big integers we make use of OCaml's big integer library, [Zarith](https://antoinemine.github.io/Zarith/doc/latest/Z.html).

5. What happens when you try to evaluate the expression `1 / 0`? Why?

    OCaml raises `Exception: Division_by_zero.` due to the undefined nature of division by zero.

6. Can you discover what the `mod` operator does when one or both of the operands are negative? What about if the first operand is zero? What if the second is zero?

    All are valid inputs to `mod` *except* for the case where we have `n mod 0` which leads to `Exception: Division_by_zero.`

7. Why not just use, for example, the integer `0` to represent `false` and the integer `1` for `true`? Why have a separate `bool` type at all?

    Although it's certainly _possible_ to do so, having a separate `bool` type is important because we are able to express to the compiler that we have a mutually exclusive value - ie: if a value is of type `bool` it *must* either be `true` or it *must* either be `false` and there is no other variant. In contrast, integers can take on multiple values and we would lose the ability to express boolean algebra effectively.

8. What is the effect of the comparison operators like `<` and `>` on alphabetic values of type `char`? For example, what does `'p' < 'q'` evaluate to? What is the effect of the comparison operators on the booleans, `true` and `false`?

    - `char` support comparison operators (such as `<` and `>`) assuming both values being compared are of the same type. The characters are compared lexicographically such that `'a' < 'b'` evaluates to `true`. (Note, it appears the comparison is not case sensitive, so `'A' < 'b'` also evalautes to `true`)
    - OCaml defines that `true > false` (and `true >= false`) evaluates to `true`
