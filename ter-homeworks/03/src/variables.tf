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
### yandex vpc network
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}
### yandex_vpc_subnet
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

###yandex compute image
variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The name of the image family to which this image belongs."
}

###yandex compute instance count-vm
variable "web_servers" {
  type    = list(string)
  default = ["web-server-1", "web-server-2"]
  description = "А variable for counting the number of servers"
}
variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    })
  )
  default = {}
}
variable "count-vm_name" {
  type = string
  default = "Web"
}

###yandex compute instance for_each-vm
variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    fraction     = number
    ram          = number
    disk_volume  = number
  }))
}

###yandex_compute_disk" "disk_vm"
variable "disk_vm_name" {
  type = string
  default = "storage"
}

variable "storage_disk" {
  type = list(number)
  description = "Quantity of disk"
}
