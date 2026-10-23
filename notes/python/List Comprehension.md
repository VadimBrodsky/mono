List comprehension, iterating over an iterable and applying an expression on each item
- can be cleaner to read as compared to mapping
- can be more performant than mapping
```python
items = [
    ("Product1", 10),
    ("Product2", 9),
    ("Product3", 12),
]

# same as mapping to get the prices
prices = [item[1] for item in items]

# same as filtering to get prices over 10
filtered = [item for item in items if item[1] >= 10]
```

```python
squares = [value**2 for value in range(1, 11)]
```