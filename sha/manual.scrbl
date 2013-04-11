#lang scribble/manual

@(require (for-label racket))

@defmodule[aws]

Provides a Racket interface to the OpenSSL implementation of SHA-1 and SHA-2.

SHA-2 includes four flavors: SHA-224, SHA-256, SHA-384, and SHA-512.


@section{SHA}

@deftogether[(

@defproc[(sha1 [bstr bytes?]) sha1?]
@defproc[(sha224 [bstr bytes?]) sha224?]
@defproc[(sha256 [bstr bytes?]) sha256?]
@defproc[(sha384 [bstr bytes?]) sha384?]
@defproc[(sha512 [bstr bytes?]) sha512?]

)]{

Calculate the SHA hash of @racket[bstr].

}


@section{HMAC-SHA}

@deftogether[(

@defproc[(hmac-sha1 [key bytes?][data bytes?]) sha1?]
@defproc[(hmac-sha224 [key bytes?][data bytes?]) sha224?]
@defproc[(hmac-sha256 [key bytes?][data bytes?]) sha256?]
@defproc[(hmac-sha384 [key bytes?][data bytes?]) sha384?]
@defproc[(hmac-sha512 [key bytes?][data bytes?]) sha512?]

)]{

HMAC-SHA encode @racket[key] and @racket[data].

}


@section{Hex string}

@defproc[(bytes->hex-string [bstr bytes?]) string?]{

Convert @racket[bstr] to a hexadecimal string represention.

}


@section{Predicates for contracts}

@defproc[(sha1? [x any/c]) boolean?]{

Is @racket[x] a @racket[bytes?] of length 20?

}

@defproc[(sha224? [x any/c]) boolean?]{

Is @racket[x] a @racket[bytes?] of length 28?

}

@defproc[(sha256? [x any/c]) boolean?]{

Is @racket[x] a @racket[bytes?] of length 32?

}

@defproc[(sha384? [x any/c]) boolean?]{

Is @racket[x] a @racket[bytes?] of length 48?

}

@defproc[(sha512? [x any/c]) boolean?]{

Is @racket[x] a @racket[bytes?] of length 64?

}
