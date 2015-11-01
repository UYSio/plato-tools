#lang racket

(require xml
         web-server/private/mime-types)

(require "handlers/_import.rkt")

(provide dispatch-asset)

(define detector (make-path->mime-type "modules/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

;; dispatches an asset based on mime-type
(define (dispatch-asset content-root asset-path out-dir)
  (let ([mime-type (detect-mime-type asset-path)])
    (printf "dispatching mime type ~a\n" mime-type )
    ((hash-ref lookup "image") mime-type)
    ))

;; (define safe (string-replace (get-relative-asset-path content-root asset-path) "/" "_")) ; TODO
;; (write-html (get-filename out-dir safe) `(div (p ,safe)))
