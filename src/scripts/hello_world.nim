# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
proc program*(): string =
  return "Hello, World"

when isMainModule:
  echo(program())
