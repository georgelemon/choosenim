import nimblepkg/common

type
  ChooseNimError* = object of NimbleError

const
  chooseNimVersion* = "0.8.16"

  proxies* = [
      "nim",
      "nimble",
      "nimgrep",
      "nimpretty",
      "nimsuggest",
      "testament",
      "nim-gdb",
    ]

  mingwProxies* = [
    "gcc",
    "g++",
    "gdb",
    "ld"
  ]

  # llvm-mingw on Windows ARM64 provides gcc/g++ wrappers (clang-based) but
  # no gdb (uses lldb) and ld is an lld wrapper; only proxy what exists.
  mingwProxiesArm64* = [
    "gcc",
    "g++",
  ]

proc getOutputInfo*(err: ref NimbleError): (string, string) =
  var error = ""
  var hint = ""
  error = err.msg
  when not defined(release):
    let stackTrace = getStackTrace(err)
    error = stackTrace & "\n\n" & error
  if not err.isNil:
    hint = err.hint

  return (error, hint)
