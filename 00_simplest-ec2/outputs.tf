# since we're using dynamic addressing we shoudl define and output
# for the instance IP see https://www.terraform.io/docs/configuration/outputs.html
output "private_ip" {
  value = "${aws_instance.terraform_test.private_ip}"
}

output "public_ip" {
  value = "${aws_instance.terraform_test.public_ip}"
}
