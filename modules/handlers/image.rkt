#lang racket

(provide handle-image)

(require "../common.rkt"
         "_params.rkt")

;; TODO define
; asset-landing-page    - the main index.html for the asset


;; the below s-expr is  quite generic.
;; what we really want from a handler is to just spit out HTML (xexpr)
;; and do the necessary post-production (so to speak) to get the assets in
;; a serve-able form, i.e. photos retouched, and uploaded to S3,
;; videos equalised and uploaded to S3, etc

(define (asset-listing-snippet
         content-root
         asset-path
         out-dir)
  (printf "Rendering snippet for ~a\n" asset-path)
  (let* ([relative-asset-path (get-relative-asset-path content-root asset-path)]
         [safe (path->dothtml relative-asset-path)])
    (write-html (format "~a/snippets/~a" out-dir safe) `(div (p ,safe)))))

;; TODO all handlers should be passed two things:
;; a struct of params: like mime-type, config, asset-path etc
;; a writer - the writer will know where to put generated content.
;; The handler should only concern itself with a particular rendetion of
;; something, and the writer will know where to put it.
(define (handle-image params)
  (printf "Handler received params: ~a\n" (p->string params))
  (let ([content-root (p-content-root params)]
        [asset-path (p-asset-path params)]
        [out-dir (p-out-dir params)])
    (asset-listing-snippet content-root asset-path out-dir)))
