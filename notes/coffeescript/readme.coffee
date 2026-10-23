###

CoffeeScript


Install globally
npm install -g coffee-script

Compile a file
coffee --compile my-script.coffee
###


# a comment

###
  A multiline comment
###

# All variables are local, CS adds a var statment
myVariable = 'test'

# To create a global variable, append to the global object
exports = this
exports.myVariable = 'foo'

# Functions
# The last expression in the function returned implicitly
func = -> 'bar'

func = ->
  # multiline function
  'bar'

# arguments are passed in parentheses before the arrow
times = (a, b) -> a * b

# functions accept default arguments
times = (a = 1, b = 2) -> a * b

# and splats for multiple arguments
sum = (num...) ->
  # num is actual array
  result = 0
  num.forEach (n) -> result += n
  result

trigger = (events...) ->
  events.splice(1, 0, this)
  this.constructor.trigger.apply(events)

# Function invocation
# invoked with (), apply() and call()
# automatically invoke a function with at least 1 argument
alert a             # same as alert(a)
alert inspect a     # same as alert(insepct(a))
alert inspect(a)    # is clearer

# Function context
# the fat arrow => function bind the context to local
# like jQuery proxy() or ES5 bind()
this.clickHandler = -> alert 'clicked'
element.addEventListener 'click', (e) => this.clickHandler(e)


# Object Literals and Arrays
# Objects
object1 = {one: 1, two: 2}       # like JS
object2 = one: 1, two: 2         # without braces
object3 =                        # new lines instead of commas
  one: 1
  two: 2

User.create(name: "John Smith")  # implicit object

# Arrays
array1 = [1, 2, 3]               # like JS
array2 = [                       # new lines instead of commas
  1
  2
  3
]
array3 = [1,2,3,]               # trailing comma is ignored


## Flow Control
if true == true                 # parentheses are optional
  'All Good'

if true != true then 'Problem'  # one line

if 1 > 0 then 'Ok' else 'Y2K'   # if else on one line

alert 'its cold' if heat < 5    # suffix if statement

if not true then 'problem'      # same as !not

unless true                     # if not, can't be on a single line
  'problem'

if true is 1                    # is keyword, strict equality ===
  'super equal ==='

if true isnt true               # isnt keyword, string inequality !==
  'problem'

true == true                    # CS translates == to strict ===
true != false                   # CS translates != to strict !==


## String Interpolation
# Similar syntax to Ruby
color = 'red'
"Roses are #{color}"

"Multi
line
strings
"

## Loops and Comprehension
for name in ['Ned', 'Rober', 'Rhaegar']
  alert "#{name} is the king!"

for name, i in ['Arya', 'Sansa']     # i as index
  alert "Stark daughter number #{i} is #{name}"

# on one line with postfix
release prisoners for prisoner in ['Tyrion', 'Davos']

# filter though comprehensions
prisoners = ['Tyrion', 'Davos', 'Ned']
release prisoners for prisoner in prisoners when prisoner[0] is 'T'

# iterate over object properties
lords = stark: 'Eddard', lanniester: 'Tywin'
alert("#{house} #{name}") for house, name of lords

# only low-level loop is while
# it returns an array of results like map()
num = 6
minstrel = while num =- 1
  num + ' Brave Sir Robin ran away'


## Arrays
# CS adds ranges, useful when working with array
range1 = [1..5]        # in js [1, 2, 3, 4, 5]
range2 = [1...5]       # in js [1, 2, 3, 4]

# If a range is specified after a variable, CS converts it to slice()
firstTwo = ['one', 'two', 'three'][0..1]

# replace array segments with another array
numbers = [0..9]
numbers[3..5] = [3, 2, 4]

# slice also works on strings
my = 'hello world'[0..2]

# checking if value exists in an array
words = ['rattled', 'rowdy', 'rebels', 'ranks']
alert 'found!' if 'rebels' in words


## Aliases and Existential Operator
# @ is an alias for this
@king = true                         # in JS this.king = true

# :: is an alias for prototype
User::first = -> @records[0]         # in JS User.prototype.first

# ? is an alias for emptiness, like Ruby's nil?
# true unless a variable if null or undefined
king unless oldKing?

# can use ? instead of ||
power = dragons ? army

# can use ? to check for null before accessing a property
# Like Active Support try
kingslayer.hadHand()?.fight()

# can use ? to check if a property is a function and callable
# if the property does not exist, or isn't a function it won't get called
kingslayer.hasHand().fight?()



