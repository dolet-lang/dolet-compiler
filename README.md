# Dolet Compiler

<div align="center">

```
██████╗  ██████╗ ██╗     ███████╗████████╗
██╔══██╗██╔═══██╗██║     ██╔════╝╚══██╔══╝
██║  ██║██║   ██║██║     █████╗     ██║   
██║  ██║██║   ██║██║     ██╔══╝     ██║   
██████╔╝╚██████╔╝███████╗███████╗   ██║   
╚═════╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝  
```

**A self-hosting systems programming language that compiles to native code via MLIR/LLVM.**

[![Written in Dolet](https://img.shields.io/badge/written%20in-Dolet-blue)]()
[![Platform](https://img.shields.io/badge/platform-Windows%20x64-lightgrey)]()

</div>

---

## Overview

The Dolet compiler (`doletc.exe`) is **written in Dolet itself** — it's a self-hosting compiler. It reads `.dlt` source files and produces native Windows executables through the following pipeline:

```
.dlt → Tokenize → Parse → Generate MLIR → LLVM IR → Object → Executable
```

The compiler uses **no C runtime** — all runtime functions (memory, I/O, strings, process management) are implemented in pure Dolet using the Windows API directly.

## Quick Start

### Option 1: Download Pre-built Release

Download the latest release from [Releases](https://github.com/dolet-lang/dolet-compiler/releases), extract, and run:

```batch
bin\doletc.exe hello.dlt
hello.exe
```

### Option 2: Build from Source

See [Building from Source](#building-from-source) below.

## Usage

```
doletc <input.dlt> [-o output.exe] [--keep-mlir] [--keep-llvm] [--no-runtime]
```

| Option | Description |
|--------|-------------|
| `-o <path>` | Output executable path (default: `<input>.exe`) |
| `--keep-mlir` | Keep intermediate `.mlir` file |
| `--keep-llvm` | Keep intermediate `.ll` file |
| `--no-runtime` | Don't auto-import runtime libraries |

## Language Features

- **Static typing** with type inference
- **Primitive types**: `i8`, `i16`, `i32`, `i64`, `i128`, `u8`–`u128`, `f32`, `f64`, `bool`, `str`, `char`
- **Structs** with static and instance methods
- **Enums** with variants
- **Pattern matching** (`match`/`case`)
- **Generic collections**: `list<T>`, `array<T>`, `map<K, V>`
- **Async/Await** with event loop
- **FFI** — `extern` blocks for C / Windows API interop
- **Module system** — `import` with automatic resolution
- **No C runtime dependency** — pure Windows API

## Example

```dolet
fun factorial(n: i32) -> i32:
    if n <= 1:
        return 1
    return n * factorial(n - 1)

result: i32 = factorial(10)
print(result)
```

```dolet
struct Point:
    x: f64
    y: f64

    fun distance(self, other: Point) -> f64:
        dx: f64 = self.x - other.x
        dy: f64 = self.y - other.y
        return Math.sqrt(dx * dx + dy * dy)

a: Point = Point(0.0, 0.0)
b: Point = Point(3.0, 4.0)
print(a.distance(b))
```

## Project Structure

```
dolet-compiler/
├── lexer/                 # Tokenizer
│   ├── tokenizer.dlt
│   └── token_types.dlt
├── parser/                # Recursive descent parser + AST
│   ├── ast_nodes.dlt
│   ├── parser_core.dlt
│   ├── parser_expr.dlt
│   ├── parser_stmt.dlt
│   ├── parser_decl.dlt
│   └── parser_main.dlt
├── codegen/               # MLIR code generation
│   ├── codegen_core.dlt
│   ├── codegen_types.dlt
│   ├── codegen_expr.dlt
│   ├── codegen_stmt.dlt
│   ├── codegen_decl.dlt
│   ├── codegen_access.dlt
│   └── codegen_main.dlt
├── driver/                # CLI driver
│   ├── pipeline_init.dlt
│   └── doletc_driver.dlt
├── bin/doletc.exe         # Compiled compiler
├── build/                 # Build artifacts
├── tests/                 # Test files
└── dltc.bat               # Batch driver script
```

## Building from Source

The compiler is self-hosting, so you need the [bootstrap compiler](https://github.com/dolet-lang/dolet-bootstrap) (written in Python) for the first build.

### Prerequisites

- **Python 3.8+**
- **LLVM Tools**: `clang.exe`, `lld-link.exe`, `mlir-translate.exe`
  - Download from [LLVM Releases](https://github.com/llvm/llvm-project/releases)

### 1. Set Up Workspace

Clone all required repos into a workspace directory:

```batch
mkdir dolet-workspace
cd dolet-workspace

:: Required
git clone https://github.com/dolet-lang/dolet-compiler.git dolet-compiler
git clone https://github.com/dolet-lang/dolet-bootstrap.git bootstrap
git clone https://github.com/dolet-lang/dolet-library.git library
```

### 2. Add LLVM Tools

Create a `tools/` directory at the workspace root and place the LLVM executables:

```
dolet-workspace/
├── tools/
│   ├── clang.exe
│   ├── lld-link.exe
│   └── mlir-translate.exe
├── dolet-compiler/
├── bootstrap/
└── library/
```

### 3. Build the Compiler

```batch
cd bootstrap
python build.py compile
```

This produces `dolet-compiler/bin/doletc.exe`.

### 4. Verify

```batch
dolet-compiler\bin\doletc.exe dolet-compiler\tests\test_print.dlt
dolet-compiler\tests\test_print.exe
```

### Required Workspace Layout

```
dolet-workspace/
├── dolet-compiler/    # This repo — compiler source
├── bootstrap/         # Python bootstrap compiler
├── library/           # Standard library, runtime & importable libs
│   ├── std/           # Standard library (runtime, std, sys, core)
│   ├── importable/    # Importable libraries (math, net, random)
│   └── system-abi-manager/
├── tools/             # LLVM toolchain (clang, lld-link, mlir-translate)
└── packages/          # External packages (optional)
```

> **Note:** The repos must be cloned with these exact directory names and placed side by side for the compiler to find them.

## Self-Hosting Flow

```
┌──────────────────────────────────────────────────────────┐
│  First Build (Bootstrap)                                 │
│  Python bootstrap ──compiles──> doletc.exe               │
│                                                          │
│  Self-Hosting (future)                                   │
│  doletc.exe ──compiles──> doletc.exe                     │
└──────────────────────────────────────────────────────────┘
```

## Related Repositories

| Repository | Description |
|------------|-------------|
| [dolet-compiler](https://github.com/dolet-lang/dolet-compiler) | The Dolet compiler (this repo) |
| [dolet-bootstrap](https://github.com/dolet-lang/dolet-bootstrap) | Python bootstrap compiler |
| [dolet-library](https://github.com/dolet-lang/dolet-library) | Standard library, runtime & importable libs |

## License

Dolet Programming Language — [dolet-lang](https://github.com/dolet-lang)
