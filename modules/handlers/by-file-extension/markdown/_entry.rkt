#lang racket

(provide handle-entry)

(require "../../_base.rkt"
         "../../_params.rkt"
         racket/date)

(define (handle-entry params front-matter)
  (let* ([entry-dir (p-entry-dir params)]
         [asset-rel-file (p-asset-rel-file params)]
         [safe (path->dothtml asset-rel-file)]
         [date-str (date->string (current-date) #t)])
    (display-to-file
     (string-append
      "<div class='element__item element__item--width2 element__item--height2 wwlf' data-category='wwlf'>
            <h3 class='title'>" (hash-ref front-matter "title") "</h3>
            <p class='description'>" (hash-ref front-matter "description") "</p>
            <p class='category'>" (hash-ref front-matter "category") "</p>
            <p class='tags'>" (hash-ref front-matter "tags") "</p>
            <p class='date'>" date-str "</p>
        </div>")
     (format "~a/~a" entry-dir safe)
     #:mode 'text
     #:exists 'replace)))
