#lang racket

;; Finds Racket sources in all subdirs
(for ([path (in-directory)]
      #:when (regexp-match? #rx"[.]rkt$" path))
  (printf "source file: ~a\n" path))

;; Report each unique line from stdin
(define seen (make-hash))
(for ([line (in-lines)])
  (unless (hash-ref seen line #f)
    (displayln line))
  (hash-set! seen line #t))
