resource "null_resource" "ansible-provision" {

  provisioner "local-exec" {
    command =  "echo \"[${aws_instance.lb.tags.Name}]\n${aws_instance.lb.public_ip}\" > hosts"
  }
  provisioner "local-exec" {
    command =  "echo \"[${aws_instance.app1.tags.Name}]\n${aws_instance.app1.public_ip}\" >> hosts"
  }
  provisioner "local-exec" {
    command =  "echo \"[${aws_instance.app2.tags.Name}]\n${aws_instance.app2.public_ip}\" >> hosts"
  }
  provisioner "local-exec" {
    command =  "echo \"[${aws_instance.app3.tags.Name}]\n${aws_instance.app3.public_ip}\" >> hosts"
  }
  provisioner "local-exec" {
    command =  "echo \"[${aws_instance.db1.tags.Name}]\n${aws_instance.db1.public_ip}\" >> hosts"
  }
}
