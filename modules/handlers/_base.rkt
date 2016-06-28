#lang racket

(provide handle-landing-page asset-entry path->dothtml strip-outpath)

(require xml)
(require "_params.rkt")

(define (write-html filename xexpr)
  (define out (open-output-file filename #:exists 'replace))
  (write-xexpr xexpr out)
  (close-output-port out))

;; turns a path /a/b/c.ext into a file name
;; like a_b_c.ext.html
(define (path->dothtml path)
  (let ([path-str (path->string path)])
    (string-append (string-replace path-str "/" "-") ".html")))

(define (handle-landing-page params html)
  (let ([output-landing-pages (p-output-landing-pages params)])
    (display-to-file
     (string-append
      (file->string "static/templates/markdown/header.html")
      "<!-- modules/handlers/by-mime-type/image/_landingpage.rkt -->"
      html
      (file->string "static/templates/markdown/footer.html"))
     (format "~a/~a" output-landing-pages "index.html")
     #:mode 'text
     #:exists 'replace)))

(define (asset-entry params)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [safe (path->dothtml asset-rel-file)])
    (write-html (format "~a/~a" output-entry safe) `(div (p ,safe)))))

;; strips '/tmp/plato/out/' from '/tmp/plato/out/pages/2015/my-content.html'
(define (strip-outpath path params)
  (let [[base (p-output-root params)]]
    (path->string (find-relative-path base path))))
