#lang racket

(provide asset-landing-page asset-entry)

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
    (string-append (string-replace path-str "/" "-") ".html"))
  )

(define (asset-landing-page params)
  (let ([asset-path (p-asset-path params)]
        [landing-page-dir (p-landing-page-dir params)])
    (write-html (format "~a/~a" landing-page-dir "index.html") `(div (p "landing page")))))

(define (asset-entry params)
  (let* ([asset-path (p-asset-path params)]
         [entry-dir (p-entry-dir params)]
         [asset-root (p-asset-root params)]
         [rel-asset-path (find-relative-path asset-root asset-path)]
         [safe (path->dothtml rel-asset-path)])
    (write-html (format "~a/~a" entry-dir safe) `(div (p ,safe)))))
