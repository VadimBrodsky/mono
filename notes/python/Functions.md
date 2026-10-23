- Functions are defined with the `def` keyword
- Need to have 2 line breaks after a function definition
- If there is no explicit return, the function will return `None`
- Can return multiple values using brackets, this creates a Tuple (read only list)
- Keyword arguments can also be used in the function invocation for better readability
- Arguments can have default values
- Arguments and return types can have type annotations
```python
def increment(number: int, by: int = 1) -> tuple:
    return (number, number + by)
    
       
increment(2, by=3)
```
Passing arbitrary number of arguments to the functions, using `*` to convert the arguments into a tuple
```python
def multiply(*list):
    total = 1
    for number in list:
        total *= number
    return total
    
    
multiply(2, 3, 4, 5)
```
passing named parameters to a function with `**`, creates a dictionary
```python
def save_user(**user):
    print(user[“id”])
    
    
save_user(id = 1, name = “admin”)
```