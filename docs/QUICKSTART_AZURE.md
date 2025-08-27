\# Quickstart (Azure)



\## Prereqs

\- Azure subscription + Owner or Policy Contributor at subscription scope

\- Azure CLI (`az`), Terraform

\- Optional: Terraform Cloud/Enterprise for Sentinel



\## Steps

1\. `az login` and `az account set --subscription "<SUB\_ID>"`

2\. `pwsh ./docs/QUICKSTART\_WINDOWS.ps1 -SubscriptionId "<SUB\_ID>" -ApprovedRegions "eastus","centralus"`

3\. In Azure Portal → \*\*Policy\*\*:

&nbsp;  - Confirm definitions exist (Custom)

&nbsp;  - Confirm assignments applied at subscription scope

4\. Test:

&nbsp;  - Try to deploy a resource in `westus` → should \*\*Deny\*\*

&nbsp;  - Create storage without diag settings → Policy will mark non-compliant and (with `DeployIfNotExists`) remediate if configured

5\. Evidence:

&nbsp;  - Policy compliance export (Portal → Policy → Compliance → Export)

&nbsp;  - Screenshots of denied deployment / initiative compliance



\## Sentinel (Terraform Cloud)

\- Create a TFC organization \& workspace

\- Connect this repo

\- Add a \*\*Sentinel Policy Set\*\* and include `sentinel/enforce-tags.sentinel`

\- Trigger a plan with untagged resources → run should fail

\- Re-run with tags → pass



