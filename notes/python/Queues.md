FIFO using the [[deque]] module
```python
from collections import deque

queue = dequeue([])  # create a queue

queue.append(1)      # add to the queue
queue.append(2)
queue.append(3)

queue.popleft()      # pop first item out

if not queue:        # empty [] is Falsy
    print("Empty")
```