# Lexicographic

[![pipeline status](https://gitlab.com/gustavo.goretkin/Lexicographic.jl/badges/master/pipeline.svg)](https://gitlab.com/gustavo.goretkin/Lexicographic.jl/-/commits/master)
[![coverage report](https://gitlab.com/gustavo.goretkin/Lexicographic.jl/badges/master/coverage.svg)](https://gitlab.com/gustavo.goretkin/Lexicographic.jl/-/commits/master)
[![Build Status](https://travis-ci.com/goretkin/Lexicographic.jl.svg?branch=master)](https://travis-ci.com/goretkin/Lexicographic.jl)
[![Coverage Status](https://coveralls.io/repos/github/goretkin/Lexicographic.jl/badge.svg?branch=master)](https://coveralls.io/github/goretkin/Lexicographic.jl?branch=master)
[![codecov](https://codecov.io/gh/goretkin/Lexicographic.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/goretkin/Lexicographic.jl)

See: https://en.wikipedia.org/wiki/Lexicographical_order

## Design rationale

Julia's great support for multiple dispatch means that there are roughly two possibilities for encoding new behavior:

1. define new types and new methods that dispatch on those types
2. define new functions

This package defines new types, and extends existing ordering functions in `Base`: (`isequal`, `==`, `isless`)

This choice is consistent with defining new methods for

`*(::Complex{T}, ::Complex{T})`

instead of  defining

`complex_times(::NTuple{2, T}, ::NTuple{2,T})`

This is important not just for brevity, but also for consistency, because there's an implicit interface with `one`, `zero`, `:*`, `:+`, `inv`, `:\`. The alternative of defining `complex_plus`, `complex_one` means that an algorithm that could otherwise be generic cannot.

The implicit "ordering" interface in Julia is smaller, so there wouldn't be many `lexico_isless`, etc., but by defining a few methods, then `:<`, `:>`, `:<=`, `:>=` all work in a consistent manner.

For some discussion on these two possible approaches, see:
- https://discourse.julialang.org/t/designing-apis-defining-new-methods-versus-passing-in-functions/18699/11
- https://dspace.mit.edu/handle/1721.1/115964
