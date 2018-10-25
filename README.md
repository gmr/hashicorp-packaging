HashiCorp Packaging
===================
Makefile and templates for creating deb packages for [HashiCorp](https://www.hashicorp.com)
(and ecosystem) projects.

Uses [fpm](https://github.com/jordansissel/fpm) for building the packages and a Docker image to build them in.

Packages built
--------------

- consul
- consul-esm
- consul-replicate
- consul-template
- envconsul
- nomad
- packer
- terraform
- vault

Usage
-----

```bash
docker run --rm -t -i -v `pwd`:/build gavinmroy/hashicorp-packaging:ubuntu
```

Edit the ``Makefile`` to change the version or architecture of the packages.
