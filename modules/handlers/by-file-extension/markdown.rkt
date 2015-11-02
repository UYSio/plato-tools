#lang racket

(provide handle-markdown)

(require "../_base.rkt"
         "../_params.rkt")

(define (handle-markdown params)
  (printf "Handler=[markdown], params: ~a\n" (p->string params))
  (asset-landing-page params)
  (asset-entry params))
