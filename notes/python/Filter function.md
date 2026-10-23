Built in `filter()` class, returns an iterator yielding those items of iterable for which function is true.
```python
items = [
    ("Product1", 10),
    ("Product2", 9),
    ("Product3", 12),
]

filtered_list = list(filter(lambda item: item[1]) >= 10, items))
print(filtered_list)
```