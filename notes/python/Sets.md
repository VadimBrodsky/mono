Like lists but of unique items
- Sets are defined with `set()`, or using the literal `{}`
- They are unordered and items cannot be accessed using an index
```python
numbers = [1, 1, 2, 3, 3, 4]
uniques = set(numbers)

letters = {"a", "b", "c"}

letters.add("d")
letters.remove("a")
len(letters)
```
Sets are useful for unions
```python
first = {1, 2, 3}
second = {1, 5}

union = first | second                 # {1, 2, 3, 4, 5} first or second set
intersection = first & second          # {1} both in first and second set
difference = first - second            # {2, 3, 4} in first but not in second
symmetric_difference = first ^ second  # {2, 3, 4, 5} first or second but not both
```
Can use the `in` operator to check for inclusion
```python
if 1 in first:
    print("yes")
```