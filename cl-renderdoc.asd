;;;; cl-renderdoc.asd

(asdf:defsystem #:cl-renderdoc
  :description "Wrapper around the renderdoc In-Application API for Common Lisp"
  :author "Elijah Malaby <emalaby@mail.usf.edu>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-autowrap)
  :components ((:module autowrap-spec
		:pathname "spec"
		:components
		((:static-file "renderdoc_app.h")))
	       (:file "package")
	       (:file "cl-renderdoc")))
