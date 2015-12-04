#lang racket

(provide handle-markdown)

(require "../_base.rkt"
         "../_params.rkt"
         "../../../lib/hoedown.rkt")

; Given, e.g. "layout: post" or "layout:post"
; returns '("layout" "post")
(define (parse-front-matter-item line)
  (cdr (regexp-match #rx"^(.*): ?(.*)$" line)))

; parses out markdown-str and front-matter
(define (parse markdown-file)
  (let ([lines (file->lines markdown-file)]
        [front-matter (make-hash)]
        [markdown-list '()]
        ; front-matter is at top, so start with is-content? #f
        [is-content? #f])
    (for ([line lines]
          #:unless (and (equal? line "---")
                        (set! is-content? #t)))
      (if is-content?
          (set! markdown-list (append markdown-list (list line)))
          (let ([fm (parse-front-matter-item line)])
            (dict-set! front-matter (first fm) (second fm)))))
    (let ([markdown-str (foldl (lambda (x acc) (format "~a\n~a" acc x)) "" markdown-list)])
      (list markdown-str front-matter))))

(define (handle params)
  (let* ([markdown-file (p-asset-path params)]
         [parsed (parse markdown-file)]
         [markdown-str (first parsed)]
         [front-matter (second parsed)] ; completely ignored for now
         [html (markdown markdown-str)])
    (let ([landing-page-dir (p-landing-page-dir params)])
      (display-to-file
       (string-append
        (file->string "header.html")
        html
        (file->string "footer.html"))
       (format "~a/~a" landing-page-dir "index.html")
       #:mode 'text
       #:exists 'replace))
    ; instead of using asset-landing-page in _base, we just do it here...
    ;(asset-landing-page params html)
    ))

(define (handle-markdown params)
  (printf "Handler=[markdown], params: ~a\n" (p->string params))
  (handle params)
  (asset-entry params))
