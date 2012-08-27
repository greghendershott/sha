#lang setup/infotab

(define name "sha")
(define categories '(net))
(define blurb
  '("Provides a Racket interface to the OpenSSL implementation of SHA-1 and SHA-2. SHA-2 includes four flavors: SHA-224, SHA-256, SHA-384, and SHA-512."))
(define homepage "https://github.com/greghendershott/sha")

(define release-notes
  '((p "Initial release.")))
(define version "2012-08-27")
(define can-be-loaded-with 'all)

(define primary-file '("main.rkt"))
(define scribblings '(("manual.scrbl")))

(define required-core-version "5.3")
(define repositories '("4.x"))
