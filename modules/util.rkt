#lang racket

(provide slashify)

;; adds a trailing slash to a path if
;; it doesn't have it
(define (slashify path)
  ; if the last character is a slash
  (if (eq? #\/ (list->string (reverse (string->list path))))
      path
      (string-append path "/")))
