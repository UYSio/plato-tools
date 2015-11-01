#lang racket
(require xml)
(require racket/include)

(require (file "~/.plato/config.rkt"))
(define asset-locations (hash-ref plato-opts 'asset-locations))
(define out-dir (hash-ref plato-opts 'out-dir))

(define (something loc path)
  (define sub (string-replace (path->string path) loc ""))
  (define safe (string-replace sub "/" "_"))
  (define out (open-output-file
               (format "~a/data~a.html" out-dir safe)
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
(for ([loc asset-locations])
  (for ([path (in-directory loc)])
    (with-path-as-file loc path)
    ))

;; Report each unique line from stdin
; (define seen (make-hash))
;(for ([line (in-lines)])
;  (unless (hash-ref seen line #f)
;    (displayln line))
;  (hash-set! seen line #t))
