# 🎯 Dolet Language Features Guide

> A comprehensive guide to all features supported by the Dolet programming language.

---

## 📋 Table of Contents

1. [Data Types](#1-data-types)
2. [Variables & Constants](#2-variables--constants)
3. [Type Aliases](#3-type-aliases)
4. [Operators](#4-operators)
5. [Control Flow](#5-control-flow)
6. [Loops](#6-loops)
7. [Functions](#7-functions)
8. [Async/Await](#8-asyncawait)
9. [Data Structures](#9-data-structures)
10. [Structs](#10-structs)
11. [Enums](#11-enums)
12. [Traits](#12-traits)
13. [Strings](#13-strings)
14. [Silicon Functions](#14-silicon-functions-hardware-intrinsics)
15. [Module System](#15-module-system)
16. [FFI](#16-ffi-foreign-function-interface)
17. [Standard Library](#17-standard-library)
18. [Context Blocks](#18-context-blocks-raii)

---

## 1. Data Types

### Signed Integers

| Type | Size | Range |
|------|------|-------|
| `i8` | 8-bit | -128 to 127 |
| `i16` | 16-bit | -32,768 to 32,767 |
| `i32` | 32-bit | ±2 billion |
| `i64` | 64-bit | ±9 quintillion |
| `i128` | 128-bit | Very large |

### Unsigned Integers

| Type | Size | Range |
|------|------|-------|
| `u8` | 8-bit | 0 to 255 |
| `u16` | 16-bit | 0 to 65,535 |
| `u32` | 32-bit | 0 to 4 billion |
| `u64` | 64-bit | 0 to 18 quintillion |
| `u128` | 128-bit | Very large |

### Floating Point

| Type | Size | Description |
|------|------|-------------|
| `f32` | 32-bit | Single precision float |
| `f64` | 64-bit | Double precision float |

### Other Types

| Type | Description |
|------|-------------|
| `str` | String type |
| `char` | Single character |
| `bool` | Boolean (true/false) |
| `ptr` | Raw pointer (for C interop) |

### Number Literals

```dolet
decimal = 42
hex = 0xFF
binary = 0b1010
octal = 0o755
float_num = 3.14
```

---

## 2. Variables & Constants

### Variable Declaration

```dolet
# Type inference
name = "Dolet"
age = 25
pi = 3.14159

# Explicit type annotation
score: i32 = 100
ratio: f64 = 3.14
letter: char = 'A'

# Constants
const PI = 3.14159
const MAX_SIZE: i32 = 1000

# Nullable variables
username?: str              # Can be null
player_id?: i32 = null      # Explicitly null
```

### Mutability

```dolet
# Regular variables are mutable
x = 10
x = 20  # OK

# Constants are immutable
const Y = 10
# Y = 20  # ERROR!
```

---

## 3. Type Aliases

Type aliases create a new name for an existing type. They are resolved at compile-time with zero runtime cost.

### Basic Type Alias

```dolet
type UserID = i64
type Score = i32
type Name = str

id: UserID = 12345
score: Score = 100
player: Name = "Ali"
```

### Collection Type Aliases

```dolet
type Scores = list<i32>
type Matrix = array<array<i32>>
type Dict = map<str, i32>
type NestedMap = map<str, list<i32>>

sc: Scores = [90, 85, 100]
mat: Matrix = [[1, 2, 3], [4, 5, 6]]
dd: Dict = ["a": 1, "b": 2]
```

### Function Pointer Type Aliases

```dolet
type Callback = fun(i32, i32) -> bool
type Handler = fun(str) -> i32
```

---

## 4. Operators

### Arithmetic Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `+` | Addition | `a + b` |
| `-` | Subtraction | `a - b` |
| `*` | Multiplication | `a * b` |
| `/` | Division | `a / b` |
| `%` | Modulo | `a % b` |
| `++` | Increment | `a++` |
| `--` | Decrement | `a--` |

### Compound Assignment

| Operator | Description | Example |
|----------|-------------|---------|
| `+=` | Add and assign | `a += 5` |
| `-=` | Subtract and assign | `a -= 5` |
| `*=` | Multiply and assign | `a *= 5` |
| `/=` | Divide and assign | `a /= 5` |

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `==` | Equal | `a == b` |
| `!=` | Not equal | `a != b` |
| `<` | Less than | `a < b` |
| `>` | Greater than | `a > b` |
| `<=` | Less or equal | `a <= b` |
| `>=` | Greater or equal | `a >= b` |

### Logical Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `&&` | Logical AND | `a && b` |
| `\|\|` | Logical OR | `a \|\| b` |
| `!` | Logical NOT | `!a` |

### Bitwise Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `&` | Bitwise AND | `a & b` |
| `\|` | Bitwise OR | `a \| b` |
| `^` | Bitwise XOR | `a ^ b` |
| `~` | Bitwise NOT | `~a` |
| `<<` | Left shift | `a << 2` |
| `>>` | Right shift | `a >> 2` |

### Type Casting

```dolet
x = 3.14 as i32      # Convert to integer (3)
y = 42 as f64        # Convert to float (42.0)
```

### Null Checking

```dolet
if x is null:
    print("x is null")

if x is not null:
    print("x has a value")
```

---

## 5. Control Flow

### If/Else Statements

```dolet
if x > 10:
    print("x is big")
else if x > 5:
    print("x is medium")
else:
    print("x is small")
```

### Match Statement (Pattern Matching)

```dolet
match x:
    case 1:
        print("One")
    case 2, 3:
        print("Two or Three")
    case 4..10:
        print("Between 4 and 10")
    else:
        print("Something else")
```

### Ternary Expression

```dolet
result = "adult" if age >= 18 else "minor"
status = "active" if is_online else "offline"
```

---

## 6. Loops

### For Loop with Range

```dolet
# Basic range (0 to 10 inclusive)
for i in 0 to 10:
    print(i)

# With step
for i in 0 to 100 step 5:
    print(i)

# Auto-reverse (counts down automatically)
for i in 10 to 0:
    print(i)

# Explicit negative step
for i in 100 to 0 step -10:
    print(i)
```

### For-Each Loop

```dolet
# Iterate over array
nums: array<i32> = [10, 20, 30]
for n in nums:
    print(n)

# Iterate over list
fruits: list<str> = ["apple", "banana", "mango"]
for fruit in fruits:
    print(fruit)

# Iterate over map (using .key and .value)
scores: map<str, i32> = ["Ali": 100, "Sara": 95]
for entry in scores:
    print(@"{entry.key}: {entry.value}")

# Nested iteration (nested generics)
matrix: array<array<i32>> = [[1, 2, 3], [4, 5, 6]]
for row in matrix:
    for val in row:
        print(val)
```

### While Loop

```dolet
x = 0
while x < 10:
    print(x)
    x++
```

### Loop Control

```dolet
# Break - exit loop early
for i in 0 to 100:
    if i == 50:
        break
    print(i)

# Continue - skip to next iteration
for i in 0 to 10:
    if i % 2 == 0:
        continue
    print(i)  # Only odd numbers
```

---

## 7. Functions

### Basic Function

```dolet
fun greet(name: str) -> str:
    return @"Hello, {name}!"

print(greet("World"))
```

### Function with Type Inference

```dolet
fun add(a, b):
    return a + b

result = add(10, 20)  # 30
```

### Nullable Parameters

```dolet
fun process(data?: str) -> str:
    if data is null:
        return "No data provided"
    return data
```

### Multiple Return Types (via Struct)

```dolet
struct Result:
    value: i32
    error?: str

fun divide(a: i32, b: i32) -> Result:
    if b == 0:
        return Result(value=0, error="Division by zero")
    return Result(value=a/b)
```

### Variadic Functions

```dolet
fun sum(nums...):
    total = 0
    for n in nums:
        total += n
    return total

print(sum(1, 2, 3, 4, 5))  # 15
```

### Function Pointers

```dolet
# Inline function pointer type
cb: fun(i32, i32) -> bool = my_compare

# Using type alias
type Callback = fun(i32, i32) -> bool
cb2: Callback = my_compare

# As function parameter
fun apply(a: i32, b: i32, func: fun(i32, i32) -> i32) -> i32:
    return func(a, b)
```

---

## 8. Async/Await

### Async Function Declaration

```dolet
async fun fetch_data(url: str) -> str:
    response = await http_get(url)
    return response.body

async fun process_all():
    data1 = await fetch_data("https://api.example.com/1")
    data2 = await fetch_data("https://api.example.com/2")
    return data1 + data2
```

### How It Works

The compiler transforms async functions into **state machines** automatically:
- Each `await` point becomes a state
- The function can be suspended and resumed
- Zero-cost abstraction - no runtime overhead

---

## 9. Data Structures

### Arrays (Fixed Size)

```dolet
fruits: array<str> = ["apple", "banana", "mango", "orange"]

# Access by index
print(fruits[0])  # apple
print(fruits[2])  # mango

# Iterate
for fruit in fruits:
    print(fruit)

# Empty array
empty: array<i32> = []
```

### Lists (Dynamic)

```dolet
nums: list<i32> = [1, 2, 3, 4, 5]

# Methods
nums.append(6)       # Add to end
nums.remove(3)       # Remove value 3
nums.pop()           # Remove last element
nums.clear()         # Remove all elements
size = nums.size()   # Get length

# Access by index
print(nums[0])
```

### Maps (Dictionaries)

```dolet
players: map<i32, str> = [
    1: "Ali",
    2: "Sara", 
    3: "Omar"
]

# Access by key
print(players[1])  # Ali

# Iterate
for p in players:
    print(@"Player {p.key}: {p.value}")

# Empty map
empty_map: map<str, i32> = []
```

### Nested Generics

All combinations of `array`, `list`, and `map` can be nested:

```dolet
# Array of arrays
matrix: array<array<i32>> = [[1, 2, 3], [4, 5, 6]]

# Array of lists
groups: array<list<str>> = [["a", "b"], ["c", "d"]]

# Array of maps
records: array<map<str, i32>> = [["x": 1, "y": 2], ["x": 3, "y": 4]]

# List of arrays
rows: list<array<i8>> = [[1, 2], [3, 4]]

# List of lists
nested: list<list<i32>> = [[10, 20], [30, 40]]

# Map with collection values
scores: map<str, list<i32>> = ["Ali": [90, 85], "Sara": [100, 95]]
grids: map<str, array<i32>> = ["row1": [1, 2, 3], "row2": [4, 5, 6]]

# Nested iteration
for row in matrix:
    for val in row:
        print(val)
```

---

## 10. Structs

### Basic Struct

```dolet
struct Player:
    name: str
    age?: i32
    score: i32 = 0

# Create instance
p = Player(name="Ali", age=25)
print(p.name)
print(p.score)  # 0 (default value)
```

### Struct with Methods

```dolet
struct Player:
    name: str
    score: i32 = 0

imple Player:
    # Static method (constructor)
    fun new(name: str) -> Player:
        return Player(name=name)
    
    # Instance method
    fun add_score(amount: i32):
        self.score += amount
    
    fun get_info() -> str:
        return @"Player: {self.name}, Score: {self.score}"

# Usage
player = Player.new("Nena")
player.add_score(100)
print(player.get_info())
```

### Access Modifiers

```dolet
struct Account:
    public username: str       # Accessible everywhere (default)
    private password: str      # Only inside Account methods
    protected balance: f32     # Inside Account and derived classes

imple Account:
    fun check_password(input: str) -> bool:
        return self.password == input  # OK: internal access
```

### Inheritance

```dolet
struct Actor:
    x: i32
    y: i32
    
    fun move(dx: i32, dy: i32):
        self.x += dx
        self.y += dy

struct Player extends Actor:
    name: str
    health: i32 = 100

# Player inherits x, y, and move() from Actor
```

### Static Fields and Methods

```dolet
struct Config:
    static instance_count: i32 = 0
    name: str
    
    static fun get_count() -> i32:
        return Config.instance_count
    
    static fun increment():
        Config.instance_count += 1

# Usage
Config.increment()
print(Config.get_count())
```

### Stack Allocation

```dolet
@stack
struct Point:
    x: f32
    y: f32

# Point is allocated on stack instead of heap
p = Point(x=10.0, y=20.0)
```

---

## 11. Enums

### Basic Enum

```dolet
enum Direction = [UP, DOWN, LEFT, RIGHT]

fun move_player(dir: Direction):
    if dir == Direction.UP:
        print("Moving up!")
    else if dir == Direction.DOWN:
        print("Moving down!")

move_player(Direction.UP)
```

### Enum in Match

```dolet
enum Status = [PENDING, ACTIVE, COMPLETED, FAILED]

fun handle_status(s: Status):
    match s:
        case Status.PENDING:
            print("Waiting...")
        case Status.ACTIVE:
            print("In progress")
        case Status.COMPLETED:
            print("Done!")
        case Status.FAILED:
            print("Error occurred")
```

---

## 12. Traits

### Trait Declaration

```dolet
trait Display:
    fun to_str(self) -> str

trait Comparable:
    fun compare(self, other) -> i32
```

### Implementing Traits

```dolet
struct Player:
    name: str
    score: i32

imple Display for Player:
    fun to_str(self) -> str:
        return @"Player({self.name}, {self.score})"
```

---

## 13. Strings

### Interpolated Strings

```dolet
name = "Ali"
age = 25
score = 100

# Use @"..." for interpolation
print(@"Name: {name}")
print(@"Age: {age}, Score: {score}")
print(@"Sum: {10 + 20}")
print(@"Double: {score * 2}")
```

### String Concatenation

```dolet
first = "Hello"
second = "World"
full = first + " " + second
print(full)  # Hello World
```

### String with Numbers

```dolet
count = 42
message = "Count: " + count
print(message)
```

---

## 14. Silicon Functions (Hardware Intrinsics)

Silicon functions use the `@` prefix and map to LLVM intrinsics. Some compile directly to single CPU instructions (hardware-backed), while others are backed by **pure Dolet implementations** in `runtime/math.dlt` — no C library dependency.

### Usage

```dolet
x = @sqrt(16.0)       # 4.0 — single CPU instruction (sqrtss)
y = @sin(3.14159)     # ~0  — pure Dolet polynomial approximation
z = @pow(2.0, 10.0)   # 1024.0 — pure Dolet exp/log
```

### Hardware-Backed (Single CPU Instruction)

These compile to actual CPU instructions with zero overhead:

| Function | Description | CPU Instruction |
|----------|-------------|------------------|
| `@sqrt` | Square root | `sqrtss` / `sqrtsd` |
| `@fabs` | Absolute value | `andps` (bitmask) |
| `@copysign` | Copy sign | `andps` + `orps` |
| `@minnum` | Minimum | `minss` / `minsd` |
| `@maxnum` | Maximum | `maxss` / `maxsd` |

### Pure Dolet-Backed (Polynomial Approximations)

These are implemented as pure Dolet functions in `runtime/math.dlt` using minimax polynomial approximations and range reduction — **no C runtime dependency**:

| Function | Description | Implementation |
|----------|-------------|----------------|
| `@sin` | Sine | Degree-9 minimax polynomial |
| `@cos` | Cosine | `sin(x + π/2)` |
| `@tan` | Tangent | `sin(x) / cos(x)` |
| `@asin` | Arc sine | Polynomial + `@sqrt` |
| `@acos` | Arc cosine | `π/2 - asin(x)` |
| `@atan` | Arc tangent | Polynomial with range reduction |
| `@atan2` | Arc tangent of y/x | `atan` + quadrant handling |
| `@exp` | e^x | Range reduction + polynomial |
| `@exp2` | 2^x | `exp(x * ln2)` |
| `@log` | Natural log (ln) | Range reduction + polynomial |
| `@log2` | Base-2 log | `log(x) / ln2` |
| `@log10` | Base-10 log | `log(x) / ln10` |
| `@pow` | Power (x^y) | `exp(y * log(x))` |
| `@floor` | Floor | `trunc` + correction |
| `@ceil` | Ceiling | `trunc` + correction |
| `@round` | Round to nearest | `floor(x + 0.5)` |
| `@trunc` | Truncate | `fptosi` + `sitofp` |

### Math Utility Struct

The `Math` struct provides additional utility functions (auto-imported from runtime):

```dolet
# Min / Max / Clamp
r = Math.min_f32(a, b)
r = Math.max_f32(a, b)
r = Math.clamp_f32(value, 0.0, 1.0)

# Interpolation
r = Math.lerp_f32(a, b, 0.5)
r = Math.smoothstep_f32(0.0, 1.0, t)

# Angle conversion
rad = Math.radians(90.0)      # degrees -> radians
deg = Math.degrees(1.5708)    # radians -> degrees

# Utilities
r = Math.sign_f32(x)          # -1.0, 0.0, or 1.0
r = Math.step_f32(0.5, x)     # 0.0 if x < edge, else 1.0
r = Math.wrap_f32(x, 0.0, 1.0)
r = Math.map_f32(x, 0.0, 1.0, -1.0, 1.0)  # remap range

# Integer
r = Math.abs_i32(-5)          # 5
r = Math.min_i32(a, b)
r = Math.max_i32(a, b)
r = Math.clamp_i32(x, 0, 100)
r = Math.pow_i32(2, 10)       # 1024
```

### Type Preservation

```dolet
# f32 input -> f32 output
x: f32 = 16.0
y = @sqrt(x)  # y is f32

# f64 input -> f64 output
a: f64 = 16.0
b = @sqrt(a)  # b is f64

# Integer input -> f64 output (auto-converted)
n = 16
r = @sqrt(n)  # r is f64
```

---

## 15. Module System

### Import Syntax (V2)

```dolet
# Full import — dual access: dsqrt() and math.dsqrt()
import math

# Selective import — dual access for selected symbols only
import math.dsqrt
import math.dsqrt, math.dsin

# Aliased import — alias prefix only: m.dsqrt()
import math as m

# Selective aliased — alias prefix only for selected symbols
import math.dsqrt as m
```

### Access Patterns

| Syntax | Direct Access | Module Prefix | Alias Prefix |
|--------|:---:|:---:|:---:|
| `import math` | `dsqrt()` | `math.dsqrt()` | — |
| `import math.dsqrt` | `dsqrt()` | `math.dsqrt()` | — |
| `import math as m` | — | — | `m.dsqrt()` |
| `import math.dsqrt as m` | — | — | `m.dsqrt()` |

### Available Standard Modules

| Module | Description |
|--------|-------------|
| `math` | Mathematical functions |
| `fs` | File system operations |
| `net` | Networking |
| `os` | Operating system |
| `random` | Random number generation |

---

## 16. FFI (Foreign Function Interface)

### Declaring External Functions

```dolet
extern lib "user32.dll":
    fun MessageBoxA(hwnd: i64, text: str, caption: str, type: i32) -> i32

extern lib "vulkan-1.dll":
    fun vkCreateInstance(info: ptr, alloc: ptr, instance: ptr) -> i32
```

### Using External Functions

```dolet
# Call Windows API
MessageBoxA(0, "Hello!", "Dolet", 0)
```

> **Note:** Dolet has its own `Memory` module for memory operations — no need to import C's `malloc`/`free`. See [Standard Library](#17-standard-library).

---

## 17. Standard Library

### Built-in Functions

| Function | Description |
|----------|-------------|
| `print(value)` | Print to console |
| `addr(var)` | Get memory address of variable |

### Runtime Libraries (Auto-Imported)

These are automatically available in every Dolet program — no `import` needed:

#### Math (Pure Dolet)
```dolet
# Silicon functions (hardware or pure Dolet backed)
x = @sqrt(16.0)
y = @sin(3.14)

# Math struct utilities
r = Math.clamp_f32(value, 0.0, 1.0)
r = Math.lerp_f32(a, b, 0.5)
rad = Math.radians(90.0)
```

#### Memory (Pure Dolet)
```dolet
# Low-level memory operations
Memory.set(ptr, 0, size)          # memset
Memory.copy(dst, src, size)       # memcpy
ptr = Memory.malloc_zeroed(size)  # allocate zeroed memory
Memory.free(ptr)                  # free memory
val = Memory.read_f32(ptr)        # read float from pointer
Memory.write_f32(ptr, val)        # write float to pointer
```

### Importable Libraries

#### fs (File System)
```dolet
import fs
content = fs.read_file("data.txt")
fs.write_file("output.txt", content)
```

#### random
```dolet
import random
n = random.randint(1, 100)
```

### External Modules

| Module | Description |
|--------|-------------|
| `web` | Web server framework (standalone, uses kernel directly) |
| `mysql` | MySQL database (uses mysql dll) |
| `vulkan` | Vulkan graphics (uses vulkan-1.dll) |
| `qubic` | Game development (pure Dolet + vulkan/glfw) |
| `glfw` | Window/input handling (uses glfw3.dll) |
| `window` | Windowing (standalone, uses kernel directly) |
| `input` | Input handling (standalone, uses kernel directly) |

---

## 18. Context Blocks (RAII)

### Automatic Resource Management

```dolet
# File is automatically closed after block
File.open("data.txt", "r") as f:
    content = f.read()
    print(content)
# f.close() called automatically here

# Without binding (when return value not needed)
File.open("log.txt", "w"):
    # write operations
# auto close
```

---

## 🚀 Quick Reference

### Hello World
```dolet
print("Hello, World!")
```

### Variables
```dolet
name = "Dolet"
age: i32 = 1
const VERSION = "1.0"
```

### Functions
```dolet
fun add(a: i32, b: i32) -> i32:
    return a + b
```

### Structs
```dolet
struct Point:
    x: f32
    y: f32

p = Point(x=10.0, y=20.0)
```

### Loops
```dolet
for i in 0 to 10:
    print(i)
```

### Conditionals
```dolet
if x > 0:
    print("positive")
else:
    print("non-positive")
```

---

## 📝 Notes

- Dolet compiles to LLVM IR via MLIR for high performance
- The language is designed to be easy like Python but fast like C/Rust
- All access control is enforced at compile-time (zero-cost abstraction)
- Silicon functions use hardware instructions or pure Dolet polynomial approximations — **zero C runtime dependency**
- Math, Memory, and core runtime are 100% pure Dolet
- Only OS-level APIs (kernel32, user32, etc.) are used as external dependencies

---

*Generated for Dolet Compiler*
