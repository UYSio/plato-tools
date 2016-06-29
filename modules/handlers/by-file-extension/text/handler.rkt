#lang racket

#|
Parses Markdown in 2 phases:
1) extract front-matter (the meta data)
2) extract bottom-matter (the stuff to become HTML)

Then another 2 steps:
1) Turns bottom-matter into HTML via 'handle-landing-page'
2) Turns meta-data into an entry via 'handle-entry'
|#

(provide handle-text)

(require "../../_base.rkt"
         "../../_params.rkt"
         "../../../../lib/hoedown.rkt"
         "_entry.rkt")

(define (handle params)
  (let* ([the-file (p-asset-path params)]
         [parsed (file->string the-file)])

    ;; landing page
    (handle-landing-page params parsed)

    ;; entry
    (handle-entry params parsed)))

(define (handle-text params)
  (printf "\tHandler=[text], params: ~a\n" (p->string params))
  (handle params))
