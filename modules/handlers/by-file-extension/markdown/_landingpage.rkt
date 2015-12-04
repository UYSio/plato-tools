#lang racket

(provide handle-landing-page)

(require "../../_params.rkt")

(define (handle-landing-page params html)
  (let ([landing-page-dir (p-landing-page-dir params)])
    (display-to-file
     (string-append
      (file->string "templates/header.html")
      html
      (file->string "templates/footer.html"))
     (format "~a/~a" landing-page-dir "index.html")
     #:mode 'text
     #:exists 'replace)))
