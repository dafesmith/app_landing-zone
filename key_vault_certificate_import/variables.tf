variable "cert_entry_name" { type = string }
variable "target_key_vault_id" { type = string }
variable "source_pfx_filename" { type = string }
variable "source_pfx_password" {
  type      = string
  sensitive = true
}