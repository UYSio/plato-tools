#lang racket

(provide handle-image)

(require "../_base.rkt"
         "../_params.rkt"
         "_resize.rkt"
         racket/date)


(define (handle-entry params local-asset pages-rel-file output-entry safe)

  ;; copy the image
  (copy-file
   (p-asset-path params)
   local-asset
   #t)

  ;; thumb for stream of consciousness
  (let* [[file-name (file-name-from-path local-asset)]
         [path (path-only local-asset)]
         [thumb-file (string-append "t." (path->string file-name))]
         [thumb (string-append (path->string path) thumb-file)]]
    (copy-file
     (p-asset-path params)
     thumb
     #t)
    (resize thumb)

    ;; entry
    (display-to-file
     (string-append
      "<div class='el image' data-category='image'><a href='"
      (strip-outpath local-asset params)
      "'><img src='"
      (strip-outpath thumb params)

      "'></a></div>")
     (format "~a/~a" output-entry safe)
     #:mode 'text
     #:exists 'replace)))

(define (handle params)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [pages-rel-file (string-append
                          "pages/"
                          (path->string asset-rel-file))]
         [output-landing-pages (p-output-landing-pages params)]
         [output-landing-page (format "~a/~a" output-landing-pages "index.html")]
         [safe (path->dothtml asset-rel-file)]
         [date-str (date->string (current-date) #t)]
         [local-asset (string-append output-landing-pages "/" (path->string (file-name-from-path asset-rel-file)))])
    ;; landing page
    (handle-landing-page params "cioming soon")

    ;; entry
    ;; TODO clean up arguments below
    (handle-entry params local-asset pages-rel-file output-entry safe)
  ))

(define (handle-image params)
  (printf "\tHandler=[image], params: ~a\n" (p->string params))
  (handle params))
