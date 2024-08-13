output "vpc_id" {
  value = yandex_vpc_network.develop.id
}

output "subnet_ids" {
  value = tolist(values(yandex_vpc_subnet.develop)[*].id)
}