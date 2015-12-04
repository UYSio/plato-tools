#lang racket

(provide handle-entry)

(require "../../_base.rkt"
         "../../_params.rkt")

(define (handle-entry params front-matter)
  (let* ([entry-dir (p-entry-dir params)]
         [asset-rel-file (p-asset-rel-file params)]
         [safe (path->dothtml asset-rel-file)])
    (display-to-file
     (string-append
      "<div class='element__item element__item--width2 element__item--height2 wwlf' data-category='wwlf'>
            <h3 class='name'>WWLF</h3>
            <p class='symbol'>Ar</p>
            <p class='number'>18</p>
            <p class='date'>2016-03-22T07:24:28+01:00</p>
        </div>")
     (format "~a/~a" entry-dir safe)
     #:mode 'text
     #:exists 'replace)))
