when cushort isnot uint16:
  {.fatal: "cushort != uint16: " &
    "not binary compatible with glfw; please report this.".}

when cuint isnot uint32:
  {.fatal: "cuint != uint32: " &
    "not binary compatible with glfw; please report this.".}

import wrapper
from tables import `[]`, `[]=`, add, initTable, hasKey
from strutils import toLower
from unicode import Rune

export unicode.Rune
export wrapper.pollEvents
export wrapper.waitEvents

type
  TMouseBtn* = enum
    mbLeft = (0, "Left mouse button")
    mbRight = (1, "Right mouse button")
    mbMiddle = (2, "Middle mouse button")
    mb4 = (3, "Mouse button 4")
    mb5 = (4, "Mouse button 5")
    mb6 = (5, "Mouse button 6")
    mb7 = (6, "Mouse button 7")
    mb8 = (7, "Mouse button 8")
  TKey* = enum
    keyUnknown = -1
    keySpace = 32
    keyApostrophe = 39
    keyComma = 44
    keyMinus = 45
    keyPeriod = 46
    keySlash = 47
    key0 = 48
    key1 = 49
    key2 = 50
    key3 = 51
    key4 = 52
    key5 = 53
    key6 = 54
    key7 = 55
    key8 = 56
    key9 = 57
    keySemicolon = 59
    keyEqual = 61
    keyA = 65
    keyB = 66
    keyC = 67
    keyD = 68
    keyE = 69
    keyF = 70
    keyG = 71
    keyH = 72
    keyI = 73
    keyJ = 74
    keyK = 75
    keyl = 76
    keyM = 77
    keyN = 78
    keyO = 79
    keyP = 80
    keyQ = 81
    keyR = 82
    keyS = 83
    keyT = 84
    keyU = 85
    keyV = 86
    keyW = 87
    keyX = 88
    keyY = 89
    keyZ = 90
    keyLeftBracket = 91
    keyBackslash = 92
    keyRightBracket = 93
    keyGraveAccent = 96
    keyWorld1 = 161
    keyWorld2 = 162
    keyEscape = 256
    keyEnter = 257
    keyTab = 258
    keyBackspace = 259
    keyInsert = 260
    keyDelete = 261
    keyRight = 262
    keyLeft = 263
    keyDown = 264
    keyUp = 265
    keyPageUp = 266
    keyPageDown = 267
    keyHome = 268
    keyEnd = 269
    keyCapsLock = 280
    keyScrollLock = 281
    keyNumLock = 282
    keyPrintScreen = 283
    keyPause = 284
    keyF1 = 290
    keyF2 = 291
    keyF3 = 292
    keyF4 = 293
    keyF5 = 294
    keyF6 = 295
    keyF7 = 296
    keyF8 = 297
    keyF9 = 298
    keyF10 = 299
    keyF11 = 300
    keyF12 = 301
    keyF13 = 302
    keyF14 = 303
    keyF15 = 304
    keyF16 = 305
    keyF17 = 306
    keyF18 = 307
    keyF19 = 308
    keyF20 = 309
    keyF21 = 310
    keyF22 = 311
    keyF23 = 312
    keyF24 = 313
    keyF25 = 314
    keyKp0 = 320
    keyKp1 = 321
    keyKp2 = 322
    keyKp3 = 323
    keyKp4 = 324
    keyKp5 = 325
    keyKp6 = 326
    keyKp7 = 327
    keyKp8 = 328
    keyKp9 = 329
    keyKpDecimal = 330
    keyKpDivide = 331
    keyKpMultiply = 332
    keyKpSubtract = 333
    keyKpAdd = 334
    keyKpEnter = 335
    keyKpEqual = 336
    keyLeftShift = 340
    keyLeftControl = 341
    keyLeftAlt = 342
    keyLeftSuper = 343
    keyRightShift = 344
    keyRightControl = 345
    keyRightAlt = 346
    keyRightSuper = 347
    keyMenu = 348
  TKeyAction* = enum
    kaUp = (0, "up")
    kaDown = (1, "down")
    kaRepeat = (2, "repeat")
  TModifierKey* = enum
    mkShift = (wrapper.MOD_SHIFT, "shift")
    mkCtrl = (wrapper.MOD_CONTROL, "ctrl")
    mkAlt = (wrapper.MOD_ALT, "alt")
    mkSuper = (wrapper.MOD_SUPER, "super")
  TModifierKeySet* = set[TModifierKey]

type
  PWinHandle = wrapper.GLFWwindow
  TWin* = object
    handle: PWinHandle

    winPosCb*: TWinPosCb
    winSizeCb*: TWinSizeCb
    winCloseCb*: TWinCloseCb
    winRefreshCb*: TWinRefreshCb
    winFocusCb*: TWinFocusCb
    winIconifyCb*: TWinIconifyCb
    framebufSizeCb*: TframebufSizeCb
    mouseBtnCb*: TMouseBtnCb
    cursorPosCb*: TCursorPosCb
    cursorEnterCb*: TCursorEnterCb
    scrollCb*: TScrollCb
    keyCb*: TKeyCb
    charCb*: TCharCb
  PWin* = ref TWin
  TWinPosCb* = proc(win: PWin, pos: tuple[x, y: int]) {.closure.}
  TWinSizeCb* = proc(win: PWin, res: tuple[w, h: int]) {.closure.}
  TWinCloseCb* = proc(win: PWin) {.closure.}
  TWinRefreshCb* = proc(win: PWin) {.closure.}
  TWinFocusCb* = proc(win: PWin, focus: bool) {.closure.}
  TWinIconifyCb* = proc(win: PWin, iconified: bool) {.closure.}
  TFramebufSizeCb* = proc(win: PWin, res: tuple[w, h: int]) {.closure.}
  TMouseBtnCb* = proc(win: PWin, btn: TMouseBtn, pressed: bool,
    modKeys: TModifierKeySet) {.closure.}
  TCursorPosCb* = proc(win: PWin, pos: tuple[x, y: float64]) {.closure.}
  TCursorEnterCb* = proc(win: PWin, entered: bool) {.closure.}
  TScrollCb* = proc(win: PWin, offset: tuple[x, y: float64]) {.closure.}
  TKeyCb* = proc(win: PWin, key: TKey, scanCode: int, action: TKeyAction,
    modKeys: TModifierKeySet) {.closure.}
  TCharCb* = proc(win: PWin, codePoint: Rune) {.closure.}
  PMonitorHandle = wrapper.GLFWmonitor
  TMonitor* = object
    handle: PMonitorHandle

proc initModifierKeySet(bitfield: int): TModifierKeySet =
  for x in TModifierKey:
    if (bitfield and x.int) != 0:
      result.incl((bitfield and x.int).TModifierKey)

type
  TGLFW_Err* = enum
    geNoErr = (wrapper.NOT_INITIALIZED - 2, "no error")
    geUnknownErr = (wrapper.NOT_INITIALIZED - 1, "unknown error")
    geNotInit = (wrapper.NOT_INITIALIZED, "not initialized")
    geNoCurrContext = (wrapper.NO_CURRENT_CONTEXT, "no current context")
    geInvalidEnum = (wrapper.INVALID_ENUM, "invalid enum")
    geInvalidValue = (wrapper.INVALID_VALUE, "invalid value")
    geOutOfMemory = (wrapper.OUT_OF_MEMORY, "out of memory")
    geApiUnavail = (wrapper.API_UNAVAILABLE, "API unavailable")
    geVersionUnavail = (wrapper.VERSION_UNAVAILABLE, "version unavailable")
    gePlatformErr = (wrapper.PLATFORM_ERROR, "platform error")
    geFmtUnavail = (wrapper.FORMAT_UNAVAILABLE, "format unavailable")

var
  gErrCode = geNoErr
  gErrMsg = ""

type
  GLFWError* = object of Exception
    err*: TGLFW_Err

proc getHandle*(o: PWin): PWinHandle =
  o.handle

proc fail(err = geUnknownErr, msg: string = "", iff = true) =
  if not iff:
    return

  var e = newException(GLFWError, if msg != "": msg else: $err)
  gErrCode = geNoErr
  gErrMsg.setLen(0)
  e.err = err
  raise e

proc errCheck =
  if gErrCode != geNoErr:
    fail(gErrCode, gErrMsg)

proc failIf(val, equals: expr, msg = ""): expr =
  let val = val
  errCheck()
  if val == equals:
    fail(msg = msg)
  val

# We can't raise an exception here, because that might mess up the GLFW stack.
proc errCb(code: cint, msg: cstring) {.cdecl.} =
  gErrCode = TGLFW_Err(code)
  gErrMsg = $msg

proc newMonitor*(handle: PMonitorHandle): TMonitor =
  result.handle = handle

type
  TMonitorCb* = proc(monitor: TMonitor, connected: bool) {.closure.}

var gMonitorCb: TMonitorCb

proc `monitorCb=`*(cb: TMonitorCb) =
  gMonitorCb = cb

proc internalMonitorCb(handle: PMonitorHandle, connected: cint) {.cdecl.} =
  if not gMonitorCb.isNil:
    gMonitorCb(TMonitor(handle: handle), connected.bool)

proc getMonitors*: seq[TMonitor] =
  var count: cint
  var handlesPtr = wrapper.getMonitors(count.addr).failIf(nil)
  fail(iff = count <= 0)
  var handles = cast[ptr array[10_000, PMonitorHandle]](handlesPtr)

  result = @[]
  for i in 0 .. <count:
    result.add(newMonitor(handles[i]))

proc getPrimaryMonitor*: TMonitor =
  newMonitor(wrapper.getPrimaryMonitor().failIf(nil))

proc pos*(o: TMonitor): tuple[x, y: int] =
  var tmp = (0.cint, 0.cint)
  wrapper.getMonitorPos(o.handle, tmp[0].addr, tmp[1].addr)
  (tmp[0].int, tmp[1].int)

proc physicalSizeMM*(o: TMonitor): tuple[w, h: int] =
  var tmp = (0.cint, 0.cint)
  wrapper.getMonitorPhysicalSize(o.handle, tmp[0].addr, tmp[1].addr)
  (tmp[0].int, tmp[1].int)

proc name*(o: TMonitor): string =
  $wrapper.getMonitorName(o.handle).failIf(nil)

type
  TVidMode* = tuple[
    dim: tuple[w, h: int], bits: tuple[r, g, b: int], refreshRate: int]

proc vidModeConv(o: ptr wrapper.GLFWvidmode): TVidMode =
  ((o.width.int, o.height.int),
   (o.redBits.int, o.greenBits.int, o.blueBits.int), o.refreshRate.int)

proc vidModes*(o: TMonitor): seq[TVidMode] =
  var count: cint
  var modesPtr = wrapper.getVideoModes(o.handle, count.addr).failIf(nil)
  fail(iff = count <= 0)

  var modes = cast[ptr array[10_000, GLFWvidmode]](modesPtr)
  result = @[]
  for i in 0 .. <count:
    result.add((
      dim: (w: modes[i].width.int, h: modes[i].height.int),
      bits: (
        r: modes[i].redBits.int,
        g: modes[i].greenBits.int,
        b: modes[i].blueBits.int),
      refreshRate: modes[i].refreshRate.int))

proc vidMode*(o: TMonitor): TVidMode =
  vidModeConv(wrapper.getVideoMode(o.handle).failIf(nil))

proc `gamma=`*(o: TMonitor, val: float32) =
  wrapper.setGamma(o.handle, val.cfloat)

type 
  TGammaRamp* = tuple[r, g, b: seq[uint16], size: int32]
  PGammaRamp* = ptr TGammaRamp

proc `gammaRamp=`*(o: TMonitor, ramp: TGammaRamp) =
  var x = ramp
  wrapper.setGammaRamp(o.handle, cast[ptr wrapper.GLFWgammaramp](x.addr))

proc gammaRamp*(o: TMonitor): PGammaRamp =
  cast[PGammaRamp](wrapper.getGammaRamp(o.handle).failIf(nil))

var
  hasInit = false

proc init* =
  if hasInit:
    return

  discard wrapper.setErrorCallback(errCb)
  discard wrapper.init().failIf(0)
  discard wrapper.setMonitorCallback(internalMonitorCb)
  hasInit = true

proc terminate* =
  wrapper.terminate()
  hasInit = false

proc nilMonitor*: TMonitor =
  nil

proc nilWin*: PWin =
  new(result)

var
  winTable = initTable[PWinHandle, PWin]()
winTable[nil] = nil

proc handleToWin(o: PWinHandle): PWin =
  if winTable.hasKey(o): winTable[o] else: nilWin()

var
  winPosCb: GLFWwindowposfun
  winSizeCb: GLFWwindowsizefun
  winCloseCb: GLFWwindowclosefun
  winRefreshCb: GLFWwindowrefreshfun
  winFocusCb: GLFWwindowfocusfun
  winIconifyCb: GLFWwindowiconifyfun
  framebufSizeCb: GLFWframebuffersizefun
  mouseBtnCb: GLFWmouseButtonfun
  cursorPosCb: GLFWcursorposfun
  cursorEnterCb: GLFWcursorenterfun
  scrollCb: GLFWscrollfun
  keyCb: GLFWkeyfun
  charCb: GLFWcharfun

type
  TGL_version* = enum
    glv10 = (0x10, "OpenGL 1.0")
    glv11 = (0x11, "OpenGL 1.1")
    glv12 = (0x12, "OpenGL 1.2")
    glv13 = (0x13, "OpenGL 1.3")
    glv14 = (0x14, "OpenGL 1.4")
    glv15 = (0x15, "OpenGL 1.5")
    glv20 = (0x20, "OpenGL 2.0")
    glv21 = (0x21, "OpenGL 2.1")
    glv30 = (0x30, "OpenGL 3.0")
    glv31 = (0x31, "OpenGL 3.1")
    glv32 = (0x32, "OpenGL 3.2")
    glv33 = (0x33, "OpenGL 3.3")
    glv40 = (0x40, "OpenGL 4.0")
    glv41 = (0x41, "OpenGL 4.1")
    glv42 = (0x42, "OpenGL 4.2")
    glv43 = (0x43, "OpenGL 4.3")
    glv44 = (0x44, "OpenGL 4.4")
  TGL_ES_version* = enum
    glesv10 = (glv10, "OpenGL ES 1.0")
    glesv11 = (glv11, "OpenGL ES 1.1")
    glesv20 = (glv20, "OpenGL ES 2.0")
    glesv30 = (glv30, "OpenGL ES 3.0")
  TGL_API_type* = enum
    GL_API_GL,
    GL_API_GL_ES
  TGL_API* = object
    case kind: TGL_API_type:
      of GL_API_GL:
        GL_version: TGL_version
        forwardCompat, debugContext: bool
      of GL_API_GL_ES:
        GL_ES_version: TGL_ES_version
    profile: TGL_profile
    robustness: TGL_robustness
  TGL_robustness* = enum
    glrNone = wrapper.NO_ROBUSTNESS,
    glrNoResetNotification = wrapper.NO_RESET_NOTIFICATION,
    glrLoseContextOnReset = wrapper.LOSE_CONTEXT_ON_RESET
  TGL_profile* = enum
    glpAny = wrapper.OPENGL_ANY_PROFILE,
    glpCore = wrapper.OPENGL_CORE_PROFILE,
    glpCompat = wrapper.OPENGL_COMPAT_PROFILE,

proc shouldClose*(o: PWin): bool =
  wrapper.windowShouldClose(o.handle) != 0

proc `shouldClose=`*(o: PWin, val: bool) =
  wrapper.setWindowShouldClose(o.handle, val.cint)

proc `title=`*(o: PWin, val: string) =
  wrapper.setWindowTitle(o.handle, val)

proc pos*(o: PWin): tuple[x, y: int] =
  var x, y: cint
  wrapper.getWindowPos(o.handle, x.addr, y.addr)
  (x.int, y.int)

proc `pos=`*(o: PWin, pos: tuple[x, y: int]) =
  wrapper.setWindowPos(o.handle, pos.x.cint, pos.y.cint)

proc size*(o: PWin): tuple[w, h: int] =
  var x, y: cint
  wrapper.getWindowSize(o.handle, x.addr, y.addr)
  (x.int, y.int)

proc `size=`*(o: PWin, size: tuple[w, h: int]) =
  wrapper.setWindowSize(o.handle, size.w.cint, size.h.cint)

proc framebufSize*(o: PWin): tuple[w, h: int] =
  var w, h: cint
  wrapper.getframebufferSize(o.handle, w.addr, h.addr)
  (w.int, h.int)

proc iconify*(o: PWin) =
  wrapper.iconifyWindow(o.handle)

proc iconified*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.ICONIFIED).bool

proc restore*(o: PWin) =
  wrapper.restoreWindow(o.handle)

proc show*(o: PWin) =
  wrapper.showWindow(o.handle)

proc hide*(o: PWin) =
  wrapper.hideWindow(o.handle)

proc visible*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.VISIBLE).bool

proc focused*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.FOCUSED).bool

proc resizable*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.RESIZABLE).bool

proc decorated*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.DECORATED).bool
  
proc forwardCompat*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.OPENGL_FORWARD_COMPAT).bool

proc debugContext*(o: PWin): bool =
  wrapper.getWindowAttrib(o.handle, wrapper.OPENGL_DEBUG_CONTEXT).bool

proc profile*(o: PWin): TGL_profile =
  wrapper.getWindowAttrib(o.handle, wrapper.OPENGL_PROFILE).TGL_profile

proc robustness*(o: PWin): TGL_robustness =
  wrapper.getWindowAttrib(o.handle, wrapper.CONTEXT_ROBUSTNESS).TGL_robustness

proc stickyKeys*(o: PWin): bool =
  wrapper.getInputMode(o.handle, wrapper.STICKY_KEYS).bool

proc `stickyKeys=`*(o: PWin, yes: bool) =
  wrapper.setInputMode(o.handle, wrapper.STICKY_KEYS, yes.cint)

proc stickyMouseBtns*(o: PWin): bool =
  wrapper.getInputMode(o.handle, wrapper.STICKY_MOUSE_BUTTONS).bool

proc `stickyMouseBtns=`*(o: PWin, yes: bool) =
  wrapper.setInputMode(o.handle, wrapper.STICKY_MOUSE_BUTTONS, yes.cint)

type
  TCursorMode* = enum
    cmNormal = wrapper.CURSOR_NORMAL
    cmHidden = wrapper.CURSOR_HIDDEN
    cmDisabled = wrapper.CURSOR_DISABLED

proc cursorMode*(o: PWin): TCursorMode =
  wrapper.getInputMode(o.handle, wrapper.CURSOR).TCursorMode

proc `cursorMode=`*(o: PWin, mode: TCursorMode) =
  wrapper.setInputMode(o.handle, wrapper.CURSOR, mode.cint)

proc monitor*(o: PWin): TMonitor =
  newMonitor(wrapper.getWindowMonitor(o.handle))

proc isKeyDown*(o: PWin, key: TKey): bool =
  wrapper.getKey(o.handle, key.cint) == wrapper.PRESS

proc mouseBtnDown*(o: PWin, btn: TMouseBtn): bool =
  wrapper.getMouseButton(o.handle, btn.cint) == wrapper.PRESS

proc cursorPos*(o: PWin): tuple[x, y: float64] =
  var x, y: cdouble
  wrapper.getCursorPos(o.handle, x.addr, y.addr)
  (x.float64, y.float64)

proc `cursorPos=`*(o: PWin, pos: tuple[x, y: float64]) =
  wrapper.setCursorPos(o.handle, pos.x.cdouble, pos.y.cdouble)

proc isJoystickPresent*(o: PWin, joy: int): bool =
  wrapper.joystickPresent(joy.cint).bool

proc getJoystickAxes*(joy: int): seq[float32] =
  var count: cint
  var axesPtr = wrapper.getJoystickAxes(joy.cint, count.addr)
  fail(iff = count <= 0)
  var axes = cast[ptr array[10_000, float32]](axesPtr)

  result = @[]
  for i in 0 .. <count:
    result.add(axes[i].float32)

proc getJoystickBtns*(joy: int): seq[string] =
  var count: cint
  var btnsPtr = wrapper.getJoystickButtons(joy.cint, count.addr)
  fail(iff = count <= 0)
  var btns = cast[ptr array[10_000, cstring]](btnsPtr)

  result = @[]
  for i in 0 .. <count:
    result.add($btns[i])

proc joystickName*(joy: int): string =
  $wrapper.getJoystickName(joy.cint)

proc `clipboardStr=`*(o: PWin, str: string) =
  wrapper.setClipboardString(o.handle, str)

proc clipboardStr*(o: PWin): string =
  $(wrapper.getClipboardString(o.handle).failIf(nil))

proc major(ver: TGL_version|TGL_ES_version): int =
  ver.int shr 4 and 0xf

proc minor(ver: TGL_version|TGL_ES_version): int =
  ver.int and 0xf

proc initGL_API*(
    version = glv30,
    forwardCompat, debugContext = false,
    profile = glpAny,
    robustness = glrNone): TGL_API =
  TGL_API(kind: GL_API_GL, GL_version: version, forwardCompat: forwardCompat,
    debugContext: debugContext, profile: profile, robustness: robustness)

proc initGL_ES_API*(version = glesv20, profile = glpAny, robustness = glrNone):
    TGL_API =
  TGL_API(kind: GL_API_GL_ES, GL_ES_version: version, profile: profile,
    robustness: robustness)

proc setHints(
      resizable, visible, decorated, stereo, SRGB_capableFramebuf: bool,
      bits: tuple[r, g, b, a, stencil, depth: int],
      accumBufBits: tuple[r, g, b, a: int],
      nAuxBufs, nMultiSamples, refreshRate: range[0 .. 1000],
      GL_API: TGL_API) =
  template h(name, val: expr) =
    wrapper.windowHint(name.cint, val.cint)

  h(wrapper.RESIZABLE, resizable)
  h(wrapper.VISIBLE, visible)
  h(wrapper.DECORATED, decorated)

  h(wrapper.RED_BITS, bits.r)
  h(wrapper.GREEN_BITS, bits.r)
  h(wrapper.BLUE_BITS, bits.r)
  h(wrapper.ALPHA_BITS, bits.r)
  h(wrapper.DEPTH_BITS, bits.depth)
  h(wrapper.STENCIL_BITS, bits.stencil)

  h(wrapper.ACCUM_RED_BITS, accumBufBits.r)
  h(wrapper.ACCUM_GREEN_BITS, accumBufBits.g)
  h(wrapper.ACCUM_BLUE_BITS, accumBufBits.b)
  h(wrapper.ACCUM_ALPHA_BITS, accumBufBits.a)

  h(wrapper.AUX_BUFFERS, nAuxBufs)
  h(wrapper.STEREO, stereo)
  h(wrapper.SAMPLES, nMultiSamples)
  h(wrapper.SRGB_CAPABLE, SRGB_capableFramebuf)
  h(wrapper.REFRESH_RATE, refreshRate)

  # OpenGL hints.

  case GL_API.kind:
    of GL_API_GL:
      h(wrapper.CONTEXT_VERSION_MAJOR, GL_API.GL_version.major)
      h(wrapper.CONTEXT_VERSION_MINOR, GL_API.GL_version.minor)

      h(wrapper.CLIENT_API, wrapper.OPENGL_API)
      h(wrapper.OPENGL_FORWARD_COMPAT, GL_API.forwardCompat)
      h(wrapper.OPENGL_DEBUG_CONTEXT, GL_API.debugContext)
    of GL_API_GL_ES:
      h(wrapper.CONTEXT_VERSION_MAJOR, GL_API.GL_ES_version.major)
      h(wrapper.CONTEXT_VERSION_MINOR, GL_API.GL_ES_version.minor)

      h(wrapper.CLIENT_API, wrapper.OPENGL_ES_API)

  h(wrapper.OPENGL_PROFILE, GL_API.profile)
  h(wrapper.CONTEXT_ROBUSTNESS, GL_API.robustness)

proc destroy*(o: PWin) =
  wrapper.destroyWindow(o.handle)

proc makeContextCurrent*(o: PWin) =
  wrapper.makeContextCurrent(o.handle)

proc newWin*(
    dim = (w: 640, h: 480),
    title = "",
    fullscreen = nilMonitor(),
    shareResourcesWith = nilWin(),
    visible, decorated = true,
    resizable, stereo, SRGB_capableFramebuf = false,
    bits: tuple[r, g, b, a, stencil, depth: int] = (8, 8, 8, 8, 8, 24),
    accumBufBits: tuple[r, g, b, a: int] = (8, 8, 8, 8),
    nAuxBufs, nMultiSamples, refreshRate = range[0 .. 1000](0),
    GL_API = initGL_API()):
      PWin =
  new(result)

  setHints(
    resizable = resizable,
    visible = visible,
    decorated = decorated,
    stereo = stereo,
    SRGB_capableFramebuf = SRGB_capableFramebuf,
    bits = bits,
    accumBufBits = accumBufBits,
    nAuxBufs = nAuxBufs,
    nMultiSamples = nMultiSamples,
    refreshRate = refreshRate,
    GL_API = GL_API)

  result.handle = wrapper.createWindow(dim.w.cint, dim.h.cint, title,
    fullscreen.handle, shareResourcesWith.handle).failIf(nil)
  winTable.add result.handle, result

  template get(f: expr): bool =
    var win {.inject.} = handleToWin(handle)
    var cb {.inject.} = if not win.isNil: win.f else: nil

    not win.isNil and not cb.isNil

  winPosCb = proc(handle: PWinHandle, x, y: cint) {.cdecl.} =
    if get(winPosCb):
      cb(win, (x: x.int, y: y.int))
  discard wrapper.setWindowPosCallback(result.handle, winPosCb)

  winSizeCb = proc(handle: PWinHandle, w, h: cint) {.cdecl.} =
    if get(winSizeCb):
      cb(win, (w.int, h.int))
  discard wrapper.setWindowSizeCallback(result.handle, winSizeCb)

  winCloseCb = proc(handle: PWinHandle) {.cdecl.} =
    if get(winCloseCb):
      cb(win)
  discard wrapper.setWindowCloseCallback(result.handle, winCloseCb)

  winRefreshCb = proc(handle: PWinHandle) {.cdecl.} =
    if get(winRefreshCb):
      cb(win)
  discard wrapper.setWindowRefreshCallback(result.handle, winRefreshCb)

  winFocusCb = proc(handle: PWinHandle, focus: cint) {.cdecl.} =
    if get(winFocusCb):
      cb(win, focus.bool)
  discard wrapper.setWindowFocusCallback(result.handle, winFocusCb)

  winIconifyCb = proc(handle: PWinHandle, iconify: cint) {.cdecl.} =
    if get(winIconifyCb):
      cb(win, iconify.bool)
  discard wrapper.setWindowIconifyCallback(result.handle, winIconifyCb)

  framebufSizeCb = proc(handle: PWinHandle, w, h: cint) {.cdecl.} =
    if get(framebufSizeCb):
      cb(win, (w.int, h.int))
  discard wrapper.setframebufferSizeCallback(result.handle, framebufSizeCb)

  mouseBtnCb = proc(
      handle: PWinHandle, btn, pressed, modKeys: cint) {.cdecl.} =
    if get(mouseBtnCb):
      cb(win, TMouseBtn(btn), pressed.bool, initModifierKeySet(modKeys))
  discard wrapper.setMouseButtonCallback(result.handle, mouseBtnCb)

  cursorPosCb = proc(handle: PWinHandle, x, y: cdouble) {.cdecl.} =
    if get(cursorPosCb):
      cb(win, (x.float64, y.float64))
  discard wrapper.setCursorPosCallback(result.handle, cursorPosCb)

  cursorEnterCb = proc(handle: PWinHandle, entered: cint) {.cdecl.} =
    if get(cursorEnterCb):
      cb(win, entered.bool)
  discard wrapper.setCursorEnterCallback(result.handle, cursorEnterCb)

  scrollCb = proc(handle: PWinHandle, xOffset, yOffset: cdouble) {.cdecl.} =
    if get(scrollCb):
      cb(win, (x: xOffset.float64, y: yOffset.float64))
  discard wrapper.setScrollCallback(result.handle, scrollCb)

  keyCb = proc(
      handle: PWinHandle, key, scanCode, action, modKeys: cint) {.cdecl.} =
    if get(keyCb):
      cb(win, TKey(key), scanCode.int, action.TKeyAction,
        initModifierKeySet(modKeys))
  discard wrapper.setKeyCallback(result.handle, keyCb)

  charCb = proc(handle: PWinHandle, codePoint: cuint) {.cdecl.} =
    if get(charCb):
      cb(win, codePoint.Rune)
  discard wrapper.setCharCallback(result.handle, charCb)

proc `$`*(o: TKey): string =
  result = system.`$`(o)[3 .. -1]
  result[0] = result[0].toLower()

proc swapBufs*(o: PWin) =
  wrapper.swapBuffers(o.handle)

proc version*: tuple[major, minor, rev: int] =
  var tmp = (0.cint, 0.cint, 0.cint)
  wrapper.getVersion(tmp[0].addr, tmp[1].addr, tmp[2].addr)
  (tmp[0].int, tmp[1].int, tmp[2].int)

proc versionStr*: string =
  $wrapper.getVersionString()

proc update*(o: PWin) =
  o.swapBufs()
  pollEvents()

proc swapInterval*(interval: Natural) =
  wrapper.swapInterval(interval.cint)
