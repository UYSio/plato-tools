#lang racket

(provide handle-entry)

(require "../../_base.rkt"
         "../../_params.rkt"
         racket/date)

(define (handle-entry params content)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [out-file (p-out-file params)]
         [output-landing-pages (p-output-landing-pages params)]
         [output-landing-page (format "~a/~a" output-landing-pages out-file)]
         [safe (path->dothtml asset-rel-file)])

    (display-to-file
     (string-append
      "<div class='element__item wwsf' data-category='wwsf'>"
      "<p class='content'>" content "</p>"
      "<p class='date'>" (p-the-date params) "</p>"
      "</div>")
     (format "~a/~a" output-entry safe)
     #:mode 'text
     #:exists 'replace)))
