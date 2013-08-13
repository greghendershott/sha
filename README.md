# Racket support for SHA-1 and SHA-2

[![Build Status](https://travis-ci.org/greghendershott/sha.png?branch=master)](https://travis-ci.org/greghendershott/sha)

Starting point: Racket's `web-server/stuffers/hmac-sha1` and `file/sha1`.

Uses the approach of delegating to OpenSSL via Racket's FFI.

Adds the four SHA-2 algorithms: SHA-224, SHA-256, SHA-384, SHA-512.

[Documentation](https://github.com/greghendershott/sha/blob/master/sha/manual.md).

