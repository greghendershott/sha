#lang racket/base

;; ffi/unsafe's make-sized-byte-string always throws an exception on
;; Racket on Chez. Have to copy the bytes instead. Copying is slower.
;; So keep using make-sized-byte-string on versions of Racket where
;; it doesn't always raise an exception (i.e. do a quick test here).

(require ffi/unsafe)

(provide compatible-make-sized-byte-string)

(define (copy-to-byte-string cptr len)
  (define v (make-bytes len 0))
  (memcpy v cptr len)
  v)

(define compatible-make-sized-byte-string
  (with-handlers ([exn:fail? (λ _ copy-to-byte-string)])
    (make-sized-byte-string #"0" 1)
    make-sized-byte-string))
