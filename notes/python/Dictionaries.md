Like objects in JavaScript
- immutable types for the keys - like strings
- any type for the value
```python
point = {"x": 1, "y": 2}   # defined using a literal
point = dict(x=1, y=2)     # defined using a dict() function

point["x"] = 10            # value is accessed using an index
point["z"] = 20            # new value assignment

point["a"]                 # trying to access by non-existant key throws an error
if "a" in point:
    print(point["a"])      # check for inclusion first
	
point.get("a", 9)          # would return None if it does not exist, default value is 0

del point["x"]             # deletes
```
looping over dictionaries with the for loop
```python
for key in point:
    print(key, point[key])
```
or using the `items()` method, returning a tuple of the key and value
```python
for key, value in point.items():
    print(key, value)
```