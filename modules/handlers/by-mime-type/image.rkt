#lang racket

(provide handle-image)

(require "../_base.rkt"
         "../_params.rkt"
         racket/date)

(define (handle-entry params)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [output-landing-pages (p-output-landing-pages params)]
         [output-landing-page (format "~a/~a" output-landing-pages "index.html")]
         [safe (path->dothtml asset-rel-file)]
         [date-str (date->string (current-date) #t)])
    (display-to-file
     (string-append
      "<div class='element__item image' data-category='image'><a href='#'><img src='"
      (path->string asset-rel-file)
      "'></a></div>")
     (format "~a/~a" output-entry safe)
     #:mode 'text
     #:exists 'replace)))

(define (handle-image params)
  (printf "\tHandler=[image], params: ~a\n" (p->string params))
  (asset-landing-page params)
  (handle-entry params))
