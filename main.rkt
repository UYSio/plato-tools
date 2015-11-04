#lang racket

#|
Ensures config is sane, then sends
it off to the scanner.
|#

(require racket/path
         "scan.rkt"
         (file "~/.plato/config.rkt"))

;; send all assets to dispatcher
(define (main config)

  ;; ensure directories in config exists
  (for ([path-atom '(landing-page-dir entries-dir)])
    (let ([path (dict-ref cfg path-atom)])
      (make-directory* (string->path path))))

  (scan config))

(main cfg)
