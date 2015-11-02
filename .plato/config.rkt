#lang racket

(define plato-opts (make-hash))

(hash-set!
 plato-opts
 'asset-roots
 '("/home/opyate/Documents/stuff/" "/home/opyate/Documents/stuff2"))

(hash-set!
 plato-opts
 'landing-page-dir
 "out/pages")

(hash-set!
 plato-opts
 'entries-dir
 "out/entries")


(provide plato-opts)
