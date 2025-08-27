


# Subscription data source

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}


# Policy: Allowed Regions

resource "azurerm_policy_definition" "allowed_locations" {
  name         = "custom-allowed-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed locations (Custom)"
  metadata     = jsonencode({ category = "General" })

  # Pull only the rule & parameters from the file (file contains ARM-style properties wrapper)
  policy_rule = jsonencode(
    jsondecode(file("${path.module}/../policies/allowed-locations/definition.json")).properties.policyRule
  )
  parameters = jsonencode(
    jsondecode(file("${path.module}/../policies/allowed-locations/definition.json")).properties.parameters
  )
}

resource "azurerm_subscription_policy_assignment" "allowed_locations_assign" {
  name                 = "assign-allowed-locations"
  display_name         = "Assign - Allowed Locations"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
  parameters           = jsonencode({ allowedLocations = { value = var.approved_regions } })
}


# Policy: Append CostCenter tag

resource "azurerm_policy_definition" "append_costcenter" {
  name         = "custom-append-costcenter"
  policy_type  = "Custom"
  mode         = "All"  
  display_name = "Add CostCenter tag (Modify)"
  metadata     = jsonencode({ category = "Tagging" })

  policy_rule = jsonencode(
    jsondecode(file("${path.module}/../policies/require-costcenter-append/definition.json")).properties.policyRule
  )
  parameters = jsonencode(
    jsondecode(file("${path.module}/../policies/require-costcenter-append/definition.json")).properties.parameters
  )
}


resource "azurerm_subscription_policy_assignment" "append_costcenter_assign" {
  name                 = "assign-append-costcenter"
  display_name         = "Assign - Append CostCenter"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.append_costcenter.id
  parameters = jsonencode({
    tagName  = { value = "CostCenter" }
    tagValue = { value = "Unknown" }
  })
  location = "eastus"
  identity { type = "SystemAssigned" }
}


# Policy: DeployIfNotExists Storage Diagnostics to LAW  #

resource "azurerm_policy_definition" "deployifnotexists_diag_storage" {
  name         = "custom-deployifnotexists-storage-diag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Deploy diagnostic settings for Storage Accounts"
  metadata     = jsonencode({ category = "Monitoring" })

  policy_rule = jsonencode(
    jsondecode(file("${path.module}/../policies/deployifnotexists-diag-storage/definition.json")).properties.policyRule
  )
  parameters = jsonencode(
    jsondecode(file("${path.module}/../policies/deployifnotexists-diag-storage/definition.json")).properties.parameters
  )
}

resource "azurerm_subscription_policy_assignment" "deployifnotexists_diag_storage_assign" {
  name                 = "assign-deployifnotexists-storage-diag"
  display_name         = "Assign - Storage diag to LA"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.deployifnotexists_diag_storage.id
  parameters           = jsonencode({ logAnalytics = { value = var.log_analytics_workspace_id } })

  # Required for DINE assignments
  location = "eastus"

  # Managed identity used for remediation
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_subscription_policy_remediation" "append_tag_remediate" {
  name                 = "remediate-append-costcenter"
  subscription_id      = data.azurerm_subscription.current.id
  policy_assignment_id = azurerm_subscription_policy_assignment.append_costcenter_assign.id
}

