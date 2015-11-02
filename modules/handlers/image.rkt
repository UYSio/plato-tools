#lang racket

(provide handle-image)

(require "_base.rkt"
         "_params.rkt")

(define (asset-landing-page params) #f)

(define (asset-entry params)
  (let ([asset-path (p-asset-path params)]
        [out-dir (p-out-dir params)])
    (let* ([safe (path->dothtml asset-path)])
      (write-html (format "~a/snippets/~a" out-dir safe) `(div (p ,safe))))))

(define (handle-image params)
  (printf "Handler=[image], params: ~a\n" (p->string params))
  (asset-landing-page params)
  (asset-entry params))
