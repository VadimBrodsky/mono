## Lists
Like arrays, every object in a list can be a different type
```python
letters = ["a", "b", "c"]
list_of_lists = [[0, 1], [2, 3]]
```
Can use arithmetic operators on lists
```python
[0] * 100                  # creates a list of 100 zeros
[1, 2, 3] + ['a', 'b']     # combines lists
```
Can convert any iterable to a list
```python
list(range(20))           # list with items from 0 to 19
list("Hello World")       # list of the chars in the string
```
The `len` function is useful to get the length of a list
```python
len(list("Hello World"))  # 11
```
List operations
```python
letters = ["a", "b", "c", "d"]
letters[0] = "A"      # overrides the item in the first index
letters[0:3]          # returns a list with the first 3 items of the original list
letters[:]            # returns a copy of the list, first and last are defaulted
letters[::2]          # using a step of 2, returns a new list with everty second item
letters[::-1]         # step of -1, all items in reverse order
letters[-3:]          # last 3 items
```
Unpacking lists
-  the number of variables needs to equal the number of items in the list
- or use the `*` operator to pack the other items into a separate list
```python
numbers = [1, 2, 3]
first, second, third = numbers   # assigns the items of the list to the variables
head, *tail = numbers            # tail is a second list with the rest of the items
first, *other, last = numbers    # first and last, and other list
```
Looping over lists
```python
letters = ['a', 'b', 'c']
for letter in letters:
    print(letter)
```
To get the index as well, use the `enumerate` function, to convert to an enumerate object
- returns a tuple of the index and the value
```python
letters = ['a', 'b', 'c']
for letter in enumeratre(letters):
    print(letter)   # (0, 'a') on the first iteration

# or a cleaner way with unpacking
for index, letter in enumerate(letters):
    print(index, letter)
```
### List Methods
- `append()` - to add at the end of a list
- `insert()` - to add at a specific location
- `pop()` - to remove, defaults to last but accepts an index
- `remove()` - removes by value, first match only
- `index()` - find the index of an item, but returns an error if not found
- `count()` - the number of occurrences that an item exists in the list
- `sort()` - sorts a lists, modifies the existing list, to avoid that use the build-in `sorted()`
### Built-In Iterable Methods
- `del` - statement can be used on lists to remove one or more items
- `min()` - built-in function, returns the smallest item in an iterable
- `max()` - returns the largest item in an iterable
- `sum()` - returns the sum of an iterable numbers
- [[Python/Map function]]
- [[Python/Filter function]]
- [[Python/Zip function]]
```python
letters = ["a", "b", "c"]
letters.append("d")     # adds "d' at the end
letters.insert(0, "-")  # adds "-" at the beginnig, or at any other index
```
remove
```python
letters.pop()           # removes last
letters.pop(0)          # removes the first
letters.remove("b")     # removes the first "b"
del letters[0:3]        # removes a range of items
letters.clear()         # removes all items
```
find
```python
letters.count("d")      # number of times "d" exists
if "d" in letters:
    letters.index("d")  # the index of the letter "d", errors otherwise
```
sorting
```python
numbers = [1, 51, 2, 8, 6]
numbers.sort()                 # default sort, in ascending order
number.sort(reverse=True)      # sort in descending order
sorted(numbers)                # sorts any iterable
sorted(numbers, reverse=True)  # sorts any iterable, reversed
```
custom sort
```python
items = [
    ("Product1", 10),
    ("Product2", 9),
    ("Product3", 12),
]

# deterime how to get the key from the tuple
def sort_item(item):
    return item[1]
	

# pass the key function reference
items.sort(key=sort_item)

# or an inline lambda param:return
items.sort(key=lambda item:item[1])
```
[[List Comprehension]]
