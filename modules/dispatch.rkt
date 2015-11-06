#lang racket

(require racket/path) ; for filename-extension
(require "handlers/_init.rkt"
         "handlers/_params.rkt"
         "mime/util.rkt")

(provide dispatch-asset)

;; takes *nix 'dirname' portion of 'filename'
;; and creates it recursively in 'base'
;; and returns the new path as a string
(define (mkdir base filename)
  (define path-from-filename (path-only filename))
  (if path-from-filename
      (let (
            [full (string-append base "/" (path->string path-from-filename))])
        (make-directory* (string->path full))
        full)
      base))

;; dispatches an asset based on mime-type
; bundle -> files (abs paths) in a directory
; directory -> the directory
(define (dispatch-asset cfg directory bundle)
  (let* ([entries-dir (dict-ref cfg 'entries-dir)]
         [landing-page-dir (dict-ref cfg 'landing-page-dir)]
         [asset-landing-page-dir (mkdir landing-page-dir directory)])
    (for ([asset bundle])
      (let* ([mime-type (detect-mime-type asset)]
             [type (mime-type-type mime-type)]
             [subtype (mime-type-subtype mime-type)]
             [params (p subtype asset asset-landing-page-dir entries-dir)]
             [ext (bytes->string/utf-8 (filename-extension asset))])
        (cond
          [(hash-has-key? mime-type-lookup type) ((hash-ref mime-type-lookup type) params)]
          [(hash-has-key? file-extension-lookup ext) ((hash-ref file-extension-lookup ext) params)]
          [else (printf "No handler for mime-type ~a\n" mime-type)])))))
