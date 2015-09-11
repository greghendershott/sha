[![Build Status](https://travis-ci.org/greghendershott/sha.png?branch=master)](https://travis-ci.org/greghendershott/sha)
[![raco pkg install sha](https://img.shields.io/badge/Racket_Package-raco_pkg_install_sha-blue.svg)](http:pkgs.racket-lang.org/#[sha])


# Racket support for SHA-1 and SHA-2

Starting point: Racket's `web-server/stuffers/hmac-sha1` and `file/sha1`.

Uses the approach of delegating to OpenSSL via Racket's FFI.

Adds the four SHA-2 algorithms: SHA-224, SHA-256, SHA-384, SHA-512.

[Documentation](https://github.com/greghendershott/sha/blob/master/sha/manual.md).

