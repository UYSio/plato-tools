#lang racket
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))
(define asset-roots (hash-ref plato-opts 'asset-roots))
(define out-dir (hash-ref plato-opts 'out-dir))


;; given a content-root (e.g. /a/b/c)
;; given an asset-path (e.g. /a/b/c/d/asset.ext)
;; return the difference (e.g. d/asset.ext)
(define (get-relative-asset-path content-root asset-path)
  (string-replace (path->string asset-path) content-root ""))

;; Finds Racket sources in all subdirs
(for ([asset-root-s asset-roots])
  ;; add a trailing slash, even if already
  (let ([asset-root (string-append asset-root-s "/")])
    (for ([abs-path (in-directory asset-root)])
      (let ([rel-path (get-relative-asset-path asset-root abs-path)])
        (if (file-exists? abs-path)
            (dispatch-asset abs-path rel-path out-dir)
            #f)))))
