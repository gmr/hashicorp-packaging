    adduser --system --group --no-create-home consul
    mkdir -p /var/run/consul /var/lib/consul
    chown -R consul:consul /var/run/consul /var/lib/consul
