# Functions in C
A function is a computation that manipulates variables and optionally changes the state of the
program. It takes as input some variables and returns some single variable as output.

Function definition:

```c
int add_together(int x, int y) {
  int result = x + y;
  return result;
}
```

Calling it:

```c
int added = add_together(10, 18);
```
