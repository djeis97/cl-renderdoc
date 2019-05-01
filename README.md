# cl-renderdoc
Wrappers for the renderdoc in application api

## Getting set up:

1. Launch your lisp with renderdoccmd
```sh
renderdoccmd capture -w sbcl
```
2. Load cl-renderdoc
```lisp
(asdf:load-system :cl-renderdoc)
```

3. Load something which uses GL (No help here, just do what you would do normally to lanuch your window and get a GL context)
4. Create a window with a GL context (see above)

Now you should be ready to call any functions exposed by the renderdoc API on your GL main thread.

## If you use Slime or Sly

In between steps 1 and 3 you can load slynk or swank into your image, launch a server, and connect to it from emacs.
All that matters is lisp is launch with renderdoccmd and cl-renderdoc is loaded before you load *anything* that tries to link GL.

For example, on sly/slynk that would be

```lisp
(ql:quickload :slynk)
(slynk:create-server :port 4005 :interface "localhost" :style :spawn)
```
and then connect using `M-x sly-connect`. Ought to be the same for slime/swank, but I have not used them in a while.

## Wrapped functions

There are only three functions currently wrapped:
`cl-renderdoc:get-api-version`, `cl-renderdoc:trigger-capture`, and `cl-renderdoc:launch-replay-ui`.
I have only tested calling them on the thread holding my GL context, but they do not block. All three can be called
without any arguments and should "just work". `trigger-capture` will record any GL commands for the current frame,
`launch-replay-ui` will open the renderdoc capture inspector attached to the current process.
