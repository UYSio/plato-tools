#lang racket

#|
Runs after 'scan', and collates the entries in
cfg.output-entries into a home listing page.
|#

(require
         "_home.rkt"
         "_static.rkt")

(provide collate)

(define (collate cfg)
  (printf "\n[2] Collating...\n")
  (let* ([output-root (dict-ref cfg 'output-root)]
         [output-entries (dict-ref cfg 'output-entries)])
    (refresh-home output-root output-entries)
    (refresh-static output-root)))
