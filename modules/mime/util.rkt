#lang racket

(provide mime-type-type mime-type-subtype detect-mime-type)

(require web-server/private/mime-types)

(define detector (make-path->mime-type "modules/mime/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

;; given a mime-type (e.g. image/png), extract
;; the 'type' (e.g. image)
(define (mime-type-type mime-type)
  (if mime-type
      (car (string-split (bytes->string/utf-8 mime-type) "/"))
      'unknown-type))

;; given a mime-type (e.g. image/png), extract
;; the 'subtype' (e.g. png)
(define (mime-type-subtype mime-type)
  (if mime-type
      (car (cdr (string-split (bytes->string/utf-8 mime-type) "/")))
      'unknown-subtype))
