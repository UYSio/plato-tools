#lang racket

(provide dispatch-util-htmlfile)

#|
Given a relative file name (possibly including path component),
get the file name component with an HTML extension.
E.g. news/sample.md -> sample.html
|#
(define (dispatch-util-htmlfile rel-file)
  (let* [[filename-with-ext (path->string (file-name-from-path rel-file))]
         [filename (first (string-split filename-with-ext "."))]
         [filename-out (string-append filename ".html")]]
    filename-out))
