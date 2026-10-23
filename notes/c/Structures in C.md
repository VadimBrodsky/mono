Structures in C
Structures are used to declare new types. Structures are several variables bundled together into a
single package.

We should place the structure definition above any functions that wish to use it. 

```c
typedef struct {
  float x;
  float y;
} point;
```

To access an individual field use the `.`, followed by the name of the field.

```c
point p;
p.x = 0.1;
p.y = 10.0;

float length = sqrt(p.x * p.y * p.y);
```
