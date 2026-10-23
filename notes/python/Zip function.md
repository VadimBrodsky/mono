Combining iterable objects such as: [[Lists]], [[Tuples]], [[Python/Strings|Strings]] using a [[Python/Built in functions]]
```python
list1 = [1, 2, 3]
list2 = [10, 20, 30]

zip(list1, list2)                # returns an iterable zip object
list(zip("abc", list1, list2))   # returns an list object
```