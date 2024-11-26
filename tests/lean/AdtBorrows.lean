-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [adt_borrows]
import Base
open Primitives
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace adt_borrows

/- [adt_borrows::SharedWrapper]
   Source: 'tests/src/adt-borrows.rs', lines 4:0-4:35 -/
@[reducible] def SharedWrapper (T : Type) := T

/- [adt_borrows::{adt_borrows::SharedWrapper<'a, T>}::create]:
   Source: 'tests/src/adt-borrows.rs', lines 7:4-9:5 -/
def SharedWrapper.create {T : Type} (x : T) : Result (SharedWrapper T) :=
  Result.ok x

/- [adt_borrows::{adt_borrows::SharedWrapper<'a, T>}::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 11:4-13:5 -/
def SharedWrapper.unwrap {T : Type} (self : SharedWrapper T) : Result T :=
  Result.ok self

/- [adt_borrows::MutWrapper]
   Source: 'tests/src/adt-borrows.rs', lines 16:0-16:36 -/
@[reducible] def MutWrapper (T : Type) := T

/- [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#1::create]:
   Source: 'tests/src/adt-borrows.rs', lines 19:4-21:5 -/
def MutWrapper.create
  {T : Type} (x : T) : Result ((MutWrapper T) × (MutWrapper T → T)) :=
  let back := fun ret => ret
  Result.ok (x, back)

/- [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#1::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 23:4-25:5 -/
def MutWrapper.unwrap
  {T : Type} (self : MutWrapper T) : Result (T × (T → MutWrapper T)) :=
  let back := fun ret => ret
  Result.ok (self, back)

end adt_borrows
