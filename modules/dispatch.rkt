#lang racket

(require xml
         web-server/private/mime-types)

(provide dispatch-asset)

(define detector (make-path->mime-type "modules/mime.types"))
(define (detect-mime-type asset)
  (detector asset))

;; dispatches an asset based on mime-type
(define (dispatch-asset content-root asset-path out-dir)
  (define sub (string-replace (path->string asset-path) content-root ""))
  (define safe (string-replace sub "/" "_"))
  (define out (open-output-file
               (format "~a/data~a.html" out-dir safe)
               #:exists 'replace))
  (write-xexpr `(div
                 (p
                  ,safe))
               out)
  (close-output-port out)
  (printf "~a has mime type ~a\n" asset-path (detect-mime-type asset-path)))
