#lang racket
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))
(define content-roots (hash-ref plato-opts 'content-roots))
(define out-dir (hash-ref plato-opts 'out-dir))

; if 'path' is a file, do something
(define (with-path-as-file content-root path)
  (if (file-exists? path)
      (dispatch-content content-root path out-dir)
      #f))

;; Finds Racket sources in all subdirs
(for ([content-root content-roots])
  (for ([path (in-directory content-root)])
    (with-path-as-file content-root path)
    ))

;; Report each unique line from stdin
; (define seen (make-hash))
;(for ([line (in-lines)])
;  (unless (hash-ref seen line #f)
;    (displayln line))
;  (hash-set! seen line #t))
