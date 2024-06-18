-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [bitwise]
import Base
open Primitives
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace bitwise

/- [bitwise::shift_u32]:
   Source: 'tests/src/bitwise.rs', lines 5:0-5:31 -/
def shift_u32 (a : U32) : Result U32 :=
  do
  let t ← a >>> 16#usize
  t <<< 16#usize

/- [bitwise::shift_i32]:
   Source: 'tests/src/bitwise.rs', lines 12:0-12:31 -/
def shift_i32 (a : I32) : Result I32 :=
  do
  let t ← a >>> 16#isize
  t <<< 16#isize

/- [bitwise::xor_u32]:
   Source: 'tests/src/bitwise.rs', lines 19:0-19:37 -/
def xor_u32 (a : U32) (b : U32) : Result U32 :=
  Result.ok (a ^^^ b)

/- [bitwise::or_u32]:
   Source: 'tests/src/bitwise.rs', lines 23:0-23:36 -/
def or_u32 (a : U32) (b : U32) : Result U32 :=
  Result.ok (a ||| b)

/- [bitwise::and_u32]:
   Source: 'tests/src/bitwise.rs', lines 27:0-27:37 -/
def and_u32 (a : U32) (b : U32) : Result U32 :=
  Result.ok (a &&& b)

end bitwise
