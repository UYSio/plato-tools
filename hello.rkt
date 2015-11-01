#lang racket
(require xml)
(require racket/include)

(require (file "~/.plato.rkt"))
(define locs (hash-ref plato-opts 'locs))

(define (something loc path)
  (define sub (string-replace (path->string path) loc ""))
  (define safe (string-replace sub "/" "_"))
  (define out (open-output-file
               (format "out/data~a.html" safe)
               #:exists 'replace))
  (write-xexpr `(div
                 (p
                  ,safe))
               out
               #:insert-newlines? #t)
  (close-output-port out))

; if 'path' is a file, do something
(define (with-path-as-file loc path)
  (if (file-exists? path)
      (something loc path)
      #f))

;; Finds Racket sources in all subdirs
(for ([loc locs])
  (for ([path (in-directory loc)])
    (with-path-as-file loc path)
    ))

;; Report each unique line from stdin
; (define seen (make-hash))
;(for ([line (in-lines)])
;  (unless (hash-ref seen line #f)
;    (displayln line))
;  (hash-set! seen line #t))
