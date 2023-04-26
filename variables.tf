variable "storage_account_authorized_ip_ranges" {
  description = "Map of authorized CIDRs / IPs"
  type        = map(string)
}

variable "hpcc_data_plane_count" {
  type = number
}
