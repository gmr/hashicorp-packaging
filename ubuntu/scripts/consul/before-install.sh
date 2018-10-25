    adduser --system --group --no-create-home consul
    mkdir -p /var/run/consul
    chown consul:consul /var/run/consul
