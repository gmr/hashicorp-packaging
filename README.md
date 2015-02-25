Consul Packaging
================
Makefile and templates for creating deb packages for [Consul](https://consul.io).

Uses [fpm](https://github.com/jordansissel/fpm) for building the packages and a Vagrant VM to build them in.

Packages built
--------------

- consul
- consul-webui
- consul-template
- envconsul
- consul-replicator

Usage
-----

```bash
vagrant up
vagrant ssh

cd src
make
```

Edit the ``Makefile`` to change the version or architecture of the packages.
