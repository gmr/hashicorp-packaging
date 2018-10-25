dist/ubuntu/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb:
	@( echo "Building envconsul ${ENVCONSUL_VERSION} package" )
	@( mkdir -p build/ubuntu/envconsul/usr/sbin )
	@( cp -R ubuntu/templates/envconsul/* build/ubuntu/envconsul/ )
	@( cp downloads/envconsul build/ubuntu/envconsul/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/envconsul \
				--package dist/ubuntu/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb \
				--name envconsul --version ${ENVCONSUL_VERSION} --iteration ${ENVCONSUL_ITERATION} \
				--deb-changelog ubuntu/changes/envconsul \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--config-files etc/envconsul.d/00-default.hcl \
				--deb-default build/ubuntu/envconsul/etc/default/envconsul \
				--deb-systemd ubuntu/systemd/envconsul \
				--deb-upstart ubuntu/upstart/envconsul \
				--provides envconsul \
				--deb-recommends consul \
				--deb-suggests vault \
				--url https://github.com/hashicorp/envconsul \
				--description "Read and set environmental variables for processes from Consul" . )
