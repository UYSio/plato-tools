#lang racket

(provide handle-entry)

(require "../../_base.rkt"
         "../../_params.rkt"
         racket/date)

(define (handle-entry params front-matter)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [output-landing-pages (p-output-landing-pages params)]
         [output-landing-page (format "~a/~a" output-landing-pages "index.html")]
         [safe (path->dothtml asset-rel-file)]
         [date-str (date->string (current-date) #t)])
    (display-to-file
     (string-append
      "<div class='element__item wwlf' data-category='wwlf'>
            <h3 class='title'>"(hash-ref front-matter "title")
            "<a href='" output-landing-page "'>🔗</a></h3>
            <p class='description'>" (hash-ref front-matter "description") "</p>
            <p class='category'>" (hash-ref front-matter "category") "</p>
            <p class='tags'>" (hash-ref front-matter "tags") "</p>
            <p class='date'>" date-str "</p>
        </div>")
     (format "~a/~a" output-entry safe)
     #:mode 'text
     #:exists 'replace)))
