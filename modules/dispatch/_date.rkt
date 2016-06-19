#lang racket

(provide guess-date)

(define (guess-date s)
  (let* ([m '(#px"\\d{4}/\\d{2}/\\d{2}" #px"\\d{4}/\\d{2}" #px"\\d{4}")]
         [x (dropf (map (lambda (r) (regexp-match r s)) m) false?)])
    (if (empty? x) "no date"
        (first (first x)))))
