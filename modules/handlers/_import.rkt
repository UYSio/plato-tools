#lang racket

(provide lookup)

;; TODO require handlers/* ?
(require "image.rkt")

(define lookup (hash
                "image" handle-image))
