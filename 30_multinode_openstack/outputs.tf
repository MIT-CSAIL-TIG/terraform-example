# since we're using dynamic addressing we shoudl define and output
# for the instance IP see https://www.terraform.io/docs/configuration/outputs.html
output "ip" {
  value = "${openstack_compute_instance_v2.terraform_test.*.network.0.fixed_ip_v4}"
}
