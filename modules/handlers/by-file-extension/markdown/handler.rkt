#lang racket

#|
Parses Markdown in 2 phases:
1) extract front-matter (the meta data)
2) extract bottom-matter (the stuff to become HTML)

Then another 2 steps:
1) Turns bottom-matter into HTML via 'handle-landing-page'
2) Turns meta-data into an entry via 'handle-entry'
|#

(provide handle-markdown)

(require "../../_base.rkt"
         "../../_params.rkt"
         "../../../../lib/hoedown.rkt"
         "_parser.rkt"
         "_landingpage.rkt"
         "_entry.rkt")

(define (handle params)
  (let* ([markdown-file (p-asset-path params)]
         [parsed (parse markdown-file)]
         [markdown-str (first parsed)]
         [front-matter (second parsed)]
         [html (markdown markdown-str)])

    ;; landing page
    (handle-landing-page params html)

    ;; entry
    (handle-entry params front-matter)))

(define (handle-markdown params)
  (printf "\tHandler=[markdown], params: ~a\n" (p->string params))
  (handle params))
