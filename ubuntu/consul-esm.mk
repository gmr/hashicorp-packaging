dist/ubuntu/consul-esm_${CONSUL_ESM_VERSION}-${CONSUL_ESM_ITERATION}_${ARCH}.deb:
	@( echo "Building consul-esm ${CONSUL_ESM_VERSION} package" )
	@( mkdir -p build/ubuntu/consul-esm/usr/sbin )
	@( cp -R ubuntu/templates/consul-esm/* build/ubuntu/consul-esm/ )
	@( cp downloads/consul-esm build/ubuntu/consul-esm/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/consul-esm \
				--package dist/ubuntu/consul-esm_${CONSUL_ESM_VERSION}-${CONSUL_ESM_ITERATION}_${ARCH}.deb \
				--name consul-esm --version ${CONSUL_ESM_VERSION} --iteration ${CONSUL_ESM_ITERATION} \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--before-install ubuntu/scripts/consul-esm/before-install.sh \
				--config-files etc/consul-esm.d/00-default.hcl \
				--deb-changelog ubuntu/changes/consul-esm \
				--deb-default build/ubuntu/consul-esm/etc/default/consul-esm \
				--deb-systemd ubuntu/systemd/consul-esm \
				--deb-upstart ubuntu/upstart/consul-esm \
				--provides consul-esm \
				--deb-recommends consul \
				--url https://github.com/hashicorp/consul-esm \
				--description "External service monitoring for Consul" . )
