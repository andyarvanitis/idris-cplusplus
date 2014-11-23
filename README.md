### Experimental C++11 backend for Idris

### Motivations for this
* I felt like improving my Haskell and Idris, and getting familiar with C++11
* ???
* Profit

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
* Most of the official tests run successfully -- see the [Makefile](https://github.com/andyarvanitis/idris-cplusplus/blob/master/Makefile)
