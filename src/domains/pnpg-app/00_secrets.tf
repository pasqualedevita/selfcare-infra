module "key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v5.1.0"


  resource_group = local.key_vault_resource_group
  key_vault_name = local.key_vault_name

  secrets = [
    "agid-spid-cert",
    "agid-spid-private-key",
    "appinsights-instrumentation-key",
    "aruba-sign-service-delegated-psw",
    "aruba-sign-service-delegated-user",
    "aruba-sign-service-user",
    "aws-ses-access-key-id",
    "aws-ses-secret-access-key",
    "cdn-fqdn",
    "cdn-storage-access-key",
    "cdn-storage-blob-connection-string",
    "cdn-storage-blob-primary-web-host",
    "contracts-storage-access-key",
    "eventhub-SC-Contracts-interceptor-connection-string",
    "eventhub-SC-Contracts-selfcare-wo-connection-string",
    "external-api-key",
    "external-user-api",
    "google-client-id",
    "google-client-secret",
    "infocamere-client-id",
    "infocamere-secret-certificate",
    "infocamere-secret-private-key",
    "infocamere-secret-public-key",
    "jwt-exchange-kid",
    "jwt-exchange-private-key",
    "jwt-exchange-public-key",
    "jwt-kid",
    "jwt-private-key",
    "jwt-public-key",
    "jwt-secret",
    "logs-storage-connection-string",
    "mongodb-connection-string",
    "national-registry-api-key",
    "onboarding-interceptor-apim-internal",
    "party-test-institution-email",
    "portal-admin-operator-email",
    "postgres-party-user-password",
    "redis-primary-access-key",
    "smtp-not-pec-psw",
    "smtp-not-pec-usr",
    "smtp-psw",
    "smtp-usr",
    "spid-logs-encryption-public-key",
    "user-registry-api-key",
    "user-registry-api-key",
    "web-storage-connection-string",
    "alert-pnpg-http-status-slack"
  ]
}
