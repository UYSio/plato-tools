#lang racket

(provide cfg)

; configuration
(define cfg (make-hash))
(dict-set! cfg 'input-roots '("LOC1" "LOC2"))
(dict-set! cfg 'output-root "/tmp/plato/out")
(dict-set! cfg 'output-entries "/tmp/plato/entries")
(dict-set! cfg 'skip ".plato-skip")
(dict-set! cfg 'ignore '(".git"))
