import strformat, os
# Package

version       = "0.1.0"
author        = "Gerson Gallo"
description   = "Cool and life saving scripts for a happy and peaceful life"
license       = "MIT"
srcDir        = "src"
binDir        = "out"
# bin           = @["scripts"]
namedBin = { 
    "simple/hello_world/hello_world": "simple/hello_world", 
}.toTable()


# Dependencies

requires "nim >= 1.4.8"

# task test, "Runs test suite":
# #     exec "testament pattern 'src/simple/hello_world/test.nim' --outdir:out"
#     exec "testament pattern 'tests/*.nim'"

# task testSimple, "Runs 'simple' scripts tests":
#     exec "testament pattern 'tests/*.nim'"

proc commonBuildOpts(under, name: string, bin: string = ""): tuple[buildPath: string, srcPath: string, common: string] =
    
    let actualBin = 
        if bin == "": name else: bin

    let cwd = thisDir()
    let buildPath = joinPath(cwd, "out", under, actualBin)
    let srcPath = joinPath(cwd, "src", under, name, fmt"{name}.nim")
    return (buildPath, srcPath, fmt"--colors:on --noNimblePath -d:NimblePkgVersion={version} -o:{buildPath} {srcPath}")

task buildProd, "Build for 'production' into 'out'":

    let under = "simple"
    let name = "hello_world"
    let bin = "hello-world"
    let opts = commonBuildOpts(under, name, bin)
    let prodOpts = "-d:release --opt:size"
    exec fmt"nim c {prodOpts} {opts.common}"
    exec fmt"upx {opts.buildPath}"

task clean, "Remove build output in 'out'":
    rmDir("out")
