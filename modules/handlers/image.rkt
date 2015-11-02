#lang racket

(provide handle-image)

(require "_base.rkt"
         "_params.rkt")

(define (asset-landing-page params) #f)

(define (asset-entry params)
  (let ([content-root (p-content-root params)]
        [asset-path (p-asset-path params)]
        [out-dir (p-out-dir params)])
    (let* ([relative-asset-path (get-relative-asset-path content-root asset-path)]
           [safe (path->dothtml relative-asset-path)])
      (write-html (format "~a/snippets/~a" out-dir safe) `(div (p ,safe))))))

(define (handle-image params)
  (printf "Handler=[image], params: ~a\n" (p->string params))
  (asset-landing-page params)
  (asset-entry params))
