#lang racket

; from https://gist.github.com/greghull/960fe4c62933ceab167e

;; A simple racket example that shows how to use FFI to bind to libhoedown
;; The end goal is to be able to make a simple function call:
;;
;;  (markdown "Hello, world")  --->   "<p>Hello, world</p>\n"

(provide markdown)

(require ffi/unsafe
	 ffi/unsafe/define
	 ffi/unsafe/alloc
	 test-engine/racket-tests)

(define-ffi-definer define-hoedown (ffi-lib "lib/hoedown/libhoedown"))

;; The 3 data structures hoedown needs to render text -> html
(define _hoedown_renderer (_cpointer 'hoedown_renderer))
(define _hoedown_document (_cpointer 'hoedown_document))
(define-cstruct _BUFFER ([data _pointer]
			 [size _int]
			 [asize _int]
			 [unit _int]
			 [data_realloc _pointer]
			 [data_free _pointer]
			 [buffer_free _pointer]))


;; The buffer functions
(define-hoedown hoedown_buffer_free (_fun _BUFFER-pointer -> _void)
  #:wrap (deallocator))
(define-hoedown hoedown_buffer_new (_fun _int -> _BUFFER-pointer)
  #:wrap (allocator hoedown_buffer_free))
(define-hoedown hoedown_buffer_puts (_fun _BUFFER-pointer _string -> _void))
(define-hoedown hoedown_buffer_cstr (_fun _BUFFER-pointer -> _string))

;; The render functions
(define-hoedown hoedown_html_renderer_free (_fun _hoedown_renderer -> _void)
  #:wrap (deallocator))
(define-hoedown hoedown_html_renderer_new (_fun _int _int -> _hoedown_renderer)
  #:wrap (allocator hoedown_html_renderer_free))

;; The document functions
(define-hoedown hoedown_document_free (_fun _hoedown_document -> _void)
  #:wrap (deallocator))
(define-hoedown hoedown_document_new
  (_fun _hoedown_renderer _int _int -> _hoedown_document)
  #:wrap (allocator hoedown_document_free))
(define-hoedown hoedown_document_render
  (_fun _hoedown_document _BUFFER-pointer _pointer _int -> _void))

(define (markdown . strings)
  (let* ([ib (hoedown_buffer_new 1024)]
	 [ob (hoedown_buffer_new 1024)]
	 [r (hoedown_html_renderer_new 0 0)]
	 [doc (hoedown_document_new r 0 16)]
	 [out (begin
		(let loop ([lst strings])
		  (unless (null? lst)
		    (hoedown_buffer_puts ib (car lst))
		    (loop (cdr lst))))
		(hoedown_document_render doc ob
					 (BUFFER-data ib) (BUFFER-size ib))
		(hoedown_buffer_cstr ob))])
    out))

(check-expect (markdown "Hello, world") "<p>Hello, world</p>\n")
(check-expect (markdown "- item 1\n" "- item 2\n")
	      "<ul>\n<li>item 1</li>\n<li>item 2</li>\n</ul>\n")
(test)

;; Goal accomplished!
