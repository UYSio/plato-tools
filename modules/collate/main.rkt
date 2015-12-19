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
         [output-home-page (format "~a/~a" output-root "index.html")]
         [output-entries (dict-ref cfg 'output-entries)])
    (refresh-home output-home-page output-entries)
    (refresh-static output-root)))
