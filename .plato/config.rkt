#lang racket

(provide cfg)

; configuration
(define cfg
  '((asset-roots . ("/home/opyate/Documents/stuff/" "/home/opyate/Documents/stuff2"))
    (landing-page-dir . "/tmp/out/pages")
    (entries-dir . "/tmp/out/entries")
    (ignore . ".plato-ignore")))
