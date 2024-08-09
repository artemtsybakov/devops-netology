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
variable "default_zone_develop_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vpc_subnet_name_develop_a" {
  type = string
  default = "develop-ru-central1-a"
}
variable "vpc_subnet_name_develop_b" {
  type = string
  default = "develop-ru-central1-b"
}
variable "default_cidr_develop_a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "default_cidr_develop_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
### template_file "cloudinit"
variable "username" {
  type = string
}
variable ssh_public_key {
  type        = string
  description = "Location of SSH public key."
}
