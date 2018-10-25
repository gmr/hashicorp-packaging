dist/ubuntu/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb:
	@( echo "Building terraform ${TERRAFORM_VERSION} package" )
	@( mkdir -p build/ubuntu/terraform/usr/bin )
	@( cp downloads/terraform build/ubuntu/terraform/usr/bin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/terraform \
				--package dist/ubuntu/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb \
				--name terraform --version ${TERRAFORM_VERSION} --iteration ${TERRAFORM_ITERATION} \
				--deb-changelog ubuntu/changes/terraform \
				--deb-no-default-config-files \
				--no-depends \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--provides terraform \
				--url https://www.terraform.io \
				--description "A tool for building, changing, and combining infrastructure safely and efficiently." . )
