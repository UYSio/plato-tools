#lang racket

(require web-server/private/mime-types)

(require "handlers/_import.rkt"
         "handlers/_params.rkt")

(provide dispatch-asset)

(define detector (make-path->mime-type "modules/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

;; given a mime-type (e.g. image/png), extract
;; the 'type' (e.g. image)
(define (type-from-mime-type mime-type)
  (if mime-type
      (car (string-split (bytes->string/utf-8 mime-type) "/"))
      "UNKNOWN_TYPE"))
;; given a mime-type (e.g. image/png), extract
;; the 'subtype' (e.g. png)
(define (subtype-from-mime-type mime-type)
  (if mime-type
      (cdr (string-split (bytes->string/utf-8 mime-type) "/"))
      "UNKNOWN_SUBTYPE"))

(define (error-handler mime-type)
  (printf "No handler for mime-type ~a\n" mime-type))

;; dispatches an asset based on mime-type
(define (dispatch-asset content-root asset-path out-dir)
  (let* ([mime-type (detect-mime-type asset-path)]
         [type (type-from-mime-type mime-type)]
         [params (p mime-type content-root asset-path out-dir)])
    (if (hash-has-key? lookup type)
        ((hash-ref lookup type) params)
        (printf "No handler for mime-type ~a\n" mime-type)
        )))
