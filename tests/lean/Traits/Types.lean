-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [traits]: type definitions
import Base
open Primitives

namespace traits

/- Trait declaration: [traits::BoolTrait] -/
structure BoolTrait (Self : Type) where
  get_bool : Self → Result Bool

/- Trait declaration: [traits::ToU64] -/
structure ToU64 (Self : Type) where
  to_u64 : Self → Result U64

/- [traits::Wrapper] -/
structure Wrapper (T : Type) where
  x : T

/- Trait declaration: [traits::ToType] -/
structure ToType (Self T : Type) where
  to_type : Self → Result T

/- Trait declaration: [traits::OfType] -/
structure OfType (Self : Type) where
  of_type : forall (T : Type) (inst : ToType T Self), T → Result Self

/- Trait declaration: [traits::OfTypeBis] -/
structure OfTypeBis (Self T : Type) where
  parent_clause_0 : ToType T Self
  of_type : T → Result Self

/- [traits::TestType] -/
structure TestType (T : Type) where
  _0 : T

/- [traits::TestType::{6}::test::TestType1] -/
structure TestType.test.TestType1 where
  _0 : U64

/- Trait declaration: [traits::TestType::{6}::test::TestTrait] -/
structure TestType.test.TestTrait (Self : Type) where
  test : Self → Result Bool

/- [traits::BoolWrapper] -/
structure BoolWrapper where
  _0 : Bool

/- Trait declaration: [traits::WithConstTy] -/
structure WithConstTy (Self : Type) (LEN : Usize) where
  LEN1 : Usize
  LEN2 : Usize
  V : Type
  W : Type
  W_clause_0 : ToU64 W
  f : W → Array U8 LEN → Result W

/- [alloc::string::String] -/
axiom alloc.string.String : Type

/- Trait declaration: [traits::ParentTrait0] -/
structure ParentTrait0 (Self : Type) where
  W : Type
  get_name : Self → Result alloc.string.String
  get_w : Self → Result W

/- Trait declaration: [traits::ParentTrait1] -/
structure ParentTrait1 (Self : Type) where

/- Trait declaration: [traits::ChildTrait] -/
structure ChildTrait (Self : Type) where
  parent_clause_0 : ParentTrait0 Self
  parent_clause_1 : ParentTrait1 Self

/- Trait declaration: [traits::ChildTrait1] -/
structure ChildTrait1 (Self : Type) where
  parent_clause_0 : ParentTrait1 Self

/- Trait declaration: [traits::Iterator] -/
structure Iterator (Self : Type) where
  Item : Type

/- Trait declaration: [traits::IntoIterator] -/
structure IntoIterator (Self : Type) where
  Item : Type
  IntoIter : Type
  IntoIter_clause_0 : Iterator IntoIter
  into_iter : Self → Result IntoIter

/- Trait declaration: [traits::FromResidual] -/
structure FromResidual (Self T : Type) where

/- Trait declaration: [traits::Try] -/
structure Try (Self : Type) where
  parent_clause_0 : FromResidual Self Residual
  Residual : Type

/- Trait declaration: [traits::CFnOnce] -/
structure CFnOnce (Self Args : Type) where
  Output : Type
  call_once : Self → Args → Result Output

/- Trait declaration: [traits::CFnMut] -/
structure CFnMut (Self Args : Type) where
  parent_clause_0 : CFnOnce Self Args
  call_mut : Self → Args → Result parent_clause_0.Output
  call_mut_back : Self → Args → parent_clause_0.Output → Result Self

/- Trait declaration: [traits::CFn] -/
structure CFn (Self Args : Type) where
  parent_clause_0 : CFnMut Self Args
  call_mut : Self → Args → Result parent_clause_0.parent_clause_0.Output

/- Trait declaration: [core::ops::function::FnOnce] -/
structure core.ops.function.FnOnce (Self Args : Type) where
  Output : Type
  call_once : Self → Args → Result Output

/- Trait declaration: [core::ops::function::FnMut] -/
structure core.ops.function.FnMut (Self Args : Type) where
  parent_clause_0 : core.ops.function.FnOnce Self Args
  call_mut : Self → Args → Result parent_clause_0.Output
  call_mut_back : Self → Args → parent_clause_0.Output → Result Self

/- Trait declaration: [core::ops::function::Fn] -/
structure core.ops.function.Fn (Self Args : Type) where
  parent_clause_0 : core.ops.function.FnMut Self Args
  call : Self → Args → Result parent_clause_0.parent_clause_0.Output

/- Trait declaration: [traits::WithTarget] -/
structure WithTarget (Self : Type) where
  Target : Type

/- Trait declaration: [traits::ParentTrait2] -/
structure ParentTrait2 (Self : Type) where
  U : Type
  U_clause_0 : WithTarget U

/- Trait declaration: [traits::ChildTrait2] -/
structure ChildTrait2 (Self : Type) where
  parent_clause_0 : ParentTrait2 Self
  convert : parent_clause_0.U → Result parent_clause_0.U_clause_0.Target

end traits
