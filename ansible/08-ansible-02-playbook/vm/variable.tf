###cloud variables
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

### yandex vpc variables
variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "subnet_name" {
  type    = string
  default = "clickhouse"
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

### yandex_compute_instance clickhouse
variable "vm_name" {
  type = string
}

###yandex compute image
variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The name of the image family to which this image belongs."
}

variable "username" {
  type = string
}
variable "ssh_public_key" {
  type        = string
  description = "Location of SSH public key."
}