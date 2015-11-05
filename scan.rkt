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

  (for ([asset-root (dict-ref cfg 'asset-roots)])
    (for ([abs-path (in-directory asset-root)])
      (let ([rel-path (path->string (find-relative-path asset-root abs-path))])
        (if (file-exists? abs-path)
            (dispatch-asset cfg abs-path rel-path)
            #f)))))
