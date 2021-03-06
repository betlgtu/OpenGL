2.13.1.1
--------
* Aftermath for the `glClearNamedFramebufferfi` chaos in the OpenGL registry,
  see the corresponding
  [issue](https://www.khronos.org/bugzilla/show_bug.cgi?id=1394) on Khronos.

2.13.1.0
--------
* Added `extensionSupported`.
* Relaxed upper version bound for OpenGLRaw.
* Added CHANGELOG.md to distribution.

2.13.0.0
--------
* Added missing drawing commands using vertex arrays and some related types.
* Added missing whole framebuffer operations.
* Added getters for `stencilMaskSeparate`, `stencilFuncSeparate`, and `stencilOpSeparate`, making them full-blown `StateVar`s.
* Added `patchDefaultInnerLevel` and `patchDefaultOuterLevel` to control the default tessellation levels.
* Added `ContextLost` constructor to `ErrorCategory` type.
* Added `SeparateAttribs` and deprecated `SeperateAttribs`, fixing a spelling mistake.
