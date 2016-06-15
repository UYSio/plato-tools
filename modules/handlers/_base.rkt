#lang racket

(provide asset-landing-page asset-entry path->dothtml)

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

(define (asset-landing-page params)
  (let ([output-landing-pages (p-output-landing-pages params)])
    (write-html (format "~a/~a" output-landing-pages "index.html") `(div (p "TODO landing page")))))

(define (asset-entry params)
  (let* ([output-entry (p-output-entry params)]
         [asset-rel-file (p-asset-rel-file params)]
         [safe (path->dothtml asset-rel-file)])
    (write-html (format "~a/~a" output-entry safe) `(div (p ,safe)))))
