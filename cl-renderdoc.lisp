;;;; cl-renderdoc.lisp

(in-package #:cl-renderdoc-int)

(cffi:load-foreign-library "librenderdoc.so")

(c-include '(cl-renderdoc autowrap-spec "renderdoc_app.h")
	   :spec-path '(cl-renderdoc autowrap-spec))

(cffi:defcfun ("RENDERDOC_GetAPI" renderdoc-get-api%) :int (v :int) (p :pointer))

(cl:defun renderdoc-get-api ()
  (with-alloc (p :pointer)
    (renderdoc-get-api% +e-renderdoc-api-version-1-3-0+ p)
    (make-renderdoc-api-1-3-0 :ptr (cffi:mem-ref p :pointer))))

(cl:defparameter *renderdoc-api-handle* (renderdoc-get-api))

(cl:in-package :cl-renderdoc)

(cffi:defbitfield overlay-flags
  (:capture-list #.+e-renderdoc-overlay-capture-list+)
  (:frame-number #.+e-renderdoc-overlay-frame-number+)
  (:frame-rate #.+e-renderdoc-overlay-frame-rate+)
  (:all #.+e-renderdoc-overlay-all+)
  (:none #.+e-renderdoc-overlay-none+)
  (:default #.+e-renderdoc-overlay-default+)
  (:enabled #.+e-renderdoc-overlay-enabled+))

(defun get-api-version (&optional (renderdoc-api-handle *renderdoc-api-handle*))
  (with-alloc (i :int 3)
    (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.get-api-version renderdoc-api-handle) ()
				  :pointer (c-aptr i 0 :int)
				  :pointer (c-aptr i 1 :int)
				  :pointer (c-aptr i 2 :int)
				  :void)
    (values (c-aref i 0 :int)
            (c-aref i 1 :int)
            (c-aref i 2 :int))))

(defun launch-replay-ui (&optional (renderdoc-api-handle *renderdoc-api-handle*))
  (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.launch-replay-ui renderdoc-api-handle) ()
				:uint 1 :pointer (cffi:null-pointer)
				:uint))

(defun trigger-capture (&optional (renderdoc-api-handle *renderdoc-api-handle*))
  (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.trigger-capture renderdoc-api-handle) () :void))

(defun negative-overlay-mask (&rest bits)
  (logand +e-renderdoc-overlay-all+ (lognot (cffi:foreign-bitfield-value 'overlay-flags bits))))

(defun get-overlay-bits (&optional (renderdoc-api-handle *renderdoc-api-handle*))
  (cffi:foreign-bitfield-symbols
   'cl-renderdoc:overlay-flags
   (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.get-overlay-bits renderdoc-api-handle) () :int)))

(defun mask-overlay-bits (ands ors &optional (renderdoc-api-handle *renderdoc-api-handle*))
  (cffi:foreign-funcall-pointer (renderdoc-api-1-3-0.mask-overlay-bits renderdoc-api-handle) ()
                                overlay-flags ands
                                overlay-flags ors
                                :void))


