#lang racket

(provide mime-type-lookup file-extension-lookup)

;; TODO require * ?
(require "by-mime-type/image.rkt")
(require "by-file-extension/markdown/handler.rkt")

(define mime-type-lookup
  (hash
   "image" handle-image))

(define file-extension-lookup
  (hash
   "md" handle-markdown))
