[![CI](https://github.com/greghendershott/sha/workflows/CI/badge.svg)](https://github.com/greghendershott/sha/actions)
[![raco pkg install sha](https://img.shields.io/badge/raco_pkg_install-sha-aa00ff.svg)](https://pkgs.racket-lang.org/package/sha)
[![Documentation](https://img.shields.io/badge/read-documentation-blue.svg)](https://pkg-build.racket-lang.org/doc/sha@sha/index.html)
![BSD License](https://img.shields.io/badge/license-BSD-green)


# Racket support for SHA-1 and SHA-2

Starting point: Racket's `web-server/stuffers/hmac-sha1` and `file/sha1`.

Uses the approach of delegating to OpenSSL via Racket's FFI.

Adds the four SHA-2 algorithms: SHA-224, SHA-256, SHA-384, SHA-512.
