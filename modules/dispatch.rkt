#lang racket

(require xml
         web-server/private/mime-types)

(require "handlers/_import.rkt")

(provide dispatch-asset)

(define detector (make-path->mime-type "modules/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

(define (base-from-mime-type mime-type)
  (if mime-type
      (car (string-split (bytes->string/utf-8 mime-type) "/"))
      "extension"))

(define (error-handler mime-type)
  (printf "No handler for mime-type ~a\n" mime-type))

;; dispatches an asset based on mime-type
(define (dispatch-asset content-root asset-path out-dir)
  (let* ([mime-type (detect-mime-type asset-path)]
        [base (base-from-mime-type mime-type)])
    (if (hash-has-key? lookup base)
        ((hash-ref lookup base) mime-type)
        (printf "No handler for ~a\n" mime-type)
        )
    ))

;; (define safe (string-replace (get-relative-asset-path content-root asset-path) "/" "_")) ; TODO
;; (write-html (get-filename out-dir safe) `(div (p ,safe)))
