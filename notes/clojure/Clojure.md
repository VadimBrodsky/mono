## Docs
- Clojure API [docs](http://clojure.github.io/clojure/)
- [Cheatsheet](https://clojure.org/api/cheatsheet)

## Tooling
- Leiningen - clojure project automation, generate, build, run, dependencies
- Creates app scaffold
- Uses `project.clj` as the configuration file
- Source code goes into `src/<project_name>/core.clj`

Generate a new project:
```sh
lein new app cojure-app
```

Build and run:
```sh
lein run
```

Run REPL:
```sh
lein repl
# or
clj
```

REPL commands:
- The results of evaluating the 3 most recent expressions in the REPL are stored in `*1`, `*2` and `*3`
- The `*e` special variable holds the last exception
- Can print the stack trace via `(pst)`
- Load a file into a REPL with `(load-file "core.clj")`
- Load a library with `(require 'clojure.java.io)`
- Documentation for functions `(doc str)`, doc strings can be added to any function by placing it immediately after the function name
- Search for anything `doc` output matches a regular expression or string `(find-doc s)`

Generate a Java executable:
```sh
lein uberjar
# run with java
java -jar target/uberjar/project_name-0.1.0-SNAPSHOT.jar
```

## Syntax
Two kinds of structures or forms that Clojure evaluates to produce a value:
- Literal representation of data structures
- Operations, how you do things, `(operator operand1 operand2 ... operandn)`

### Simple Values - Literals
- Expressions that evaluate to themselves

```clojure
42             ;; => 42 integer
1.13           ;; => 1.13 decimal
1/3            ;; => 1/3 ratio
2/1            ;; => 2
"jam"          ;; => jam string
"\"news\""     ;; => "news" string
:jam           ;; => :jam keywords, symbolic identifiers
\j             ;; => \j single character j
true           ;; => true, boolean
false          ;; => false, boolean
nil            ;; => nil, absence of a value

;; Use simple values in an expression
(+ 1 1)        ;; => 2
(+ 1 (+ 8 3))  ;; => 12, inner expression was evaluated first
(/ 1 3)        ;; => 1/3, using division
(/ 1 3.0)      ;; => 0.33333333
```

#### Simple Values Operations

```clojure
(srt "hello" " world")   ;; converts to strings / concatenates strings
```

#### Conditionals

If expression

```clojure
(if boolean-form         ;; evaluates to truthy or falsey value
  then-form
  optional-else-form)    ;; if omitted clojure returs nil
```

Do expression, wrap multiple forms to run each one of them

```clojure
(if  true
  (do (println "Success!")
      "By Zeus hammer!")
  (do (println "Failure!")
      "By Aquaman's Trident!"))

;; => Success!
;; => "By Zeus hammer!"
```

When expression, combination of if and do, but without the else

```clojure
(when true
  (println "Success!")
  "Abracadabra")
```

Clojure has `nil`, `true`, and `false` values, `nil` is used to indicates no value.

```clojure
(nil? 1)      ;; => false
(nil? nil)    ;; => true
```

- `nil` and `false` represent logical falseness
- all other values are logically truthy

Equality operator

```clojure
(= 1 1)        ;; => true
(= nil nil)    ;; => true
(= 1 2)        ;; => false
```

### Logical operators

`or` returns either the first truthy value or the last value

```clojure
(or false nil :large_I_mean_venti :why_cant_I_just_say_large)   ;; => :large_I_mean_venti
(or (= 0 1) (= "yes" "no"))                                     ;; => false
(or nil)                                                        ;; => nil
```

`and` returns the first falsey value or, if no values are falsey the last truthy value

```clojure
(and :free_wifi :hot_coffee)                                    ;; => :hot_coffee
(and :feeling_super_cool nil false)                             ;; => nil
```

### Naming Values
- Use `def` to bind a name to a value in Clojure
- In Clojures variables are immutable and cannot be re-assigned, they are constants

```clojure
(def names
  ["John" "Jorah" "Jaime"])
names
;; => ["John" "Jorah" "Jaime"]
```

### Data Collections
- Clojure has lists, vectors, maps and sets
- All Clojure data structures are immutable

#### Lists - collections of things in a given order
- can mix and match values
- commas or white space are used to separate items


```clojure
'(1 2 "jam" :marmalade-jar)  ;; => (1 2 "jam" :marmalade-jar)
'(1, 2, "jam", :bee)         ;; => (1 2 :jam :bee)
```

#### List Operations

```clojure
;; The list function to build a list
(list 1 2 3 4 5)            ;; => (1 2 3 4 5)

;; Get the first item in the list
(first '(:rabbit :pocket-watch :marmalade :door))
;; => :rabbit

;; Get the rest of the items
(rest '(:rabbit :pocket-watch :marmalade :door))
;; => (:pocket-watch :marmalade :door)

;; Nesting first and rest
(first (rest (rest (rest '(:rabbit :pocket-watch :marmalade :door)))))
;; => :door

;; end of the list is nil
(first (rest (rest (rest (rest '(:rabbit :pocket-watch :door))))))
;; => nil

;; Adding to a list with cons
;; cons takes two arguments, first is the element second is the list
(cons 5 nil)           ;; => (5)
(cons 4 (cons 5 nil))  ;; => (4 5)

;; last element of a list, slow - goes one-by-one
(last '(:rabbit :pocket-watch :marmalade :door))    ;; => :door
;; nth element of a list, slow - goes one-by-one
(nth '(:rabbit :pocket-watch :marmalade :door) 2)   ;; => :marmalade

;; count the size of a collection
(count '(:rabbit :pocket-watch :marmalade :door))   ;; => 4

;; conj adds one or more items to a collection, at the most natural way for the
;; data structure, for lists it will be at the beginning
(conj '(:toast :butter) :jam)        ;; => (:jam:toast :butter)
(conj '(:toast :butter) :jam :honey) ;; => (:honey :jam :toast :butter)
```

#### Vectors - a list with indexes
Similar to array, 0-indexed collection

```clojure
[:jar1 2 3 "wat" :jar2]                     ;; literal
(vector "Stark" "Baratheon" "Targaryen")    ;; function constructor

;; vectors also support first and rest
(first [:jar1 1 2 3 :jar2])   ;; => :jar1
(rest [:jar1 1 2 3 :jar2])    ;; => (1 2 3 :jar2)

;; index based get
(get [3 2 1] 0)                     ;; => 3
(get ["a" {:name "Snow"} "c"] 1)    ;; => {:name "Snow"}

;; fast access to index elements with the nth function, fast - goes by index
(nth [:jar1 1 2 3 :jar2] 0)   ;; => :jar1
(nth [:jar1 1 2 3 :jar2] 2)   ;; => 2

;; last element of a vector, fast - goes by index
(last [:jar1 1 2 3 :jar2])    ;; => :jar2

;; count the size of a collection
(count [:jar1 1 2 3 :jar2])   ;; => 5

;; conj adds one or more items to a collection, at the most natural way for the
;; data structure, for vectors it will be at the end
(conj [:toast :butter] :jam)        ;; => [:toast :butter :jam]
(conj [:toast :butter] :jam :honey) ;; => [:toast :butter :jam :honey]
```

#### Hash Maps - dictionaries

```clojure
;; basic map
{:first-name "John"
  :last-name "Snow"}

;; string key
{"string-key" +}

;; nested
{:name {:first "John" :last "Snow"}}

;; function instead of a literal
(hash-map :a 1 :b 2)

;; look up values
(get {:a 0 :b 1} :b)                         ;; => 1
(get {:a 0 :b {:c "nope"}} :b)               ;; => {:c "nope"}
(get {:a 0 :b 1} :c)                         ;; => nil
(get {:a 0 :b 1} :c "not here")              ;; => "not here" as the default

;; nested look up
(get-in {:a 0 :b {:c "inception"}} [:b :c])  ;; => "inception"

;; lookup using the map as a function
({:name "John Snow"} :name)                  ;; => "John Snow"

;; lookup using keywords as functions
(:name {:name "John Snow"})                  ;; => "John Snow"
```

#### Keywords
Used as keys in maps, can be used as functions for lookup

```clojure
:a
:42
:_?

(:a {:a 1 :b 2 :c 3})                        ;; => 1
(:d {:a 1 :b 2 :c 3} "a default value")      ;; => "a default value"
```

## Additional notes migrated from Obi1

- [Setup](Clojure/Setup.md)
	
# REPL - Read Eval Print Loop
collapsed:: true
	- First need to install `lein`
	- Start the repl by `lein repl`
	- To exit the repl
	  collapsed:: true
		- `ctrl + d` keyboard shortcut on unix machines
		- `(exit)` command
	- Load a `clj` file into the REPL
	  collapsed:: true
		- ` (load-file "solutions/add-and-make.clj")`
	- Evaluation
	  collapsed:: true
		- The REPL evaluates the expressions and prints the results back
		- ```clojure
		  1                ; 1
		  "hello world!"   ; "hello world!"
		  true             ; true
		  *file*           ; "NO__SOURCE_PATH"
		  +                ; #<core$_PLUS_ clojure.core$_PLUS_@38a92aaa>
		-
- # Leiningen
	- [Leiningen is the easiest way to use Clojure. With a focus on project automation and declarative configuration, it gets out of your way and lets you focus on your code.](https://leiningen.org/)
	- ## Creating a new project
		- ```shell
		  lein new app superapp
	- ## Running
		- ```shell
	- ## Building
		- ```shell
		  java -jar target/uberjar/superapp-0.1.0-SNAPSHOT-standalone.jar
	- ## Project Repl
		- ```shell
		  # from within the project folder
# Language
collapsed:: true
	- ## Comments
	  collapsed:: true
		- Inline comments in Clojure use the `;`
		- ```clojure
		  ; This is a colmment in Clojure
	- ## Naming
	  collapsed:: true
		- Clojure allows dashes in symbols
		- Clojure programmers prefer dashes to underscores, camel case is uncommon.
		- Use the `def` function to bind a value to a global name
		  collapsed:: true
			- ```clojure
			  (def two 2)                    ; #'user/two
			  
			  (def twice (fn [n] (+ n n)))   ; #'user/twice
			  (twice 10)                     ; 20
			  
			  (twice two)                    ; 4 
			- You can use `def` with a particular symbol more than once, this the only exception to Clojure's "no changing a binding" rule.
	- ## Operators
	  collapsed:: true
		- Arithmetic operators are no different than regular functions
	- ## Expressions
	  collapsed:: true
		- Following a list structure
		  collapsed:: true
			- The first token in an expression is a parenthesis `(`, which tells the reader to start a list.
			- The second token represents the function
			- The other tokens are the inputs
			- The last token is the closing parenthesis `)`, signals that the list is complete
		- Clojure is recursively evaluates each of the list elements
		- The first value from a list _must_ be a function (or something that behaves like a function). The evaluator _applies_ the function to the remaining values (its arguments)
		- ```clojure
		  (+ 1 2)       ; 3
		  (+ 1 2 3)     ; 6
		  (+ 1 (- 4 2)) ; 3
		  (odd? 2)      ; false
		  (number? 1)   ; true
		  (number? +)   ; false
		  (fn? +)       ; true
		  (fn? 1)       ; false
	- ## Functions
	  collapsed:: true
		- Clojure has a special form, a special symbol that handled differently by the evaluator.
		- Clojure has a small number of special symbols
		- `fn` creates a new function
		- Functions can be invoked right away
		- ``` clojure
		  (fn [n] (+ n n))       ; #<user$eval66$fn__67 user$eval66$fn__67@5ad75c47>
		  ( (fn [n] (+ n n)) 4)  ; 8
		- Assignment
		  collapsed:: true
			- Clojure does not have an assignment statement
			- With one exception there is no way to change the binding between a symbol and a value
			- Most data structures (trees, sets, vectors, lists, hashmaps, strings etc) do not allow them making them immutable
		- Rest arguments
		  collapsed:: true
			- Clojure functions can take a variable number of arguments
			- Using the `[& args]` in the argument definition
			- It turns the arguments into a sequential collection
			- ```clojure
			  ( (fn [& args] args) 1 2 3 4)    ; (1 2 3 4)
	- ## Lists
	  collapsed:: true
		- Lists are used to create an expression
		- Lists are also a useful data structure
		- ### quote
		  collapsed:: true
			- The `'` tells the evaluator not to interpret the lists as a function call but as data
			- The `'` is syntactic sugar for the `quote ` function
			- ```clojure
			  '(1 2 3)             ; (1 2 3)
			  (quote (1 2 3))      ; (1 2 3)
		- ### list
		  collapsed:: true
			- Also can create a list with a function
			- ```clojure
			  (list 1 2 3 4)      ; (1 2 3 4)
		- ### first
		  collapsed:: true
			- Get the first element
			- ```clojure
			  (first '(1 2 3 4))  ; 1
		- ### rest
		  collapsed:: true
			- Everything after the first element
			- ```clojure
			  (rest '(1 2 3 4))   ; (2 3 4)
		- ### nth
		  collapsed:: true
			- Pick out an element at a particular (zero-based) position
			- ```clojure
			  (nth '(1 2 3 4) 2)  ; 3
		- ### range
		  collapsed:: true
			- produced a sequence of numbers
			- ```clojure
			  (range 1 5)        ; (1 2 3 4)
	- ## Vectors
	  collapsed:: true
		- It takes no more time to access the last element than the first
		- Vectors have a literal notation, surrounded by square brackets
		- Or by using the `vector` function
		- Most list functions apply to vectors, like `first`, `rest` and `nth`
		- ```clojure
		  [1 2 3 4]             ; [1 2 3 4]
		  (vector 1 2 3 4)      ; [1 2 3 4]
	- ## Sequential
	  collapsed:: true
		- Both vectors and lists are sequential
		- ```clojure
		  (sequential? [1 2 3])    ; true
		  (sequential? '(1 2 3))   ; true
		- There is also a `lazyseq` data structure for lazy sequence
		- Some functions that you might think produce vectors actually produce lazyseqs
		- ```clojure
		  (rest [1 2 3])            ; (2 3)
		  ; list?
		  (list? (rest [1 2 3]))    ; false
		  ; vector?
		  (vector? (rest [1 2 3]))  ; false
		  ; seq?
		  (seq? (rest [1 2 3]))     ; true
		  (seq? [1 2 3])            ; false
		  (seq? '(1 2 3))           ; true
		  ; coll? for collection
		  (coll? '[1 2 3])          ; true
		- Equality doesn't depend on the type of a sequential data structure, only on the contents
		- ```clojure
		  (= [2 3] '(2 3))          ; true
		  (= [2 3] (rest [1 2 3]))  ; true
	- ## Evaluation
	  collapsed:: true
		- When the evaluator is given a list from the reader, it evaluates each element of the list, then calls the first element as a function.
		- When it's given a vector, it first evaluates each element and then packages the resulting values as a different vector.
		- This means that literal vectors can and often do contain code snippets
		  collapsed:: true
			- ```clojure
			  [ (+ 1 1) (- 1 1) ]           ; [2 0]
		- This means that quoting is sometimes required for vectors as well as lists
		  collapsed:: true
			- ```clojure
			  ; vector of 2 functions
			  [inc dec]      ; [#object[clojure.core$inc 0x3beb211b "clojure.core$inc@3beb211b"] #object[clojure.core$dec 0x3d5f24ed "clojure.core$dec@3d5f24ed"]]
			  
			  ; vector of 2 symbols, which happen to name functions
			  '[inc dec]     ; [inc dec]
		- Quoting doesn't only apply to entire lists and vectors but to symbols as well
		  collapsed:: true
			- ```clojure
			  'a                          ; a
			  [ 'my 'number (+ 1 3) ]     ; [my number 4]
	- ## Conditionals
	  collapsed:: true
		- Conditionals use the `if` function
		- `if`s are expressions that produce values and can be embedded within other expressions
		- ```clojure
		  (if (odd? 3) (prn "Odd!") (prn "Even!"))   ; "Odd!"
	- ## Applying Functions
	  collapsed:: true
		- A function that hands all the elements of  the vector to a given function, as if they were arguments directly following it in a list
		- Use the `apply` function
		- ```clojure
		  (apply + [1 4 9 16])     ; 30
		- `apply` can be reimplemented using `cons` and `eval`
		  collapsed:: true
			- ```clojure
			  (def my-apply
			      (fn [function sequence]
			          (eval (cons function sequence))))
			- `cons` - constructs a list whose `first` element is `cons`'s first argument and whose `rest` is `cons`'s second argument.
			  collapsed:: true
				- ```clojure
				  (cons "first" [2 3])   ; ("first" 2 3)
			- `eval` applies a function to the arguments.
	- ## Loops
	  collapsed:: true
		- Clojure encourages the use of functions that are applied to all elements of a sequence.
		  collapsed:: true
			- Filter
			  collapsed:: true
				- ```clojure
				  (filter odd? [1 2 3 4])          ; (1 3)
				- The `filter` function applies its first argument, which should be a function to each element of its second argument. Only those who pass are included in the output.
				- ```clojure
				  ; finding the first odd number
				  (first (filter odd? [1 2 3 4]))  ; 1
			- Map
			  collapsed:: true
				- ```clojure
				  ; mapping and incrementing by 1
				  (map inc [0 1 2 3])              ; (1 2 3 4)
				- The `map` function can take more than one sequence argument
				- ```clojure
				  (map * [0 1 2 3]
				         [100 200 300 400])        ; (0 200 600 1200)
				  
				  ; equivalent to
				  (list (apply * [0 100])
				        (apply * [1 200])
				        (apply * [2 300])
				        (apply * [3 400]))
			- Take
			- Distinct
			- Concat
			- Repeat
			- Interleave
			- Drop and Drop-last
			- Flatten
			- Partition
			- Every?
			- Remove and Create function argument with fn
			- `=`
			  collapsed:: true
				- Equality
				- ```clojure
				  (= 1 1)        ; true
				  (= 2 5)        ; false
			- `count`
			  collapsed:: true
				- Length of a sequence
				- ```clojure
				  (count [1 2 3 4 5])  ; 5
			- `and`, `or`, `not`
			  collapsed:: true
				- Boolean function
			- `elt sequence`
			  collapsed:: true
				- Make a new sequence with the `elt` on the front
				- ```clojure
				  (cons elt sequence)
			- `inc`, `dec`
			  collapsed:: true
				- Add and subtract one
			- `empty`
			  collapsed:: true
				- Is the sequence empty
				- (empty? [])        ; true
				  (empty? [1 2 3 4]) ; false
			- `nth`
			  collapsed:: true
				- Uses zero-based indexing
				- ```clojure
				  (nth sequence index)
			- `last`
			  collapsed:: true
				- The last element
				- ```clojure
				  (last sequence)
			- `reverse`
			  collapsed:: true
				- Reverses a sequence
				- ```clojure
				  (reverse sequence)
			- `print`, `println`, `prn`
			  collapsed:: true
				- Prints things
				- `print` and `println` print in a human friendly format
			- `pprint`
			  collapsed:: true
				- Short for pretty-print, it prints a nicely formatted representation of its single argument
	- ## Docs
	  collapsed:: true
		- Clojure REPL has a built-in documentation tool.
		- user=> (doc filter)
		  -------------------------
		  clojure.core/filter
		  ([pred] [pred coll])
		    Returns a lazy sequence of the items in coll for which
		    (pred item) returns logical true. pred must be free of side-effects.
		    Returns a transducer when no collection is provided.
		  nil
		- [ClojureDocs](https://clojuredocs.org/)
