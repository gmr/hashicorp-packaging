dist/ubuntu/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb:
	@( echo "Building packer ${PACKER_VERSION} package" )
	@( mkdir -p build/ubuntu/packer/usr/bin )
	@( cp downloads/packer build/ubuntu/packer/usr/bin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/packer \
				--package dist/ubuntu/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb \
				--name packer --version ${PACKER_VERSION} --iteration ${PACKER_ITERATION} \
				--deb-changelog ubuntu/changes/packer \
				--deb-no-default-config-files \
				--no-depends \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--provides packer \
				--url https://www.packer.io \
				--description "A tool for creating identical machine images for multiple platforms from a single source configuration." . )
