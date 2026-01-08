# Falco Alert - Shell spawned in a Container

## Detection
Falco alert indicates a shell was started inside a container.

## Impact
Possible interactive intrusion or suspicious activity.

## Triage
- Identify namespace/pod/container
- Check the workload
- Inspect recent pod activities
- Check app logs

## Containment
Delete the affected pod or scale down the workload to terminate the session and prevent further activities stop from spreading.

## Eradication
- Remove Shells/tools from images where possible.
- Enforce more strict Policies ( OPA).
- Tighten RBAC.

## Recovery
- Redeploy a clean image 
- Monitor Falco alerts for recurrence

## Post incident
- Document how access happened
- Improve detection rules or security controls