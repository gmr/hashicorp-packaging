dist/ubuntu/consul-replicate_${CONSUL_REPLICATE_VERSION}-${CONSUL_REPLICATE_ITERATION}_${ARCH}.deb:
	@( echo "Building consul-replicate ${CONSUL_REPLICATE_VERSION} package" )
	@( mkdir -p build/ubuntu/consul-replicate/usr/sbin )
	@( cp -R ubuntu/templates/consul-replicate/* build/ubuntu/consul-replicate/ )
	@( cp downloads/consul-replicate build/ubuntu/consul-replicate/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/consul-replicate \
				--package dist/ubuntu/consul-replicate_${CONSUL_REPLICATE_VERSION}-${CONSUL_REPLICATE_ITERATION}_${ARCH}.deb \
				--name consul-replicate --version ${CONSUL_REPLICATE_VERSION} --iteration ${CONSUL_REPLICATE_ITERATION} \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--before-install ubuntu/scripts/consul-replicate/before-install.sh \
				--deb-changelog ubuntu/changes/consul-replicate \
				--deb-default build/ubuntu/consul-replicate/etc/default/consul-replicate \
				--deb-systemd ubuntu/systemd/consul-replicate \
				--deb-upstart ubuntu/upstart/consul-replicate \
				--provides consul-replicate \
				--deb-recommends consul \
				--url https://github.com/hashicorp/consul-replicate \
				--description "Consul cross-DC KV replication daemon" . )
