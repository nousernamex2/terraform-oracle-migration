output "public_ip" {
  value = format("%s/%s", "Seems that ec2 was created with IP: ", module.compute.instance_public_ip)
}