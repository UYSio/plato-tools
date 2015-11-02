#lang racket

(provide handle-image)

(require "../_base.rkt"
         "../_params.rkt")

(define (handle-image params)
  (printf "Handler=[image], params: ~a\n" (p->string params))
  (asset-landing-page params)
  (asset-entry params))
