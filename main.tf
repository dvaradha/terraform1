resource "google_compute_instance" "myvms" {
	zone = var.zone
	machine_type = var.machine_type
	name = "myvm${length(var.mcount)}"
	tags = ["webtag"]
	allow_stopping_for_update = true
	boot_disk {
		initialize_params {
			image = var.image
}
}
	network_interface {
		network = google_compute_network.mynet.name
		access_config {}
}
	metadata = merge (var.metadata,{ owner = "${var.metadata["env"]}varadharajan dhanasekaran" })
	metadata_startup_script = <<EOF
sudo yum install epel-release
sudo yum install -y nginx
sudo systemctl start nginx
EOF
	lifecycle {
		create_before_destroy = true
}
	provisioner "local-exec" {
		command = "echo system created from `uname -a`>>out.log"
}
}

resource "google_compute_network" "mynet" {
	name = "mynetwork"
}

resource "google_compute_firewall" "myfw" {
	name = "myfwrule"
	network = google_compute_network.mynet.name
	allow {
		protocol = "icmp"
		}
	allow {
		protocol = "tcp"
		ports = var.ports
		} 
	source_ranges = ["0.0.0.0/0"]
	target_tags = ["webtag"]
	depends_on = [google_compute_network.mynet]
}
output "instancedetails" {
	value = google_compute_network.mynet
}
