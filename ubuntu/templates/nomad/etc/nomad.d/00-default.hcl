bind_addr = "0.0.0.0" # the default
data_dir  = "/var/lib/nomad"

server {
  enabled          = true
  bootstrap_expect = 3
}

consul {
  address = "127.0.0.1:8500"
}
