---
title: "Select All Elements with data-testid"
tags: ["dom", "javascript"]
created: "20220316140637016"
modified: "20220316141530274"
---

Useful to find all elements that can be targeted in tests:

```javascript
document.querySelectorAll('*[data-testid]')
```

Object keyed by testid:

```javascript
Array.from(document.querySelectorAll('*[data-testid]')).reduce((acc, el) => {acc[el.dataset.testid] = el; return acc;}, {})
```
