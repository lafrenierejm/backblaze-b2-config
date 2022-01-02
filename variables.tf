variable "buckets" {
  type        = set(string)
  description = "B2 buckets to be created."
  validation {
    condition = alltrue([
      for bucket in var.buckets :
    can(regex("[a-z]+(-[a-z]+)*", bucket))])
    error_message = "Bucket names can only contain hyphens and lowercase Latin letters."
  }
}

variable "key_capabilities" {
  type        = set(string)
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
