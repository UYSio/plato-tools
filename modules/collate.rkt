#lang racket

#|
Runs after 'scan', and collates the entries in
cfg.output-entries into a home listing page.
|#

(require racket/path
         "dispatch.rkt")

(provide collate)

(define (refresh out dir)
  ; remove stale assets
  (delete-directory/files
   (format "~a/~a" out dir)
   #:must-exist? #f)
  ; copy assets
  (copy-directory/files
   (format "static/templates/homepage/~a" dir)
   (format "~a/~a" out dir)))

(define (collate cfg)
  (printf "\n[2] Collating...\n")
  (let* ([output-root (dict-ref cfg 'output-root)]
         [output-home-page (format "~a/~a" output-root "index.html")]
         [output-entries (dict-ref cfg 'output-entries)])
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
     #:exists 'append)

    ; refresh static assets
    (refresh output-root "js")
    (refresh output-root "css")))
