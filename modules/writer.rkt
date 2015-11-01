#lang racket

(provide
 write-html
 get-relative-asset-path)

(define (write-html filename xexpr)
  (define out (open-output-file filename #:exists 'replace))
  (write-xexpr xexpr out)
  (close-output-port out))

;; given a content-root (e.g. /a/b/c)
;; given an asset-path (e.g. /a/b/c/d/asset.ext)
;; return the difference (e.g. d/asset.ext)
(define (get-relative-asset-path content-root asset-path)
  (string-replace (path->string asset-path) content-root ""))
