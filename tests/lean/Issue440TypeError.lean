-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [issue_440_type_error]
import Aeneas
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace issue_440_type_error

/- [issue_440_type_error::PeanoNum]
   Source: 'tests/src/issue-440-type-error.rs', lines 3:0-6:1 -/
inductive PeanoNum where
| Zero : PeanoNum
| Succ : PeanoNum → PeanoNum

/- [issue_440_type_error::f]:
   Source: 'tests/src/issue-440-type-error.rs', lines 8:0-15:1 -/
def f (x : PeanoNum) (value : Isize) : Result PeanoNum :=
  match x with
  | PeanoNum.Zero =>
    let (_, x1) := core.mem.replace PeanoNum.Zero (PeanoNum.Succ PeanoNum.Zero)
    ok x1
  | PeanoNum.Succ _ => ok x

end issue_440_type_error
