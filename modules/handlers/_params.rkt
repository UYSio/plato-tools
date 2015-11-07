#lang racket

; _params.rkt split out from base.rkt because
; the struct is used by the dispatcher, and the dispatcher
; doesn't need to see the stuff in base.

;; TODO can struct accessors be auto provided?
(provide p p->string p-asset-root p-rel-dir p-mime-type p-asset-path p-landing-page-dir p-entry-dir)

;; TODO check if mime-type can be set with auto-value if #f
(struct p (asset-root rel-dir mime-type asset-path landing-page-dir entry-dir))

(define (p->string params)
  (format
   "asset-root=[~a], rel-dir=[~a], mime-type=[~a], asset-path=[~a], landing-page-dir=[~a], entry-dir=[~a]"
   (p-asset-root params)
   (p-rel-dir params)
   (p-mime-type params)
   (p-asset-path params)
   (p-landing-page-dir params)
   (p-entry-dir params)))
