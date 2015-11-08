#lang racket

(provide handle-markdown)

(require "../_base.rkt"
         "../_params.rkt"
         "../../../lib/hoedown.rkt")

(define (lp2 markdown front-matter)
  (printf "MD: ~a\n" markdown)
  (printf "FM: ~a\n" front-matter))

; Given, e.g. "layout: post" or "layout:post"
; returns '("layout" "post")
(define (parse-front-matter-item line)
  (cdr (regexp-match #rx"^(.*): ?(.*)$" line)))

(define (parse-front-matter markdown-file)
  (let ([lines (file->lines markdown-file)]
        [front-matter (make-hash)]
        [markdown '()]
        ; front-matter is at top, so start with is-content? #f
        [is-content? #f])
    (for ([line lines]
          #:unless (and (equal? line "---")
                        (set! is-content? #t)))
      (if is-content?
          ; TODO foldl the markdown
          (set! markdown (append markdown (list line)))
          (let ([fm (parse-front-matter-item line)])
            (dict-set! front-matter (first fm) (second fm)))))
    (lp2 markdown front-matter)))

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
  ;(lp params)
  (let ([markdown-file (p-asset-path params)])
    (parse-front-matter markdown-file))
  (asset-entry params))
