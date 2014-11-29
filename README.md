### Experimental C++11 backend for Idris

### Motivations for this
* I felt like improving my Haskell and Idris, and getting familiar with C++11
* ???

### Some features/benefits
* Easy interop with C++ and C, as well as with Objective-C/C++ (with a bit more work)
* UTF-8 support
* Callbacks from C/C++ (into Idris) support -- uses C++11's std::function
* With no tweaking yet, performance is pretty good, but not as fast as C backend

### Notes
* Uses C++11's shared_ptr (reference counting) for memory management, instead of gc (has pros and cons)
* C++11 stdlib has some unicode support (used by this backend)
* Currently using gcc/clang's __int128_t for quick-and-dirty big int support -- plan to switch to GMP (C++ version)
* No third-party libraries are currently needed or used for this backend
* Most of the official Idris tests run successfully -- see the [Makefile](https://github.com/andyarvanitis/idris-cplusplus/blob/master/Makefile)

### Some code examples
* UTF-8 support, so this works and produces "βγδ" as output (the C backend doesn't yet)
```Idris
module Main

greek : String
greek = "αβγδ"

main : IO ()
main = do
  putStrLn "Running Idris main"
  putStrLn $ "Greek: " ++ (strTail greek)
```
* Calling a C++ function, including registering for and receiving a callback
```C++
// twice.cpp
#include <functional>

int twice(std::function<int(int)> f, int n) {
  return f(f(n));
}
```
```idris
module Main

%include cpp "twice.hpp"
%link cpp "twice.o"

twice : (Int -> Int) -> Int -> IO Int
twice f x = mkForeign (FFun "twice(%0,%1)" [FFunction FInt FInt, FInt] FInt) f x

main : IO ()
main = do
  c <- twice (*3) 17
  print c
```
