#lang racket

(provide handle-markdown)

(require "../_base.rkt"
         "../_params.rkt"
         "../../../lib/hoedown.rkt")


(define (lp params)
  (let* ([markdown-file (p-asset-path params)]
        [markdown-str (file->string markdown-file)]
        [html (markdown markdown-str)])
    (let ([landing-page-dir (p-landing-page-dir params)])
      (display-to-file
       html
       (format "~a/~a" landing-page-dir "index.html")
       #:mode 'text
       #:exists 'replace))
    ; instead of using asset-landing-page in _base, we just do it here...
    ;(asset-landing-page params html)
    ))

(define (handle-markdown params)
  (printf "Handler=[markdown], params: ~a\n" (p->string params))
  (lp params)
  (asset-entry params))
