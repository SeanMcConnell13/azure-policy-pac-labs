output "subscription_scope" {
  value       = data.azurerm_subscription.current.id
  description = "Policy assignment scope."
}
