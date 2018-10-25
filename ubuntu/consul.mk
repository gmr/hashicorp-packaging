dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb:
	@( echo "Building consul ${CONSUL_VERSION} package" )
	@( mkdir -p build/ubuntu/consul/usr/sbin build/ubuntu/consul/var/run/consul )
	@( cp -R ubuntu/templates/consul/* build/ubuntu/consul/ )
	@( cp downloads/consul build/ubuntu/consul/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/consul \
				--package dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb \
				--name consul --version ${CONSUL_VERSION} --iteration ${CONSUL_ITERATION} \
				--deb-changelog ubuntu/changes/consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--before-install ubuntu/scripts/consul/before-install.sh \
				--deb-no-default-config-files \
				--config-files etc/consul.d/00-consul.json \
				--deb-default build/ubuntu/consul/etc/default/consul \
				--deb-systemd ubuntu/systemd/consul \
				--deb-upstart ubuntu/upstart/consul \
				--provides consul \
				--url https://consul.io \
				--description "Consul is a tool for service discovery, monitoring and configuration" . )
