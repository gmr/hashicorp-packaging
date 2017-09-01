HashiCorp Packaging
===================
Makefile and templates for creating deb packages for [HashiCorp](https://www.hashicorp.com)
(and ecosystem) projects.

Uses [fpm](https://github.com/jordansissel/fpm) for building the packages and a Vagrant VM to build them in.

Packages built
--------------

- consul
- consul-replicate
- consul-template
- envconsul
- hashi-ui
- nomad
- packer
- vault

Usage
-----

```bash
vagrant up
vagrant ssh

cd src
make
```

Edit the ``Makefile`` to change the version or architecture of the packages.
