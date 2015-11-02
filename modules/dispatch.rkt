#lang racket

(require "inithandlers.rkt"
         "mime/util.rkt"
         "handlers/_params.rkt")

(provide dispatch-asset)

;; dispatches an asset based on mime-type
(define (dispatch-asset abs-path rel-path out-dir)
  (let* ([mime-type (detect-mime-type abs-path)]
         [type (mime-type-type mime-type)]
         [subtype (mime-type-subtype mime-type)]
         [params (p subtype rel-path out-dir)])
    (if (hash-has-key? lookup type)
        ((hash-ref lookup type) params)
        (printf "No handler for mime-type ~a\n" mime-type)
        )))
