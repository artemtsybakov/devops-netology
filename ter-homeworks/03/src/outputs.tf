output "vm_info" {
  value = concat(local.output_count-vm, local.output_for_each-vm, local.output_storage)
}