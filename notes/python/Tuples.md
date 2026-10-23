## Tuples
Tuples are lists that do not change, immutable lists. 
- tuples are defined by the presence of a comma, the parentheses make them look neater. 
- python throws an error when a modification is attempted on a Tuple
- tuples share many operations with lists
```python
single = (3,)     # single item tuple
point = 1, 2      # also a tuple but without parenthesis
empty = ()        # empty tuple

point[0] = 10     # would throw an error, as tuples are immutable

(1, 2) + (3, 4)   # concatenation of 2 tuples
(1, 2) * 3        # multiplication of a tuple
```
The `tuple()` function is used for type conversion of any iterable
```python
point = tuple([1, 2])
word = tuple("Hello World")
```
Can also unpack tuples and uses slices to access parts of a tuple
```python
point = (1, 2, 3)
point[0:2]         # slice, also a tuple
x, y, z = point    # unpacking tuple values into vaariables

if 10 in point:    # check for item in a tuple
    print("exists)
```
swapping variables - uses tuples under the hood
```python
x = 10
y = 11

x, y = y, x       # tuple is defined and unpacked over existing variables
```