#lang racket/base

;; Starting point: web-server/stuffers/hmac-sha1 and file/sha1.
;;
;; Uses the approach of delegating to OpenSSL via FFI.
;;
;; Adds the four SHA-2 algorithms: SHA-224, SHA-256, SHA-384, SHA-512.
;;
;; TO-DO: Add SHA-3 after finalized ("late 2012"?).

(require (for-syntax racket/base
                     racket/syntax
                     syntax/parse)
         (rename-in ffi/unsafe (-> f->))
         (only-in file/sha1
                  bytes->hex-string)
         openssl/libcrypto
         racket/contract)

(provide bytes->hex-string) ;Supplying a bytes? -> string? contract
                            ;would add ~13% overhead -- so don't.

(define/contract (get-sha sym bytes-len)
  (-> symbol? exact-positive-integer? (-> bytes? bytes?))
  (unless libcrypto
    (error sym "libcrypto could not load"))
  (get-ffi-obj sym libcrypto
               (_fun [data : _bytes]
                     [data_len : _int = (bytes-length data)]
                     [md : (_bytes o bytes-len)]
                     f-> _bytes
                     f-> (make-sized-byte-string md bytes-len))))

(define/contract (get-hmac-sha sym evp-sym bytes-len)
  (-> symbol? symbol? exact-positive-integer? (-> bytes? bytes? bytes?))
  (unless libcrypto
    (error sym "libcrypto could not load"))
  (define evp (get-ffi-obj evp-sym libcrypto (_fun f-> _fpointer)))
  (get-ffi-obj 'HMAC libcrypto
               (_fun [EVP_MD : _fpointer = (evp)]
                     [key : _bytes]
                     [key_len : _int = (bytes-length key)]
                     [data : _bytes]
                     [data_len : _int = (bytes-length data)]
                     [md : (_bytes o bytes-len)]
                     [md_len : (_ptr o _uint)]
                     f-> _bytes
                     f-> (make-sized-byte-string md bytes-len))))

;; Given a SHA number like `256`, define and provide three functions:
;; 1. Predicate e.g. `sha256?`.
;; 2. Hash e.g. `sha256`.
;; 3. HMAC encoder e.g. `hmac-sha256`.
(define-syntax (define-sha stx)
  (syntax-parse stx
    [(_ num:exact-positive-integer)
     (let ([n (syntax-e #'num)])
       (with-syntax ([pred-id (format-id stx "sha~a?"     n #:source #'num)]
                     [hash-id (format-id stx "sha~a"      n #:source #'num)]
                     [hmac-id (format-id stx "hmac-sha~a" n #:source #'num)]
                     [len     (if (= n 1) 20 (/ n 8))]
                     [ssl-sym (string->symbol (format "SHA~a" n))]
                     [evp-sym (string->symbol (format "EVP_sha~a" n))])
         #`(begin
             (define (pred-id x) (and (bytes? x) (= (bytes-length x) len)))
             (define hash-id (get-sha 'ssl-sym len))
             (define hmac-id (get-hmac-sha 'ssl-sym 'evp-sym len))
             (provide
              (contract-out [pred-id (-> any/c boolean?)]
                            [hash-id (-> bytes? pred-id)]
                            [hmac-id (-> bytes? bytes? pred-id)])))))]))

(define-sha   1)
(define-sha 224)
(define-sha 256)
(define-sha 384)
(define-sha 512)

(module+ test
  (require rackunit)

  (test-case
   "sha"
   (check-equal? (bytes->hex-string (sha1 #""))
                 "da39a3ee5e6b4b0d3255bfef95601890afd80709")
   (check-equal? (bytes->hex-string (sha224 #""))
                 "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
   (check-equal? (bytes->hex-string (sha256 #""))
                 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
   (check-equal? (bytes->hex-string (sha384 #""))
                 "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
   (check-equal? (bytes->hex-string (sha512 #""))
                 "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"))

  (test-case
   "hmac-sha"
   ;; Expected values from Python's HMAC implmentation, e.g.
   ;;   import hmac
   ;;   import hashlib
   ;;   hmac.new('', '', hashlib.sha512).hexdigest()
   (check-equal? (bytes->hex-string (hmac-sha1 #"" #""))
                 "fbdb1d1b18aa6c08324b7d64b71fb76370690e1d")
   (check-equal? (bytes->hex-string (hmac-sha224 #"" #""))
                 "5ce14f72894662213e2748d2a6ba234b74263910cedde2f5a9271524")
   (check-equal? (bytes->hex-string (hmac-sha256 #"" #""))
                 "b613679a0814d9ec772f95d778c35fc5ff1697c493715653c6c712144292c5ad")
   (check-equal? (bytes->hex-string (hmac-sha384 #"" #""))
                 "6c1f2ee938fad2e24bd91298474382ca218c75db3d83e114b3d4367776d14d3551289e75e8209cd4b792302840234adc")
   (check-equal? (bytes->hex-string (hmac-sha512 #"" #""))
                 "b936cee86c9f87aa5d3c6f2e84cb5a4239a5fe50480a6ec66b70ab5b1f4ac6730c6c515421b327ec1d69402e53dfb49ad7381eb067b338fd7b0cb22247225d47")))
