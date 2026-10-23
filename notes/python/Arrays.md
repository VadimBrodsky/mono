Take less memory and perform faster than lists, useful for lists of over 10k items.
- Arrays are imported from the array module
- They take a [Typecode](https://docs.python.org/3/library/array.html) when defined
- The members of the array are typed and inserting values of a different type will throw an error
```python
from array import array

numbers = array("i", [1, 2, 3])

numbers.append("4")
numbers.insert(4, "5")

numbers.pop()
numbers.remove("4")

numbers[0] = 0     # assignment works
numbers[0] = 1.0   # this throws an error as the array type is integer
```
