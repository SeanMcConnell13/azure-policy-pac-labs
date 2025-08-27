param(
  [Parameter(Mandatory=$true)][string]$SubscriptionId,
  [string[]]$ApprovedRegions = @("eastus")
)

Write-Host "Setting subscription..." -f Cyan
az account set --subscription $SubscriptionId

# Ensure logged in
$sub = az account show --query id -o tsv
if (-not $sub) { throw "Not logged in. Run az login." }

# Initialize Terraform
Write-Host "Initializing terraform..." -f Cyan
Push-Location ./terraform
terraform init

# Create tfvars file dynamically
$regionsJson = ($ApprovedRegions | ConvertTo-Json -Compress)
@"
subscription_id = "$SubscriptionId"
approved_regions = $regionsJson
"@ | Out-File -Encoding utf8 .\local.auto.tfvars

Write-Host "Planning terraform..." -f Cyan
terraform plan

Write-Host "Applying terraform..." -f Cyan
terraform apply -auto-approve
Pop-Location

Write-Host "Done. Check Azure Policy -> Assignments for the new entries." -f Green
