#lang racket

#|
For each content location:
* for sub-directories
* check if sub-directory has content
* could be one or many files
* if any one of those files == cfg.plato-skip then skip
* otherwise, send the bundle to the dispatcher
|#

(require racket/path
         "modules/dispatch.rkt")

(provide scan)

(define (skip? cfg bundle)
  (let* ([skip-str (dict-ref cfg 'skip)]
         [rx-str (string-append ".*" skip-str)]
         [rx (pregexp rx-str)]
         [matcher (lambda (str) (regexp-match? rx str))])
    (ormap matcher bundle)))

(define (scan cfg)
  ;; for each sub-directory of asset-root
  (for ([asset-root (dict-ref cfg 'asset-roots)])
    (for ([directory (in-directory asset-root)])
      (if (directory-exists? directory)
          (let* ([files (sequence-filter file-exists?
                                         (in-directory directory (lambda (x) #f)))]
                 [bundle (sequence->list files)])
            (unless (or (empty? bundle) (skip? cfg bundle))
              ; send to dispatcher the directory, and
              ; the file bundle in it.
              (dispatch-asset cfg asset-root directory bundle)))
          #f))))
