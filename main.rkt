#lang racket

(require racket/path)
(require "modules/dispatch.rkt")

(require (file "~/.plato/config.rkt"))

;; ensure directories in config exists
(for ([path-atom '(landing-page-dir entries-dir)])
  (let ([path (dict-ref cfg path-atom)])
     (make-directory* (string->path path))))

;; send all assets to dispatcher
(for ([asset-root-s (dict-ref cfg 'asset-roots)])
  ;; add a trailing slash, even if already
  (let ([asset-root (string-append asset-root-s "/")])
    (for ([abs-path (in-directory asset-root)])
      (let ([rel-path (path->string (find-relative-path asset-root abs-path))])
        (if (file-exists? abs-path)
            (dispatch-asset cfg abs-path rel-path)
            #f)))))
