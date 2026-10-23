## Variables
- Python has function scope and file scope
- There is no block scope, for example in conditionals or loops
- To define a global variable within a function scope use the `global var_name` declaration, but this is undesirable
```python
student_count = 1000    # int
rating = 4.99           # float
is_published = False    # bool
course_name = “Python”  # str
x, y = 1, 2             # multiple assignment
x = y = 3
age: int = 20           # type annotation of int
l = [1,2,3]             # list
```
