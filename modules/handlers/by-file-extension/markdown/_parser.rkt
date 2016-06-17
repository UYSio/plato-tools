#lang racket

(provide parse)

; Given, e.g. "layout: post" or "layout:post"
; returns '("layout" "post")
(define (parse-front-matter-item line)
  (cdr (regexp-match #rx"^([a-z_]+): ?(.*)$" line)))

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
            (dict-set! front-matter (first fm) (string-trim (second fm) "\"")))))
    (let ([markdown-str (foldl (lambda (x acc) (format "~a\n~a" acc x)) "" markdown-list)])
      (list markdown-str front-matter))))
