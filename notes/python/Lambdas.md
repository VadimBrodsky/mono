Anonymous functions, defined as `parameters:expression`

```python
def sort_item(item):
    return item[1]
	

# sort key parameter is defined a named function
items.sort(key=sort_item)

# sort key parameter is defined as a lambda
items.sort(key=lambda item:item[1])
```