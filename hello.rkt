#lang racket

(require xml/xexpr)


(define (with-asset path)
  (printf "path: ~a\n" path)
  )

;; Finds Racket sources in all subdirs
(define locs
  '("/home/opyate/Documents/stuff" "/home/opyate/Documents/stuff2"))
(for ([loc locs])
  (for ([path (in-directory loc)])

    (define sub (string-replace (path->string path) loc ""))
    ;(define out (open-output-file (format "data~a.html" path)))
    ;(write-xexpr '(div (p path)) out #:insert-newlines? #t)
    ;(close-output-port out)
    (with-asset sub)
    ))

;; Report each unique line from stdin
; (define seen (make-hash))
;(for ([line (in-lines)])
;  (unless (hash-ref seen line #f)
;    (displayln line))
;  (hash-set! seen line #t))
