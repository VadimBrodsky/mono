Pods deployed via controllers have all the benefits of being monitored and managed by a highly-available controller running in the control-plane.

The local kubelet can still attempt local restarts but if the restart attempts fail or the node itself fails the observing controller can start a replacement Pod on a different worker node. 