#lang racket
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))
(define asset-roots (hash-ref plato-opts 'asset-roots))
(define out-dir (hash-ref plato-opts 'out-dir))

;; if 'path' is a file (not a directory), then
;; dispatch it to a handler
(define (with-path-if-file asset-root path)
  (if (file-exists? path)
      (dispatch-asset asset-root path out-dir)
      #f))

;; Finds Racket sources in all subdirs
(for ([asset-root asset-roots])
  (for ([path (in-directory asset-root)])
    (with-path-if-file asset-root path)
    ))
