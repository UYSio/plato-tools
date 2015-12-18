#lang racket

(provide refresh-home)

(define (refresh-home output-home-page output-entries)
  ; overwrite home with header
  (display-to-file
   (file->string "static/templates/homepage/header.html")
   output-home-page
   #:mode 'text
   #:exists 'replace)

  ; append entries
  (for ([entry (in-directory output-entries)])
    (if (file-exists? entry)
        (display-to-file
         (file->string entry)
         output-home-page
         #:mode 'text
         #:exists 'append)
        #f))

  ; append footer
  (display-to-file
   (file->string "static/templates/homepage/footer.html")
   output-home-page
   #:mode 'text
   #:exists 'append))
