    adduser --system --group --no-create-home nomad
    mkdir -p /var/run/nomad
    chown nomad:nomad /var/run/nomad
