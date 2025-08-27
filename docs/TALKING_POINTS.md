\# Talking Points learned from lab work



\*\*Azure Policy vs Sentinel\*\*

\- Azure Policy: enforcement \*\*in Azure\*\* at/after resource creation; JSON effects: Deny/Audit/Append/DeployIfNotExists

\- Sentinel: enforcement \*\*before\*\* infra is applied (Terraform plan/apply gate). Defense-in-depth when combined.



\*\*Deny vs Audit\*\*

\- Deny blocks; Audit flags. Typical rollout is Audit > Deny after impact assessment.



\*\*DeployIfNotExists\*\*

\- Triggers a remediation task to deploy missing config (e.g., diagnostic settings). Requires a remediation role assignment.



\*\*Common Controls\*\*

\- Encryption at rest (CMK for Storage/SQL), RBAC least privilege, network restrictions (NSGs/firewalls), logging/diagnostics to Log Analytics, Key Vault for secrets.



\*\*CSPM\*\*

\- Continuous posture (Secure Score, recommendations). Azure-native is Defender for Cloud; third party adds multi-cloud breadth.



\*\*Evidence\*\*

\- Short doc per control: control → policy/initiative → assignment → compliance export/screenshots → frequency.



