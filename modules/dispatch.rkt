#lang racket

(require xml
         web-server/private/mime-types)

(provide dispatch-asset)

(define detector (make-path->mime-type "modules/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

(define (write-html out-dir file-name xexpr)
  (define out (open-output-file
               (format "~a/data~a.html" out-dir file-name)
               #:exists 'replace))
  (write-xexpr xexpr out)
  (close-output-port out))

;; dispatches an asset based on mime-type
(define (dispatch-asset content-root asset-path out-dir)
  (define sub (string-replace (path->string asset-path) content-root ""))
  (define safe (string-replace sub "/" "_"))
  (write-html out-dir safe `(div (p ,safe)))
  (printf "~a has mime type ~a\n" asset-path (detect-mime-type asset-path)))
