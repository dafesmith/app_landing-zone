resource "cloudflare_record" "this_txt" {
  zone_id = var.zone_id     # cloudflare zone id for app service custom domain
  name    = var.record_name # Provide name for the record
  type    = var.record_type # Type of record  "TXT" or "A" (cname)

  value = var.value #If "TXT" type value is custom domain verification id of custom domain, if "A" type value then public ip address' id used on app gwy

  #depends_on = [azurerm_windows_web_app.loop]    # existence of web app (app service)
}

resource "time_sleep" "this_sleep_time" {
  depends_on      = [cloudflare_record.this_txt]
  create_duration = var.sleep_time_in_seconds
}