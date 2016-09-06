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
         "dispatch/main.rkt")

(provide scan)

(define (skip? cfg bundle)
  (let* ([skip-str (dict-ref cfg 'skip)]
         [rx-str (string-append ".*" skip-str)]
         [rx (pregexp rx-str)]
         [matcher (lambda (str) (regexp-match? rx str))])
    (ormap matcher bundle)))

(define (scan cfg)
  (printf "\n[1] Scanning...\n")
  ;; for each sub-directory of input-root
  (for ([input-root (dict-ref cfg 'input-roots)])
    (if (directory-exists? input-root)
        (for ([directory (in-directory input-root)])
          (if (directory-exists? directory)
              (let* ([files (sequence-filter file-exists?
                                             (in-directory directory (lambda (x) #f)))]
                     [bundle (sequence->list files)])
                (unless (or (empty? bundle) (skip? cfg bundle))
                  (printf "\n\033[0;33m₽lato\t\033[0;32m~a\033[0m\n" bundle)
                                        ; send to dispatcher the directory, and
                                        ; the file bundle in it.
                  (dispatch-asset cfg input-root directory bundle)))
              #f))
        (printf "\n\033[0;33m₽lato\t\033[0;31m404 ~a\033[0m\n" input-root))))
