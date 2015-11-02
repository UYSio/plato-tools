#lang racket

(provide lookup)

;; TODO require handlers/* ?
(require "handlers/image.rkt")

(define lookup (hash
                "image" handle-image))
