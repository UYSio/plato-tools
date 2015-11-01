#lang racket

(define plato-opts (make-hash))

(hash-set!
 plato-opts
 'locs
 '("/home/opyate/Documents/stuff" "/home/opyate/Documents/stuff2"))

(provide plato-opts)
