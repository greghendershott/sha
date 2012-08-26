Racket support for SHA-1 and SHA-2
==================================

Starting point: Racket's `web-server/stuffers/hmac-sha1` and `file/sha1`.

Uses the approach of delegating to OpenSSL via Racket's FFI.

Adds the four SHA-2 algorithms: SHA-224, SHA-256, SHA-384, SHA-512.

