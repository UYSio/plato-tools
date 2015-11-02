#lang racket

(require racket/path) ; for filename-extension
(require "handlers/_init.rkt"
         "handlers/_params.rkt"
         "mime/util.rkt")

(provide dispatch-asset)

;; dispatches an asset based on mime-type
(define (dispatch-asset abs-path rel-path out-dir)
  (let* ([mime-type (detect-mime-type abs-path)]
         [type (mime-type-type mime-type)]
         [subtype (mime-type-subtype mime-type)]
         [params (p subtype rel-path out-dir)]
         [ext (bytes->string/utf-8 (filename-extension abs-path))])
    (cond
      [(hash-has-key? mime-type-lookup type) ((hash-ref mime-type-lookup type) params)]
      [(hash-has-key? file-extension-lookup ext) ((hash-ref file-extension-lookup ext) params)]
      [else (printf "No handler for mime-type ~a\n" mime-type)])))
