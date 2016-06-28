#lang racket

(provide handle-landing-page)

(require "../../_params.rkt")

(define (handle-landing-page params html)
  (let ([output-landing-pages (p-output-landing-pages params)])
    (display-to-file
     (string-append
      (file->string "static/templates/markdown/header.html")
      "<!-- modules/handlers/by-file-extension/markdown/_landingpage.rkt -->"
      html
      (file->string "static/templates/markdown/footer.html"))
     (format "~a/~a" output-landing-pages "index.html")
     #:mode 'text
     #:exists 'replace)))
