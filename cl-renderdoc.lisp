;;;; cl-renderdoc.lisp

(in-package #:cl-renderdoc-int)

(cffi:load-foreign-library "librenderdoc.so")

(c-include '(cl-renderdoc autowrap-spec "renderdoc_app.h")
	   :spec-path '(cl-renderdoc autowrap-spec))

(cffi:defcfun ("RENDERDOC_GetAPI" renderdoc-get-api%) :int (v :int) (p :pointer))

(cl:defun renderdoc-get-api (version)
  (with-alloc (p :pointer)
    (renderdoc-get-api% version p)
    (make-renderdoc-api-1-3-0 :ptr (cffi:mem-ref p :pointer))))

(cl:defun renderdoc-get-api-version (renderdoc-api)
  (with-alloc (i :int 3)
    (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.get-api-version renderdoc-api) ()
				  :pointer (c-aptr i 0 :int)
				  :pointer (c-aptr i 1 :int)
				  :pointer (c-aptr i 2 :int)
				  :void)
    (cl:values (c-aref i 0 :int)
	       (c-aref i 1 :int)
	       (c-aref i 2 :int))))
