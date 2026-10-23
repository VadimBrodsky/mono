Workload types such as batch jobs are designed to be short-lived and only run until a task completes. Once all containers in a short-lived Pod successfully terminate, the Pod terminates and its status is set to `successful`. 

Appropriate container restart policies for short-lived Pods will usually be:
- Never
- OnFailure

Kubernetes has controllers for short-lived workloads:
- `Jobs`
- `CronJobs`
