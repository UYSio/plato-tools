#lang racket

(require xml)

(provide dispatch-content)

(define (dispatch-content content-root path out-dir)
  (define sub (string-replace (path->string path) content-root ""))
  (define safe (string-replace sub "/" "_"))
  (define out (open-output-file
               (format "~a/data~a.html" out-dir safe)
               #:exists 'replace))
  (write-xexpr `(div
                 (p
                  ,safe))
               out)
  (close-output-port out))
