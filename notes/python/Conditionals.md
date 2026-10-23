## Conditionals
Using whitespace for code blocks
```python
if age >= 18:
    print(‘adult’)
elif age >= 13:
    print(‘teen’)
else:
    print(‘child’)
```
Python does not allow empty if blocks, the `pass` keyword is used to noop
```python
if x > 1:
    pass
else:
    pass
```
Python supports ternary operations by using inline `if` statement:
```python
message = “Eligible” if age >= 18 else “Not eligible”
```