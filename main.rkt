#lang racket
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))
(define asset-roots (hash-ref plato-opts 'asset-roots))
(define out-dir (hash-ref plato-opts 'out-dir))

;; adds a trailing slash to a path if
;; it doesn't have it
(define (slashify path)
  ; if the last character is a slash
  (if (eq? #\/ (list->string (reverse (string->list path))))
      path
      (string-append path "/")))

;; if 'path' is a file (not a directory), then
;; dispatch it to a handler
(define (with-path-if-file asset-root path)
  (if (file-exists? path)
      (dispatch-asset asset-root path out-dir)
      #f))

;; Finds Racket sources in all subdirs
(for ([asset-root-wowo-trailing asset-roots])
  (let ([asset-root (slashify asset-root-wowo-trailing)])
    (for ([path (in-directory asset-root)])
      (with-path-if-file asset-root path))))
