variable "host" {
  type = object({
    hostname = string
    domain   = string
  })
  description = "Identification of the machine to be backed. Any non-alphanumeric, non-hyphen characters will be replaced with hyphens."
}

variable "key_capabilities" {
  type        = list(string)
  description = "The capabilities to grant to the application key."
  default = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readFiles",
    "shareFiles",
    "writeFiles",
  ]
}
