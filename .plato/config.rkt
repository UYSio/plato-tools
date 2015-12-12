#lang racket

(provide cfg)

; configuration
(define cfg (make-hash))
(dict-set! cfg 'input-roots '("/home/opyate/Documents/stuff/" "/home/opyate/Documents/stuff2"))
(dict-set! cfg 'output-root "/tmp/plato/out")
(dict-set! cfg 'output-entries "/tmp/plato/entries")
(dict-set! cfg 'skip ".plato-skip")
(dict-set! cfg 'ignore '(".git"))
