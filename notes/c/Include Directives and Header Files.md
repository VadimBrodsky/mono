---
title: "Include Directives and Header Files"
tags: ["c"]
created: "20240529140337315"
modified: "20240529141552965"
---

The `#include` statement is a [[./Preprocessor in C|preprocessor]] directive.

The effect of `#include` is the same as if you had typed the entire contents of the `stdio.h` file into your file at the point where the `#include` line appears.

```c
#include <stdio.h>
```

Header files contain information used by the compiler to build the final executable program. They may define constants to indicate the names of functions and how they should be used. The actual code for a function is in a library file of precompiled code, not in the header file.

The linker component of the compiler takes care of finding the library code you need.

The documentation for a particular C implementation should include a description of the functions in the C library.
