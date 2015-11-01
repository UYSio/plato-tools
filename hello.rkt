#lang racket
(require xml/xexpr)
(require racket/include)

(require (file "~/.plato.rkt"))
(define locs (hash-ref plato-opts 'locs))

(define (something loc path)
  (define sub (string-replace (path->string path) loc ""))
  (printf "path: ~a\n" path))

; if 'path' is a file, do something
(define (with-path-as-file loc path)
  (if (file-exists? path)
      (something loc path)
      #f))

;; Finds Racket sources in all subdirs
(for ([loc locs])
  (for ([path (in-directory loc)])

    ;(define out (open-output-file (format "data~a.html" path)))
    ;(write-xexpr '(div (p path)) out #:insert-newlines? #t)
    ;(close-output-port out)
    (with-path-as-file loc path)
    ))

;; Report each unique line from stdin
; (define seen (make-hash))
;(for ([line (in-lines)])
;  (unless (hash-ref seen line #f)
;    (displayln line))
;  (hash-set! seen line #t))
