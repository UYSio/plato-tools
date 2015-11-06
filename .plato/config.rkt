#lang racket

(provide cfg)

; configuration
(define cfg (make-hash))
(dict-set! cfg 'asset-roots '("/home/opyate/Documents/stuff/" "/home/opyate/Documents/stuff2"))
(dict-set! cfg 'landing-page-dir "/tmp/out/pages")
(dict-set! cfg 'entries-dir "/tmp/out/entries")
(dict-set! cfg 'skip ".plato-skip")
(dict-set! cfg 'ignore '(".git"))
