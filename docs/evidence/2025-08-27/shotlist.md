\# Evidence Pack — Policy as Code (Azure)



\- \[x] \*\*00-terraform-apply.png\*\* — Terminal tail of `terraform apply` showing custom policy \*definitions\* created and \*assignments\* applied.

\- \[x] \*\*01-policy-definitions.png\*\* — Policy → \*\*Definitions\*\*: the three custom policies (Allowed Locations, Append CostCenter, Deploy diag to LAW).

\- \[x] \*\*02-assignment-allowed-locations.png\*\* — Policy → \*\*Assignments\*\*: Allowed Locations assignment (scope + parameters show allowed regions).

\- \[x] \*\*03-assignment-append-costcenter.png\*\* — Assignment details for the \*\*Modify\*\* policy (location + managed identity + parameters).

\- \[x] \*\*04-assignment-storage-diag.png\*\* — Assignment details for \*\*DeployIfNotExists\*\* (LAW parameter + location + managed identity).

\- \[x] \*\*05-deny-westus-cli.png\*\* — CLI creation in disallowed region fails (Deny effect evidence).

\- \[x] \*\*06-deny-westus-activity-log.png\*\* — Activity Log entry for the policy denial (governance/audit trail proof).

\- \[x] \*\*07-append-costcenter-tags.png\*\* — Resource Group \*\*Tags\*\* blade showing `CostCenter: Unknown` automatically appended (Modify effect).

\- \[x] \*\*08-dine-noncompliant-list.png\*\* — Policy → \*\*Compliance\*\* list: storage account flagged \*\*NonCompliant\*\* \*before\* remediation.

\- \[x] \*\*09a-remediation-deployments.png\*\* — Policy → \*\*Remediation\*\* → Deployments: `PolicyDeployment\_\*` entries created by remediation.

\- \[x] \*\*09b-arm-deployment-details.png\*\* — RG → \*\*Deployments\*\* → `PolicyDeployment\_\*`: ARM deployment succeeded and created diagnostic setting.

\- \[x] \*\*09-remediation-task.png\*\* — Policy → \*\*Remediation\*\* task details showing \*\*Status: Completed\*\* and remediated resource count.

\- \[x] \*\*10-storage-diag-now-configured.png\*\* — Storage account → \*\*Diagnostic settings\*\*: `send-to-law` configured to your Log Analytics workspace (outcome proof).

\- \[x] \*\*11-assignment-identity-roles.png\*\* — CLI role assignments for the policy assignment identity (Monitoring Contributor @ sub, LA Contributor @ workspace, Contributor @ RG).

\- \[x] \*\*11-policy-compliance-is-compliant.png\*\* — Policy → \*\*Compliance\*\* shows the previously noncompliant storage account now \*\*Compliant\*\* (before/after close).





“Deployed custom policies with Terraform; enforced regions (Deny), auto-tagged RGs (Modify), and remediated Storage diagnostics to LAW (DINE) via managed identity with least-privilege RBAC. Evidence includes definitions, assignments, denial events, remediation task + ARM deployment, diagnostic settings on the resource, and compliance flip.”



