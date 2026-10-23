;;
;;
;; Clojure
;;
;;

;; Simple Values - Literals
;; Expressions that evaluate to themselves.
42             ;; => 42 integer
1.13           ;; => 1.13 decimal
1/3            ;; => 1/3 ratio
2/1            ;; => 2
"jam"          ;; => "jam" string
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



;;
;; Data Collections
;; Clojure has lists, vectors, maps and sets
;;

;;
;; Lists - collections of things in a given order
;;
;; can mix and match values
;; commas or white space are used to separate items
'(1 2 "jam" :marmalade-jar)  ;; => (1 2 "jam" :marmalade-jar)
'(1, 2, "jam", :bee)         ;; => (1 2 :jam :bee)


;; List functions

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

;;
;; Vectors - a list with indexes
;;
[:jar1 2 3 :jar2]

;; vectors also support first and rest
(first [:jar1 1 2 3 :jar2])   ;; => :jar1
(rest [:jar1 1 2 3 :jar2])    ;; => (1 2 3 :jar2)

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
