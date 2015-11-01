#lang racket

(require xml)

(provide dispatch-asset)

(define (dispatch-asset content-root asset-path out-dir)
  (define sub (string-replace (path->string asset-path) content-root ""))
  (define safe (string-replace sub "/" "_"))
  (define out (open-output-file
               (format "~a/data~a.html" out-dir safe)
               #:exists 'replace))
  (write-xexpr `(div
                 (p
                  ,safe))
               out)
  (close-output-port out))
