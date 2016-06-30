#lang racket

(require "_util.rkt"
         openssl/sha1)

(provide refresh-home)

(define PAGE_SIZE 22)

(define (split-by lst n)
  (if (not (empty? lst))
      (if (< (length lst) (* 2 n))
          (cons lst '())
          (cons (take lst n) (split-by (drop lst n) n)))
      '()))

(define (refresh-home output-root output-entries)
  (let* [[all-page (format "~a/~a" output-root "all.html")]
         [entries (reverse (sequence->list (in-directory output-entries)))]]

    ;; make a single page for those who risk loading it and
    ;; exhausting their data plan.
    (make-all all-page entries)

    ;; write smaller pages, for pagination &c
    (let* [[chunks (split-by entries PAGE_SIZE)]]
      (foldl
       (lambda (sub-entries this-page)
         (let* [[entries-as-string (map path->string sub-entries)]
                [concat (string-join entries-as-string "")]
               [digest (sha1 (open-input-string concat))]
               [next-page (string-append digest ".html")]
               [this-page-full (format "~a/~a" output-root this-page)]]
           (if (> (length sub-entries) PAGE_SIZE)
               ;; we're on the last page
               (make-all this-page-full sub-entries)
               (make-one this-page-full sub-entries next-page))
           ;;(printf ">> i = ~a this page = ~a next page = ~a~n" (length sub-entries) this-page next-page)
           next-page))
       "index.html"
       chunks))))
