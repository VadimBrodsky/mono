# Loops in C
Loops allow for some code to be repeated until some condition becomes false, of some counter
elapses.

There are 2 main loops in C
1. `while` loop - repeatedly executes a block of code until some condition becomes false.
2. `for` loop - requires three expressions separated by semicolons

While loop:

```c
int = 10;
while (i > 0) {
  puts("Loop Iteration");
  i = i - 1;
}
```

For loop:

```c
for (int i = 0; i < 10; i++) {
  puts("Loop Iteration");
}
```
