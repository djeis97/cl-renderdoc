;;;; cl-renderdoc.asd

(asdf:defsystem #:cl-renderdoc
  :description "Describe cl-renderdoc here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-autowrap)
  :components ((:module autowrap-spec
		:pathname "spec"
		:components
		((:static-file "renderdoc_app.h")))
	       (:file "package")
	       (:file "cl-renderdoc")))
