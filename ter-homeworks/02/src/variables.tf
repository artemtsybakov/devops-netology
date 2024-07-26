###cloud vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}

# ###ssh vars
# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "<your_ssh_ed25519_key>"
#   description = "ssh-keygen -t ed25519"
# }

###yandex compute image
variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The name of the image family to which this image belongs."
}

###yandex_compute_instance vm_db
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Resource name."
}
variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "The type of virtual machine to create. The default is 'standard-v1'."
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "The availability zone where the virtual machine will be created. If it is not provided, the default provider folder is used."
}

variable "vm_resources" {
  type = map(object({
    web = map(object({
      cores         = number
      memory        = number
      core_fraction = number
    })),
    db = map(object({
      cores         = number
      memory        = number
      core_fraction = number
    }))
  }))
  default = {}
}
variable "metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys           = string
  }))
  default = {}
}