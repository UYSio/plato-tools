#lang racket

; _params.rkt split out from base.rkt because
; the struct is used by the dispatcher, and the dispatcher
; doesn't need to see the stuff in base.

;; TODO can struct accessors be auto provided?
(provide p p->string p-mime-type p-content-root p-asset-path p-out-dir)

;; TODO check if mime-type can be set with auto-value if #f
(struct p (mime-type content-root asset-path out-dir))

(define (p->string params)
  (format
   "mime-type=[~a], content-root=[~a], asset-path=[~a], out-dir=[~a]"
   (p-mime-type params)
   (p-content-root params)
   (p-asset-path params)
   (p-out-dir params)))
