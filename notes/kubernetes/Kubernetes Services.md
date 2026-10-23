Scaling and rollouts create massive IP churn and demonstrate why you should never connect directly to any Pod. This is where Services come to the rescue by providing a stable and reliable endpoint for groups of unreliable Pods.
## Service Objects
Every service get its own 
- stable IP address 
- its own stable DNS name 
- its won stable port

Services use labels and selectors to dynamically select pods they send traffic to. Services fronts the Pods and load-balances traffic to Pods with the right labels.

Think of Services as having a static front-end and a dynamic back-end. The front-end consist of the IP, DNS name, and port that never changes. The back-end the list of healthy Pods and be constantly changing.
