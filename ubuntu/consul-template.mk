dist/ubuntu/consul-template_${CONSUL_TEMPLATE_VERSION}-${CONSUL_TEMPLATE_ITERATION}_${ARCH}.deb:
	@( echo "Building consul-template ${CONSUL_TEMPLATE_VERSION} package" )
	@( mkdir -p build/ubuntu/consul-template/usr/sbin )
	@( cp -R ubuntu/templates/consul-template/* build/ubuntu/consul-template/ )
	@( cp downloads/consul-template build/ubuntu/consul-template/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/consul-template \
				--name consul-template --version ${CONSUL_TEMPLATE_VERSION} --iteration ${CONSUL_TEMPLATE_ITERATION} \
				--package dist/ubuntu/consul-template_${CONSUL_TEMPLATE_VERSION}-${CONSUL_TEMPLATE_ITERATION}_${ARCH}.deb \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--deb-no-default-config-files \
				--deb-changelog ubuntu/changes/consul-template \
				--config-files etc/consul-template.d/00-default.hcl \
				--deb-default build/ubuntu/consul-template/etc/default/consul-template \
				--deb-systemd ubuntu/systemd/consul-template \
				--deb-upstart ubuntu/upstart/consul-template \
				--provides consul-template \
				--deb-recommends consul \
				--deb-suggests vault \
				--url https://github.com/hashicorp/consul-template \
				--description "Generic template rendering and notifications with Consul" . )
