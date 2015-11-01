#lang racket

(define plato-opts (make-hash))

(hash-set!
 plato-opts
 'asset-locations
 '("/home/opyate/Documents/stuff" "/home/opyate/Documents/stuff2"))

(hash-set!
 plato-opts
 'out-dir
 "out")

(provide plato-opts)
