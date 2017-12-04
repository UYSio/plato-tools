#lang racket

(provide detect-main)


(define (string-contains? str sub)
  (regexp-match? (regexp sub) str))

; rough-and-readily set the main content to be .md, .txt, or anything else
(define (detect-main assets)
  (let ([main ""])
    (for ([asset assets])
      (cond [(string-contains? asset ".md") (set! main asset)]
            [(and (string-contains? asset ".txt") (not (string-contains? main ".md"))) (set! main asset)]
            ;[(and (not (string-contains? main ".md")) (not (string-contains? main ".txt"))) (set! main asset)]
            ))
    (cond [(not (equal? "" main)) (printf "Main ~a for bundle ~a\n" main assets)])
    main))
