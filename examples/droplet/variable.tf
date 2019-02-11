# ####

# Current Available Datacenter Regions

# As of 11-02-2018

#

variable "do_ams2" {
  description = "Digital Ocean Amsterdam Data Center 2"
  default     = "ams2"
}

variable "do_ams3" {
  description = "Digital Ocean Amsterdam Data Center 3"
  default     = "ams3"
}

variable "do_fra1" {
  description = "Digital Ocean Frankfurt Data Center 1"
  default     = "fra1"
}

variable "do_lon1" {
  description = "Digital Ocean London Data Center 1"
  default     = "lon1"
}

# Default Os

variable "ubuntu1604" {
  description = "Default 16.04 LTS"
  default     = "ubuntu-16-04-x64"
}

variable "ubuntu1804" {
  description = "Default 18.04 LTS"
  default     = "ubuntu-18-04-x64"
}

variable "ubuntu1810" {
  description = "Default LTS"
  default     = "ubuntu-18-10-x64"
}
