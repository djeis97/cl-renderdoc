# cl-renderdoc
Wrappers for the renderdoc in application api

## Overview
This library is neither necessary nor sufficient for getting started using renderdoc with lisp,
although the [getting set up] section provides some high-level instructions for that. All this library
does is wrap the [in-application API](https://renderdoc.org/docs/in_application_api.html), which
allows some programmatic control over renderdoc from inside your lisp code.

## Getting set up:

1. Launch your lisp with renderdoccmd
```sh
renderdoccmd capture -w sbcl
```
2. Load cl-renderdoc
```lisp
(asdf:load-system :cl-renderdoc)
```

3. Load something which uses GL (No help here, just do what you would do normally to launch your window and get a GL context)
4. Create a window with a GL context (see above)

Now you should be ready to call any functions exposed by the renderdoc API on your GL main thread.

## If you use Slime or Sly

After step 1 you can load slynk or swank into your image, launch a server, and connect to it from emacs.
All that matters is lisp is launched with renderdoccmd and cl-renderdoc is loaded before you load *anything* that tries to link GL.

For example, on sly/slynk that would be

```lisp
(ql:quickload :slynk)
(slynk:create-server :port 4005 :interface "localhost" :style :spawn)
```
and then connect using `M-x sly-connect`. Ought to be the same for slime/swank, but I have not used them in a while.

## Wrapped functions

There are only a few functions currently wrapped:
- `cl-renderdoc:get-api-version` (GetAPIVersion): Returns the current API version
- `cl-renderdoc:trigger-capture` (TriggerCapture): Triggers a capture of the next complete frame
- `cl-renderdoc:launch-replay-ui` (LaunchReplayUI): Start the graphical capture inspector attached to this process
- `cl-renderdoc:get-overlay-bits` (GetOverlayBits): Get the flags describing the current state of the overlay
- `cl-renderdoc:mask-overlay-bits` (MaskOverlayBits): Enable/disable parts of the overlay
I have only tested calling them on the thread holding my GL context, but they do not block. All three can be called
without any arguments and should "just work". `trigger-capture` will record any GL commands for the current frame,
`launch-replay-ui` will open the renderdoc capture inspector attached to the current process.

Wrapping additional functions is more tedious than difficult- cl-autowrap has done a decent chunk of the work, but each function still needs to have a little bit of additional glue code written due to the design of the underlying api.
