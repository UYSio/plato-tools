#lang racket

(provide just-copy)

(require "../_base.rkt"
         "../_params.rkt")


(define (handle-entry params local-asset pages-rel-file output-entry safe)

  ;; copy the image
  (copy-file
   (p-asset-path params)
   local-asset
   #t))

(define (handle params)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [pages-rel-file (string-append
                          "pages/"
                          (path->string asset-rel-file))]
         [output-landing-pages (p-output-landing-pages params)]
         [output-landing-page (format "~a/~a" output-landing-pages "index.html")]
         [safe (path->dothtml asset-rel-file)]
         [local-asset (string-append output-landing-pages "/" (path->string (file-name-from-path asset-rel-file)))])
    (handle-entry params local-asset pages-rel-file output-entry safe)
  ))

(define (just-copy params)
  (printf "\tHandler=[just-copy], params: ~a\n" (p->string params))
  (handle params))
