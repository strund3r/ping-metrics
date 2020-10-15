resource "local_file" "ips" {
  content  = <<-EOF
    %{for ip in flatten([data.aws_instances.eks_nodes.*.private_ips])~}
    ${ip},
    %{endfor~}
  EOF
  filename = "collector/ips.txt"
}

resource "null_resource" "ping_script" {

  count = length(flatten([data.aws_instances.eks_nodes.*.public_ips]))

  provisioner "file" {
    source      = "collector/ping-collector.sh"
    destination = "~/ping-collector.sh"
  }

  provisioner "file" {
    source      = "collector/ips.txt"
    destination = "~/ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/ping-collector.sh",
      "sudo -b nohup ~/ping-collector.sh &",
      "sleep 1"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file("${path.module}/../eks.pem")
    host        = element(flatten([data.aws_instances.eks_nodes.*.public_ips]), count.index)
  }
}
