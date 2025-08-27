\# Azure Policy – Policy as Code Labs (Terraform + Sentinel + CI)



Hands-on portfolio repo for a Cloud Security Technology \& Controls Deployment Specialist:

\- Write + test Azure Policies (Deny, Append, DeployIfNotExists)

\- Deploy via Terraform (IaC)

\- Enforce guardrails with HashiCorp Sentinel (PaC)

\- Wire a CI pipeline for plan/test/apply

\- Capture CSPM evidence from Microsoft Defender for Cloud

\- Produce audit documentation



\## What’s here

\- `policies/` – three concrete policies:

&nbsp; - \*\*Allowed Locations\*\* (Deny)

&nbsp; - \*\*Require CostCenter tag\*\* (Append)

&nbsp; - \*\*DeployIfNotExists diagnostic settings on Storage\*\*

\- `terraform/` – creates policy definitions and assignments

\- `sentinel/` – example Sentinel rule: enforce “tags required”

\- `docs/` – quickstarts, CSPM lab, audit template, interview cheatsheet

\- `.github/workflows/policy-ci.yml` – GitHub Actions pipeline



\## Quick start (Windows)

1\. Install: Azure CLI, Terraform, Git.

2\. Login + select sub:

&nbsp;  ```powershell

&nbsp;  az login

&nbsp;  az account set --subscription "<YOUR\_SUBSCRIPTION\_ID>"



