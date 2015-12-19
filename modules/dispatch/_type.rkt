#lang racket

(provide form)

; order of importance of assets.
; E.g. if markdown + image, then markdown (and img is supporting)
; E.g. if image + text, then image (and text is a description)
(define order
  '(markdown
    image
    video
    text))

; gets the prevailing 'form' of an asset bundle,
; according to some ordering.
(define (form bundle)
  (for ([asset bundle])
    ))
