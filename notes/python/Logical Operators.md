## Logical Operators
Python has the normal logical and numeric operators
- `==`, `!=`, `<`, `>`, `>=`, `<=`
- `and`
- `or`
- `not`
```python
# Empty string is a Falsy value in Python
if not name:
    print(“Name is empty”)
```
Python allows to chain logical operators
```python
if age >= 18 and age < 65:
    print(“Eligible”)
    
# with logical chaining
if 18 <= age < 65:
    print(“Eligible”)
```

## Loops
Python has 2 types of loops
1. `for` loops
2. `while` loops

The `range()` is very useful for number iteration.
- Accepts start, end, and step
- Does not return a list bur rather a `range` object
```python
# iteration over a string
for x in “Python”:
    print(x)
    
# iteratino over a list
for x in [‘a’, ‘b’, ‘c’]:
    print(x)
    
# iterate over numbers
for x in range(5):
    print(x)
    
# can also specify a startng, ending and step
for x in range(0, 10, 2):
  print(x)
```
- Loops can stop iteration, using the `break` keyword
- Loops can also have `else` blocks if the loop ends without a `break` call
```python
names = [“John”, “Rob”]
for name in names:
    if name.startswith(“J”)
        print(“Found”)
        break
else:
    print(“Not found”)
```
While loops
```python
gues, answer = 0, 5
while answer != guess:
    guess = int(input(“Guess: “))
else:
    # executes if the while loop executes without a break
    pass
```