## Type Casting
Python is strongly typed and does not do any implicit conversions. But it has the concept of Truthy and Falsy values.
- Falsy - `“”`, `0`, `[]`, `None`
- Truthy - anything else

```python
x = input(“x: “)
int(x)     # 3
float(x)   # 3.0
bool(x)    # True
str(x)     # 3
```