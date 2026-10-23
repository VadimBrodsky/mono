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
