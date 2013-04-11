SHA module

```racket
 (require aws)
```

Provides a Racket interface to the OpenSSL implementation of SHA-1 and
SHA-2.

SHA-2 includes four flavors: SHA-224, SHA-256, SHA-384, and SHA-512.

# 1. SHA

```racket
(sha1 bstr) -> sha1?    
  bstr : bytes?         
(sha224 bstr) -> sha224?
  bstr : bytes?         
(sha256 bstr) -> sha256?
  bstr : bytes?         
(sha384 bstr) -> sha384?
  bstr : bytes?         
(sha512 bstr) -> sha512?
  bstr : bytes?         
```

Calculate the SHA hash of `bstr`.

# 2. HMAC-SHA

```racket
(hmac-sha1 key data) -> sha1?    
  key : bytes?                   
  data : bytes?                  
(hmac-sha224 key data) -> sha224?
  key : bytes?                   
  data : bytes?                  
(hmac-sha256 key data) -> sha256?
  key : bytes?                   
  data : bytes?                  
(hmac-sha384 key data) -> sha384?
  key : bytes?                   
  data : bytes?                  
(hmac-sha512 key data) -> sha512?
  key : bytes?                   
  data : bytes?                  
```

HMAC-SHA encode `key` and `data`.

# 3. Hex string

```racket
(bytes->hex-string bstr) -> string?
  bstr : bytes?                    
```

Convert `bstr` to a hexadecimal string represention.

# 4. Predicates for contracts

```racket
(sha1? x) -> boolean?
  x : any/c          
```

Is `x` a `bytes?` of length 20?

```racket
(sha224? x) -> boolean?
  x : any/c            
```

Is `x` a `bytes?` of length 28?

```racket
(sha256? x) -> boolean?
  x : any/c            
```

Is `x` a `bytes?` of length 32?

```racket
(sha384? x) -> boolean?
  x : any/c            
```

Is `x` a `bytes?` of length 48?

```racket
(sha512? x) -> boolean?
  x : any/c            
```

Is `x` a `bytes?` of length 64?
