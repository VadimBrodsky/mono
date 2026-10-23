These pods have no special abilities like self-healing, scaling or rolling updates. 

They are managed and monitored by the worker node’s `kubelet` process which is limited to attempting in restarts on the local worker node.  If the worker node fails there is no control-plane process watching and capable of staring a new one on a different node. 