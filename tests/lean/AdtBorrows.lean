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

/- [adt_borrows::use_shared_wrapper]:
   Source: 'tests/src/adt-borrows.rs', lines 16:0-21:1 -/
def use_shared_wrapper : Result Unit :=
  do
  let w ← SharedWrapper.create 0#i32
  let p ← SharedWrapper.unwrap w
  massert (0#i32 = p)

/- [adt_borrows::SharedWrapper1]
   Source: 'tests/src/adt-borrows.rs', lines 23:0-25:1 -/
structure SharedWrapper1 (T : Type) where
  x : T

/- [adt_borrows::{adt_borrows::SharedWrapper1<'a, T>}#1::create]:
   Source: 'tests/src/adt-borrows.rs', lines 28:4-30:5 -/
def SharedWrapper1.create {T : Type} (x : T) : Result (SharedWrapper1 T) :=
  Result.ok { x }

/- [adt_borrows::{adt_borrows::SharedWrapper1<'a, T>}#1::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 32:4-34:5 -/
def SharedWrapper1.unwrap {T : Type} (self : SharedWrapper1 T) : Result T :=
  Result.ok self.x

/- [adt_borrows::use_shared_wrapper1]:
   Source: 'tests/src/adt-borrows.rs', lines 37:0-42:1 -/
def use_shared_wrapper1 : Result Unit :=
  do
  let w ← SharedWrapper1.create 0#i32
  let p ← SharedWrapper1.unwrap w
  massert (0#i32 = p)

/- [adt_borrows::SharedWrapper2]
   Source: 'tests/src/adt-borrows.rs', lines 44:0-47:1 -/
structure SharedWrapper2 (T : Type) where
  x : T
  y : T

/- [adt_borrows::{adt_borrows::SharedWrapper2<'a, 'b, T>}#2::create]:
   Source: 'tests/src/adt-borrows.rs', lines 50:4-52:5 -/
def SharedWrapper2.create
  {T : Type} (x : T) (y : T) : Result (SharedWrapper2 T) :=
  Result.ok { x, y }

/- [adt_borrows::{adt_borrows::SharedWrapper2<'a, 'b, T>}#2::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 54:4-56:5 -/
def SharedWrapper2.unwrap
  {T : Type} (self : SharedWrapper2 T) : Result (T × T) :=
  Result.ok (self.x, self.y)

/- [adt_borrows::use_shared_wrapper2]:
   Source: 'tests/src/adt-borrows.rs', lines 59:0-66:1 -/
def use_shared_wrapper2 : Result Unit :=
  do
  let w ← SharedWrapper2.create 0#i32 1#i32
  let p ← SharedWrapper2.unwrap w
  let (px, py) := p
  massert (0#i32 = px)
  massert (1#i32 = py)

/- [adt_borrows::MutWrapper]
   Source: 'tests/src/adt-borrows.rs', lines 68:0-68:36 -/
@[reducible] def MutWrapper (T : Type) := T

/- [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#3::create]:
   Source: 'tests/src/adt-borrows.rs', lines 71:4-73:5 -/
def MutWrapper.create
  {T : Type} (x : T) : Result ((MutWrapper T) × (MutWrapper T → T)) :=
  let back := fun ret => ret
  Result.ok (x, back)

/- [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#3::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 75:4-77:5 -/
def MutWrapper.unwrap
  {T : Type} (self : MutWrapper T) : Result (T × (T → MutWrapper T)) :=
  let back := fun ret => ret
  Result.ok (self, back)

/- [adt_borrows::use_mut_wrapper]:
   Source: 'tests/src/adt-borrows.rs', lines 80:0-86:1 -/
def use_mut_wrapper : Result Unit :=
  do
  let (w, create_back) ← MutWrapper.create 0#i32
  let (p, unwrap_back) ← MutWrapper.unwrap w
  let p1 ← p + 1#i32
  let x := create_back (unwrap_back p1)
  massert (x = 1#i32)

/- [adt_borrows::MutWrapper1]
   Source: 'tests/src/adt-borrows.rs', lines 88:0-90:1 -/
structure MutWrapper1 (T : Type) where
  x : T

/- [adt_borrows::{adt_borrows::MutWrapper1<'a, T>}#4::create]:
   Source: 'tests/src/adt-borrows.rs', lines 93:4-95:5 -/
def MutWrapper1.create
  {T : Type} (x : T) : Result ((MutWrapper1 T) × (MutWrapper1 T → T)) :=
  let back := fun ret => ret.x
  Result.ok ({ x }, back)

/- [adt_borrows::{adt_borrows::MutWrapper1<'a, T>}#4::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 97:4-99:5 -/
def MutWrapper1.unwrap
  {T : Type} (self : MutWrapper1 T) : Result (T × (T → MutWrapper1 T)) :=
  let back := fun ret => { x := ret }
  Result.ok (self.x, back)

/- [adt_borrows::use_mut_wrapper1]:
   Source: 'tests/src/adt-borrows.rs', lines 102:0-108:1 -/
def use_mut_wrapper1 : Result Unit :=
  do
  let (w, create_back) ← MutWrapper1.create 0#i32
  let (p, unwrap_back) ← MutWrapper1.unwrap w
  let p1 ← p + 1#i32
  let x := create_back (unwrap_back p1)
  massert (x = 1#i32)

/- [adt_borrows::MutWrapper2]
   Source: 'tests/src/adt-borrows.rs', lines 110:0-113:1 -/
structure MutWrapper2 (T : Type) where
  x : T
  y : T

/- [adt_borrows::{adt_borrows::MutWrapper2<'a, 'b, T>}#5::create]:
   Source: 'tests/src/adt-borrows.rs', lines 116:4-118:5 -/
def MutWrapper2.create
  {T : Type} (x : T) (y : T) :
  Result ((MutWrapper2 T) × (MutWrapper2 T → T) × (MutWrapper2 T → T))
  :=
  let back'a := fun ret => ret.x
  let back'b := fun ret => ret.y
  Result.ok ({ x, y }, back'a, back'b)

/- [adt_borrows::{adt_borrows::MutWrapper2<'a, 'b, T>}#5::unwrap]:
   Source: 'tests/src/adt-borrows.rs', lines 120:4-122:5 -/
def MutWrapper2.unwrap
  {T : Type} (self : MutWrapper2 T) :
  Result ((T × T) × (T → MutWrapper2 T) × (T → MutWrapper2 T))
  :=
  let back'a := fun ret => { self with x := ret }
  let back'b := fun ret => { self with y := ret }
  Result.ok ((self.x, self.y), back'a, back'b)

/- [adt_borrows::use_mut_wrapper2]:
   Source: 'tests/src/adt-borrows.rs', lines 125:0-134:1 -/
def use_mut_wrapper2 : Result Unit :=
  do
  let (w, create_back, create_back1) ← MutWrapper2.create 0#i32 10#i32
  let (p, unwrap_back, unwrap_back1) ← MutWrapper2.unwrap w
  let (px, py) := p
  let px1 ← px + 1#i32
  let py1 ← py + 1#i32
  let x := create_back { w with x := (unwrap_back px1).x }
  massert (x = 1#i32)
  let y := create_back1 { w with y := (unwrap_back1 py1).y }
  massert (y = 11#i32)

end adt_borrows
