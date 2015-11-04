#lang racket

#|
For each content location:
* for sub-directories
* check if sub-directory has content
* could be one or many files
* if any one of those files == cfg.plato-ignore then skip
* otherwise, send the bundle to the dispatcher
|#

(require racket/path
         "modules/dispatch.rkt")

(provide scan)

(define (scan cfg)

  (for ([asset-root-s (dict-ref cfg 'asset-roots)])
    ;; add a trailing slash, even if already
    (let ([asset-root (string-append asset-root-s "/")])
      (for ([abs-path (in-directory asset-root)])
        (let ([rel-path (path->string (find-relative-path asset-root abs-path))])
          (if (file-exists? abs-path)
              (dispatch-asset cfg abs-path rel-path)
              #f))))))
