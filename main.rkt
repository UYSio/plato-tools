#lang racket

#|
Ensures config is sane, dependencies exist,
then sends it off to the scanner.
|#

(require racket/path
         racket/date
         "modules/scan.rkt"
         "modules/collate.rkt"
         (file "~/.plato/config.rkt"))

(date-display-format 'iso-8601)

(define (ensure-exists config)
  ;; ensure directories in config exists
  (for ([path-atom '(output-root output-entries)])
    (let ([path (dict-ref config path-atom)])
      (make-directory* (string->path path)))))

; This will benefit from a threading macro
; http://www.greghendershott.com/2013/05/the-threading-macro.html
(define (ensure-trailing-slashes config)
  (dict-set!
   config
   'input-roots
   (map (lambda (s) (string-append s "/"))
        (map path->string
             (map normalize-path
                  (dict-ref config 'input-roots))))))

;; send all assets to dispatcher
(define (main config)
  (ensure-exists config)
  (ensure-trailing-slashes config)
  (scan config)
  (collate config))

;; here we go...
(main cfg)
