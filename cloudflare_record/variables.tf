variable "zone_id" { type = string }
variable "record_name" { type = string }
variable "record_type" { type = string }
variable "value" { type = string }
variable "sleep_time_in_seconds" {
  type    = string
  default = "30s"
}
