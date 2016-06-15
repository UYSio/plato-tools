#lang racket

(provide cfg)

; configuration
(define cfg (make-hash))
(dict-set! cfg 'input-roots '("LOC1" "LOC2"))
(dict-set! cfg 'output-root "OUT_ROOT")
(dict-set! cfg 'output-entries "OUT_ENTRIES")
(dict-set! cfg 'skip ".plato-skip")
(dict-set! cfg 'ignore '(".git"))
