#lang racket

; _params.rkt split out from base.rkt because
; the struct is used by the dispatcher, and the dispatcher
; doesn't need to see the stuff in base.

;; TODO can struct accessors be auto provided?
(provide p p->string p-output-root p-asset-rel-file p-mime-type p-asset-path p-output-landing-pages p-output-entry p-the-date)

;; TODO check if mime-type can be set with auto-value if #f
(struct p (output-root asset-rel-file mime-type asset-path output-landing-pages output-entry the-date))

(define (p->string params)
  (format
   "output-root=[~a] asset-rel-file=[~a], mime-type=[~a], asset-path=[~a], output-landing-pages=[~a], output-entry=[~a] the-date=[~a]"
   (p-output-root params)
   (p-asset-rel-file params)
   (p-mime-type params)
   (p-asset-path params)
   (p-output-landing-pages params)
   (p-output-entry params)
   (p-the-date params)))
