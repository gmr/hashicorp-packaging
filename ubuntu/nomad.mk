dist/ubuntu/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb:
	@( echo "Building nomad ${NOMAD_VERSION} package" )
	@( mkdir -p build/ubuntu/nomad/usr/sbin )
	@( cp -R ubuntu/templates/nomad/* build/ubuntu/nomad/ )
	@( cp downloads/nomad build/ubuntu/nomad/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/nomad \
				--package dist/ubuntu/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb \
				--name nomad --version ${NOMAD_VERSION} --iteration ${NOMAD_ITERATION} \
				--deb-changelog ubuntu/changes/nomad \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--before-install ubuntu/scripts/nomad/before-install.sh \
  			--config-files etc/nomad.d/00-default.hcl \
				--deb-default build/ubuntu/nomad/etc/default/nomad \
				--deb-systemd ubuntu/systemd/nomad \
				--deb-upstart ubuntu/upstart/nomad \
				--provides nomad \
				--deb-recommends consul \
				--deb-suggests vault \
				--url https://www.nomadproject.io \
				--description "Easily Deploy Applications at Any Scale" . )
