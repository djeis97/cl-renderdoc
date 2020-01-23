;;;; package.lisp
(cl:in-package #:cl)

(defpackage #:cl-renderdoc-int
  (:export #:*renderdoc-api-handle*)
  (:use #:autowrap))

(defpackage #:cl-renderdoc
  (:use #:cl #:autowrap #:cl-renderdoc-int)
  (:export #:get-api-version #:launch-replay-ui #:trigger-capture
           #:overlay-flags #:mask-overlay-bits #:negative-overlay-mask
           #:get-overlay-bits))
