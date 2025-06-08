variable "key_name" {
  type    = string
  default = "jjo-key" // <- reemplazar por el nombre de tu keypair
}

variable "pg_postgres_password" {
  type    = string
  default = "My_sUp3rS3cr3t0" // for testing, don't reuse!
}
variable "pg_n8n_password" {
  type    = string
  default = "My_sUp3rCl4v3" // for testing, don't reuse!
}

variable "n8n_encryption_key" {
  type    = string
  default = "MwbvcURM2UYc++au32WgtAW12VVCLFYY" // for testing, don't reuse!
}
