#lang racket

(require racket/path) ; for filename-extension
(require "_date.rkt"
         "../handlers/_init.rkt"
         "../handlers/_params.rkt"
         "../mime/util.rkt"
         "_util.rkt"
         "_detect.rkt")

(require "../handlers/just-copy/_init.rkt")

(provide dispatch-asset)

;; creates 'directory' recursively in 'base'
;; and returns the new path as a string
(define (mkdir base directory)
  (let (
        [full (string-append base "/" (path->string directory))])
    (make-directory* (string->path full))
    full))

; Dispatches an asset based on mime-type.
;
; Variable names with examples:
;
; asset-root: /a/b/
; asset-dir: /a/b/2015/10/
; assets: (/a/b/2015/10/foo.txt /a/b/2015/10/bar.png)
;
; Then the script below computes:
; asset-rel-dir: 2015/10/
;
; Get from cfg:
; output-root: /out
; output-entries: /out/entries
;
; Then it creates asset-rel-dir recursively in {output-root}/pages, to get:
; asset-output-landing-pages: /out/pages/2015/10
;
; Then it computes a rendition for each asset, e.g. bar.png:
; mime-type: image/png
; type: image
; subtype: png
; asset-rel-file: 2015/10/bar.png
(define (dispatch-asset cfg asset-root asset-dir assets)
  ; compute parameters
  (let* ([output-entries (dict-ref cfg 'output-entries)]
         [output-root (dict-ref cfg 'output-root)]
         [output-landing-pages (string-append output-root "/pages")]
         [asset-rel-dir (find-relative-path asset-root asset-dir)]
         [asset-output-landing-pages (mkdir output-landing-pages asset-rel-dir)]
         [main-content (detect-main assets)])
    (for ([asset assets])
      (let* ([mime-type (detect-mime-type asset)]
             [type (mime-type-type mime-type)]
             [subtype (mime-type-subtype mime-type)]
             [asset-rel-file (find-relative-path asset-root asset)]
             [the-date (guess-date asset-rel-file)]
             [out-file (dispatch-util-htmlfile asset-rel-file)]
             [params (p
                      output-root
                      asset-rel-file
                      subtype
                      asset
                      asset-output-landing-pages
                      output-entries
                      the-date
                      out-file)]
             [ext (bytes->string/utf-8 (filename-extension asset))])
        (if (or (equal? "" main-content) (equal? main-content asset))
            (cond
              [(hash-has-key? mime-type-lookup type) ((hash-ref mime-type-lookup type) params)]
              [(hash-has-key? file-extension-lookup ext) ((hash-ref file-extension-lookup ext) params)]
              [else (printf "\tNo handler for mime-type ~a\n" mime-type)])
            (just-copy params))
        ))))
