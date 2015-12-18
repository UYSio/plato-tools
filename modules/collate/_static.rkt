#lang racket

(require racket/path)

(provide refresh-static)

(define (refresh out dir)
  ; remove stale assets
  (delete-directory/files
   (format "~a/~a" out dir)
   #:must-exist? #f)
  ; copy assets
  (copy-directory/files
   (format "static/templates/homepage/~a" dir)
   (format "~a/~a" out dir)))

; refresh static assets
(define (refresh-static output-root)
  (refresh output-root "js")
  (refresh output-root "css"))
