#lang racket

; _params.rkt split out from base.rkt because
; the struct is used by the dispatcher, and the dispatcher
; doesn't need to see the stuff in base.

;; TODO can struct accessors be auto provided?
(provide p p->string p-asset-rel-file p-mime-type p-asset-path p-landing-page-dir p-entry-dir)

;; TODO check if mime-type can be set with auto-value if #f
(struct p (asset-rel-file mime-type asset-path landing-page-dir entry-dir))

(define (p->string params)
  (format
   "asset-rel-file=[~a], mime-type=[~a], asset-path=[~a], landing-page-dir=[~a], entry-dir=[~a]"
   (p-asset-rel-file params)
   (p-mime-type params)
   (p-asset-path params)
   (p-landing-page-dir params)
   (p-entry-dir params)))
