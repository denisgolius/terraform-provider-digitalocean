provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
}

resource "digitalocean_droplet" "pdbs" {
  # Obtain your ssh_key id number via your account. See Document https://developers.digitalocean.com/documentation/v2/#list-all-keys
  ssh_keys           = [12345678]         # Key example
  image              = "${var.ubuntu1804}"
  region             = "${var.do_fra1}"
  size               = "s-2vcpu-4gb"
  private_networking = true
  backups            = false
  ipv6               = true
  name               = "pdbs-fr"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "cd /tmp",
      "wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb",
      "sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb",
      "sudo percona-release setup ps80",
      "service apparmor stop",
      "service apparmor teardown",
      "/usr/sbin/update-rc.d -f apparmor remove",
      "sudo update-rc.d -f apparmor remove",
      "sudo apt-get install percona-server-server"
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}

resource "digitalocean_domain" "pdbs" {
  name       = "www.mywebserver.com"
  ip_address = "${digitalocean_droplet.mywebserver.ipv4_address}"
}

resource "digitalocean_record" "pdbs" {
  domain = "${digitalocean_domain.mywebserver.name}"
  type   = "A"
  name   = "pdbs"
  value  = "${digitalocean_droplet.mywebserver.ipv4_address}"
}
