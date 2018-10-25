dist/ubuntu/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb:
	@( echo "Building vault ${VAULT_VERSION} package" )
	@( mkdir -p build/ubuntu/vault/usr/sbin )
	@( cp -R ubuntu/templates/vault/* build/ubuntu/vault/ )
	@( cp downloads/vault build/ubuntu/vault/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/ubuntu/vault \
				--package dist/ubuntu/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb \
				--name vault --version ${VAULT_VERSION} --iteration ${VAULT_ITERATION} \
				--deb-changelog ubuntu/changes/vault \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--before-install ubuntu/scripts/vault/before-install.sh \
				--config-files etc/vault.d/00-default.hcl \
				--deb-default build/ubuntu/vault/etc/default/vault \
				--deb-systemd ubuntu/systemd/vault \
				--deb-upstart ubuntu/upstart/vault \
				--provides vault \
				--deb-recommends consul \
				--url https://vaultproject.io \
				--description "A tool for managing secrets" . )
