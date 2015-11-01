#lang racket

(provide handle-image)

(require "../writer.rkt")

;; TODO define
; asset-landing-page    - the main index.html for the asset

(define (asset-listing-snippet
         content-root
         asset-path
         out-dir)
  (printf "Rendering snippet for ~a\n" asset-path)
  (let* ([relative-asset-path (get-relative-asset-path content-root asset-path)]
         [safe (path->dothtml relative-asset-path)])
    (write-html (format "~a/snippets/~a" out-dir safe) `(div (p ,safe)))))

(define (handle-image mime-type content-root asset-path out-dir)
  (asset-listing-snippet content-root asset-path out-dir))
