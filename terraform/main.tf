data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

# Allowed Locations policy definition (from file)
resource "azurerm_policy_definition" "allowed_locations" {
  name         = "custom-allowed-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed locations (Custom)"
  policy_rule  = file("${path.module}/../policies/allowed-locations/definition.json")
  metadata     = jsonencode({ category = "General" })
}

# Assignment for Allowed Locations
resource "azurerm_policy_assignment" "allowed_locations_assign" {
  name                 = "assign-allowed-locations"
  display_name         = "Assign - Allowed Locations"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
  parameters           = jsonencode({ allowedLocations = { value = var.approved_regions } })
}

# Append CostCenter tag policy (definition only; assignment optional)
resource "azurerm_policy_definition" "append_costcenter" {
  name         = "custom-append-costcenter"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Append CostCenter tag if missing"
  policy_rule  = file("${path.module}/../policies/require-costcenter-append/definition.json")
  metadata     = jsonencode({ category = "Tagging" })
}

resource "azurerm_policy_assignment" "append_costcenter_assign" {
  name                 = "assign-append-costcenter"
  display_name         = "Assign - Append CostCenter"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.append_costcenter.id
  parameters = jsonencode({
    tagName  = { value = "CostCenter" }
    tagValue = { value = "Unknown" }
  })
}

# DeployIfNotExists Storage diagnostics
resource "azurerm_policy_definition" "deployifnotexists_diag_storage" {
  name         = "custom-deployifnotexists-storage-diag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Deploy diagnostic settings for Storage Accounts"
  policy_rule  = file("${path.module}/../policies/deployifnotexists-diag-storage/definition.json")
  metadata     = jsonencode({ category = "Monitoring" })
}

resource "azurerm_policy_assignment" "deployifnotexists_diag_storage_assign" {
  name                 = "assign-deployifnotexists-storage-diag"
  display_name         = "Assign - Storage diag to LA"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.deployifnotexists_diag_storage.id
  parameters = jsonencode({
    logAnalytics = { value = var.log_analytics_workspace_id }
  })
}

# Optional: grant remediation permissions at subscription scope (system-assigned identity)
# In production, you'd use a managed identity for remediation tasks.
