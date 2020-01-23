# cl-renderdoc
Wrappers for the renderdoc in application api

## Overview
This library is neither necessary nor sufficient for getting started using renderdoc with lisp,
although the getting set up section provides some high-level instructions for that. All this library
does is wrap the [in-application API](https://renderdoc.org/docs/in_application_api.html), which
allows some programmatic control over renderdoc from inside your lisp code.

## Getting set up:

1. Launch your lisp with renderdoccmd
In order to use renderdoc properly it needs to intercept calls to other 3D graphics APIs. To that
end, you have to launch your lisp using renderdoc's wrapper to ensure that everything is set up
properly (this does not seem to be necessary just to load the foreign library used by this project,
but without it renderdoc is unlikely to be able to serve as a graphical debugging aid).

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

The command given in step 1 works as a lisp implementation command for sly at least. At this time
passing it directly to slime has not been tested.

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
