-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [rename_attribute]
import Aeneas
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace rename_attribute

/- Trait declaration: [rename_attribute::BoolTrait]
   Source: 'tests/src/rename_attribute.rs', lines 9:0-19:1 -/
structure BoolTest (Self : Type) where
  getTest : Self → Result Bool
  retTest : Self → Result Bool

/- [rename_attribute::{rename_attribute::BoolTrait for bool}::get_bool]:
   Source: 'tests/src/rename_attribute.rs', lines 23:4-25:5 -/
def BoolTraitBool.getTest (self : Bool) : Result Bool :=
  ok self

/- [rename_attribute::{rename_attribute::BoolTrait for bool}::ret_true]:
   Source: 'tests/src/rename_attribute.rs', lines 16:4-18:5 -/
def BoolTraitBool.retTest (self : Bool) : Result Bool :=
  ok true

/- Trait implementation: [rename_attribute::{rename_attribute::BoolTrait for bool}]
   Source: 'tests/src/rename_attribute.rs', lines 22:0-26:1 -/
@[reducible]
def BoolImpl : BoolTest Bool := {
  getTest := BoolTraitBool.getTest
  retTest := BoolTraitBool.retTest
}

/- [rename_attribute::test_bool_trait]:
   Source: 'tests/src/rename_attribute.rs', lines 29:0-31:1 -/
def BoolFn (T : Type) (x : Bool) : Result Bool :=
  do
  let b ← BoolTraitBool.getTest x
  if b
  then BoolTraitBool.retTest x
  else ok false

/- [rename_attribute::SimpleEnum]
   Source: 'tests/src/rename_attribute.rs', lines 37:0-42:1 -/
inductive VariantsTest where
| Variant1 : VariantsTest
| SecondVariant : VariantsTest
| ThirdVariant : VariantsTest

/- [rename_attribute::Foo]
   Source: 'tests/src/rename_attribute.rs', lines 45:0-48:1 -/
structure StructTest where
  FieldTest : U32

/- [rename_attribute::C]
   Source: 'tests/src/rename_attribute.rs', lines 51:0-51:28 -/
@[global_simps]
def Const_Test_body : Result U32 := do
                                    let i ← 100#u32 + 10#u32
                                    i + 1#u32
@[global_simps, irreducible]
def Const_Test : U32 := eval_global Const_Test_body

/- [rename_attribute::CA]
   Source: 'tests/src/rename_attribute.rs', lines 54:0-54:23 -/
@[global_simps] def Const_Aeneas11_body : Result U32 := 10#u32 + 1#u32
@[global_simps, irreducible]
def Const_Aeneas11 : U32 := eval_global Const_Aeneas11_body

/- [rename_attribute::factorial]:
   Source: 'tests/src/rename_attribute.rs', lines 57:0-63:1 -/
def Factfn (n : U64) : Result U64 :=
  if n <= 1#u64
  then ok 1#u64
  else do
       let i ← n - 1#u64
       let i1 ← Factfn i
       n * i1
partial_fixpoint

/- [rename_attribute::sum]: loop 0:
   Source: 'tests/src/rename_attribute.rs', lines 69:4-72:5 -/
def No_borrows_sum_loop (max : U32) (i : U32) (s : U32) : Result U32 :=
  if i < max
  then do
       let s1 ← s + i
       let i1 ← i + 1#u32
       No_borrows_sum_loop max i1 s1
  else s * 2#u32
partial_fixpoint

/- [rename_attribute::sum]:
   Source: 'tests/src/rename_attribute.rs', lines 66:0-76:1 -/
@[reducible]
def No_borrows_sum (max : U32) : Result U32 :=
  No_borrows_sum_loop max 0#u32 0#u32

/- [rename_attribute::BoolTrait::ret_true]:
   Source: 'tests/src/rename_attribute.rs', lines 16:4-18:5 -/
def BoolTrait.retTest.default
  {Self : Type} (self_clause : BoolTest Self) (self : Self) : Result Bool :=
  ok true

end rename_attribute
