The Ambassador pattern is another variation of the [[Sidecar pattern]]. This time the helper container brokers connectivity to an external system.

For example the main application container can just dump its output to a port the ambassador container is listening on and sit back while the ambassador container does all the hard work of getting it to the external system.