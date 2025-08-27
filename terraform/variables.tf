variable "subscription_id" {
  type        = string
  description = "Target subscription ID for policy assignment."
}

variable "approved_regions" {
  type        = list(string)
  default     = ["eastus"]
  description = "Regions allowed by the Allowed Locations policy."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = ""
  description = "Resource ID of Log Analytics workspace (needed for DeployIfNotExists)."
}
