#lang racket

(require racket/path)
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))
(define asset-roots (hash-ref plato-opts 'asset-roots))
(define out-dir (hash-ref plato-opts 'out-dir))

;; Finds Racket sources in all subdirs
(for ([asset-root-s asset-roots])
  ;; add a trailing slash, even if already
  (let ([asset-root (string-append asset-root-s "/")])
    (for ([abs-path (in-directory asset-root)])
      (let ([rel-path (path->string (find-relative-path asset-root abs-path))])
        (if (file-exists? abs-path)
            (dispatch-asset abs-path rel-path out-dir)
            #f)))))
