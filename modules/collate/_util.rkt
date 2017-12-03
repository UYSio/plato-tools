#lang racket

(provide make-all make-one make-header make-footer make-entries make-link)

(define (make-all page entries)
  (make-header page)
  (make-entries page entries)
  (make-footer page))

(define (make-one page entries next)
  (make-header page)
  (make-entries page entries)
  (make-link page next)
  (make-footer page))

(define (make-header page)
  ;; overwrite output page with header
  (display-to-file
   (file->string "static/templates/homepage/header.html")
   page
   #:mode 'text
   #:exists 'replace)
  (display-to-file
   "<!-- modules/collate/_util.rkt -->"
   page
   #:mode 'text
   #:exists 'append))

(define (make-entries page entries)
  (for ([entry entries])
    (if (file-exists? entry)
        (display-to-file
         (file->string entry)
         page
         #:mode 'text
         #:exists 'append)
        #f)))

(define (make-footer page)
  (display-to-file
   (file->string "static/templates/homepage/footer.html")
   page
   #:mode 'text
   #:exists 'append))

(define (make-link page id)
  (display-to-file
   (string-append
    "<div class='el nav' data-category='nav'>"
    "<a href='"
    id
    "'>NEXT</a>"
    "</div>")
   page
   #:mode 'text
   #:exists 'append))
