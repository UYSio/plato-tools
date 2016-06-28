#lang racket

(require 2htdp/image)

(provide resize)

;; given an image path rooted in "pages/"
(define (resize image-file)
  (let* [[image (bitmap/file (string->path image-file))]
         [width (image-width image)]
         [height (image-height image)]]
    (if (> width height)
        (save-image (scale (/ 200 width) image) image-file)
        (save-image (scale (/ 200 height) image) image-file))))
