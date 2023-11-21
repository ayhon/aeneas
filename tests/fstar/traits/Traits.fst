(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [traits] *)
module Traits
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** Trait declaration: [traits::BoolTrait] *)
noeq type boolTrait_t (self : Type0) = { get_bool : self -> result bool; }

(** [traits::{bool}::get_bool]: forward function *)
let bool_get_bool (self : bool) : result bool =
  Return self

(** Trait implementation: [traits::{bool}] *)
let traits_BoolTraitBoolInst : boolTrait_t bool = { get_bool = bool_get_bool; }

(** [traits::BoolTrait::ret_true]: forward function *)
let boolTrait_ret_true
  (#self : Type0) (self_clause : boolTrait_t self) (self0 : self) :
  result bool
  =
  Return true

(** [traits::test_bool_trait_bool]: forward function *)
let test_bool_trait_bool (x : bool) : result bool =
  let* b = bool_get_bool x in
  if b then boolTrait_ret_true traits_BoolTraitBoolInst x else Return false

(** [traits::{core::option::Option<T>#1}::get_bool]: forward function *)
let option_get_bool (t : Type0) (self : option t) : result bool =
  begin match self with | None -> Return false | Some x -> Return true end

(** Trait implementation: [traits::{core::option::Option<T>#1}] *)
let traits_BoolTraitcoreoptionOptionTInst (t : Type0) : boolTrait_t (option t)
  = {
  get_bool = option_get_bool t;
}

(** [traits::test_bool_trait_option]: forward function *)
let test_bool_trait_option (t : Type0) (x : option t) : result bool =
  let* b = option_get_bool t x in
  if b
  then boolTrait_ret_true (traits_BoolTraitcoreoptionOptionTInst t) x
  else Return false

(** [traits::test_bool_trait]: forward function *)
let test_bool_trait (t : Type0) (inst : boolTrait_t t) (x : t) : result bool =
  inst.get_bool x

(** Trait declaration: [traits::ToU64] *)
noeq type toU64_t (self : Type0) = { to_u64 : self -> result u64; }

(** [traits::{u64#2}::to_u64]: forward function *)
let u64_to_u64 (self : u64) : result u64 =
  Return self

(** Trait implementation: [traits::{u64#2}] *)
let traits_ToU64U64Inst : toU64_t u64 = { to_u64 = u64_to_u64; }

(** [traits::{(A, A)#3}::to_u64]: forward function *)
let pair_to_u64 (a : Type0) (inst : toU64_t a) (self : (a & a)) : result u64 =
  let (x, x0) = self in
  let* i = inst.to_u64 x in
  let* i0 = inst.to_u64 x0 in
  u64_add i i0

(** Trait implementation: [traits::{(A, A)#3}] *)
let traits_ToU64TupleAAInst (a : Type0) (inst : toU64_t a) : toU64_t (a & a)
  = {
  to_u64 = pair_to_u64 a inst;
}

(** [traits::f]: forward function *)
let f (t : Type0) (inst : toU64_t t) (x : (t & t)) : result u64 =
  pair_to_u64 t inst x

(** [traits::g]: forward function *)
let g (t : Type0) (inst : toU64_t (t & t)) (x : (t & t)) : result u64 =
  inst.to_u64 x

(** [traits::h0]: forward function *)
let h0 (x : u64) : result u64 =
  u64_to_u64 x

(** [traits::Wrapper] *)
type wrapper_t (t : Type0) = { x : t; }

(** [traits::{traits::Wrapper<T>#4}::to_u64]: forward function *)
let wrapper_to_u64
  (t : Type0) (inst : toU64_t t) (self : wrapper_t t) : result u64 =
  inst.to_u64 self.x

(** Trait implementation: [traits::{traits::Wrapper<T>#4}] *)
let traits_ToU64traitsWrapperTInst (t : Type0) (inst : toU64_t t) : toU64_t
  (wrapper_t t) = {
  to_u64 = wrapper_to_u64 t inst;
}

(** [traits::h1]: forward function *)
let h1 (x : wrapper_t u64) : result u64 =
  wrapper_to_u64 u64 traits_ToU64U64Inst x

(** [traits::h2]: forward function *)
let h2 (t : Type0) (inst : toU64_t t) (x : wrapper_t t) : result u64 =
  wrapper_to_u64 t inst x

(** Trait declaration: [traits::ToType] *)
noeq type toType_t (self t : Type0) = { to_type : self -> result t; }

(** [traits::{u64#5}::to_type]: forward function *)
let u64_to_type (self : u64) : result bool =
  Return (self > 0)

(** Trait implementation: [traits::{u64#5}] *)
let traits_ToTypeU64BoolInst : toType_t u64 bool = { to_type = u64_to_type; }

(** Trait declaration: [traits::OfType] *)
noeq type ofType_t (self : Type0) = {
  of_type : (t : Type0) -> (inst : toType_t t self) -> t -> result self;
}

(** [traits::h3]: forward function *)
let h3
  (t1 t2 : Type0) (inst : ofType_t t1) (inst0 : toType_t t2 t1) (y : t2) :
  result t1
  =
  inst.of_type t2 inst0 y

(** Trait declaration: [traits::OfTypeBis] *)
noeq type ofTypeBis_t (self t : Type0) = {
  parent_clause_0 : toType_t t self;
  of_type : t -> result self;
}

(** [traits::h4]: forward function *)
let h4
  (t1 t2 : Type0) (inst : ofTypeBis_t t1 t2) (inst0 : toType_t t2 t1) 
  (y : t2) :
  result t1
  =
  inst.of_type y

(** [traits::TestType] *)
type testType_t (t : Type0) = { _0 : t; }

(** [traits::{traits::TestType<T>#6}::test::TestType1] *)
type testType_test_TestType1_t = { _0 : u64; }

(** Trait declaration: [traits::{traits::TestType<T>#6}::test::TestTrait] *)
noeq type testType_test_TestTrait_t (self : Type0) = {
  test : self -> result bool;
}

(** [traits::{traits::TestType<T>#6}::test::{traits::{traits::TestType<T>#6}::test::TestType1}::test]: forward function *)
let testType_test_TestType1_test
  (self : testType_test_TestType1_t) : result bool =
  Return (self._0 > 1)

(** Trait implementation: [traits::{traits::TestType<T>#6}::test::{traits::{traits::TestType<T>#6}::test::TestType1}] *)
let traits_TestType_test_TestTraittraitstraitsTestTypeTtestTestType1Inst :
  testType_test_TestTrait_t testType_test_TestType1_t = {
  test = testType_test_TestType1_test;
}

(** [traits::{traits::TestType<T>#6}::test]: forward function *)
let testType_test
  (t : Type0) (inst : toU64_t t) (self : testType_t t) (x : t) : result bool =
  let* x0 = inst.to_u64 x in
  if x0 > 0 then testType_test_TestType1_test { _0 = 0 } else Return false

(** [traits::BoolWrapper] *)
type boolWrapper_t = { _0 : bool; }

(** [traits::{traits::BoolWrapper#7}::to_type]: forward function *)
let boolWrapper_to_type
  (t : Type0) (inst : toType_t bool t) (self : boolWrapper_t) : result t =
  inst.to_type self._0

(** Trait implementation: [traits::{traits::BoolWrapper#7}] *)
let traits_ToTypetraitsBoolWrapperTInst (t : Type0) (inst : toType_t bool t) :
  toType_t boolWrapper_t t = {
  to_type = boolWrapper_to_type t inst;
}

(** [traits::WithConstTy::LEN2] *)
let with_const_ty_len2_body : result usize = Return 32
let with_const_ty_len2_c : usize = eval_global with_const_ty_len2_body

(** Trait declaration: [traits::WithConstTy] *)
noeq type withConstTy_t (self : Type0) (len : usize) = {
  cLEN1 : usize;
  cLEN2 : usize;
  tV : Type0;
  tW : Type0;
  tW_clause_0 : toU64_t tW;
  f : tW -> array u8 len -> result tW;
}

(** [traits::{bool#8}::LEN1] *)
let bool_len1_body : result usize = Return 12
let bool_len1_c : usize = eval_global bool_len1_body

(** [traits::{bool#8}::f]: merged forward/backward function
    (there is a single backward function, and the forward function returns ()) *)
let bool_f (i : u64) (a : array u8 32) : result u64 =
  Return i

(** Trait implementation: [traits::{bool#8}] *)
let traits_WithConstTyBool32Inst : withConstTy_t bool 32 = {
  cLEN1 = bool_len1_c;
  cLEN2 = with_const_ty_len2_c;
  tV = u8;
  tW = u64;
  tW_clause_0 = traits_ToU64U64Inst;
  f = bool_f;
}

(** [traits::use_with_const_ty1]: forward function *)
let use_with_const_ty1
  (h : Type0) (len : usize) (inst : withConstTy_t h len) : result usize =
  let i = inst.cLEN1 in Return i

(** [traits::use_with_const_ty2]: forward function *)
let use_with_const_ty2
  (h : Type0) (len : usize) (inst : withConstTy_t h len) (w : inst.tW) :
  result unit
  =
  Return ()

(** [traits::use_with_const_ty3]: forward function *)
let use_with_const_ty3
  (h : Type0) (len : usize) (inst : withConstTy_t h len) (x : inst.tW) :
  result u64
  =
  inst.tW_clause_0.to_u64 x

(** [traits::test_where1]: forward function *)
let test_where1 (t : Type0) (_x : t) : result unit =
  Return ()

(** [traits::test_where2]: forward function *)
let test_where2
  (t : Type0) (inst : withConstTy_t t 32) (_x : u32) : result unit =
  Return ()

(** [alloc::string::String] *)
assume type alloc_string_String_t : Type0

(** Trait declaration: [traits::ParentTrait0] *)
noeq type parentTrait0_t (self : Type0) = {
  tW : Type0;
  get_name : self -> result alloc_string_String_t;
  get_w : self -> result tW;
}

(** Trait declaration: [traits::ParentTrait1] *)
type parentTrait1_t (self : Type0) = unit

(** Trait declaration: [traits::ChildTrait] *)
noeq type childTrait_t (self : Type0) = {
  parent_clause_0 : parentTrait0_t self;
  parent_clause_1 : parentTrait1_t self;
}

(** [traits::test_child_trait1]: forward function *)
let test_child_trait1
  (t : Type0) (inst : childTrait_t t) (x : t) : result alloc_string_String_t =
  inst.parent_clause_0.get_name x

(** [traits::test_child_trait2]: forward function *)
let test_child_trait2
  (t : Type0) (inst : childTrait_t t) (x : t) :
  result inst.parent_clause_0.tW
  =
  inst.parent_clause_0.get_w x

(** [traits::order1]: forward function *)
let order1
  (t u : Type0) (inst : parentTrait0_t t) (inst0 : parentTrait0_t u) :
  result unit
  =
  Return ()

(** Trait declaration: [traits::ChildTrait1] *)
noeq type childTrait1_t (self : Type0) = {
  parent_clause_0 : parentTrait1_t self;
}

(** Trait implementation: [traits::{usize#9}] *)
let traits_ParentTrait1UsizeInst : parentTrait1_t usize = ()

(** Trait implementation: [traits::{usize#10}] *)
let traits_ChildTrait1UsizeInst : childTrait1_t usize = {
  parent_clause_0 = traits_ParentTrait1UsizeInst;
}

(** Trait declaration: [traits::Iterator] *)
noeq type iterator_t (self : Type0) = { tItem : Type0; }

(** Trait declaration: [traits::IntoIterator] *)
noeq type intoIterator_t (self : Type0) = {
  tItem : Type0;
  tIntoIter : Type0;
  tIntoIter_clause_0 : iterator_t tIntoIter;
  into_iter : self -> result tIntoIter;
}

(** Trait declaration: [traits::FromResidual] *)
type fromResidual_t (self t : Type0) = unit

(** Trait declaration: [traits::Try] *)
noeq type try_t (self : Type0) = {
  tResidual : Type0;
  parent_clause_0 : fromResidual_t self tResidual;
}

(** Trait declaration: [traits::WithTarget] *)
noeq type withTarget_t (self : Type0) = { tTarget : Type0; }

(** Trait declaration: [traits::ParentTrait2] *)
noeq type parentTrait2_t (self : Type0) = {
  tU : Type0;
  tU_clause_0 : withTarget_t tU;
}

(** Trait declaration: [traits::ChildTrait2] *)
noeq type childTrait2_t (self : Type0) = {
  parent_clause_0 : parentTrait2_t self;
  convert : parent_clause_0.tU -> result parent_clause_0.tU_clause_0.tTarget;
}

(** Trait implementation: [traits::{u32#11}] *)
let traits_WithTargetU32Inst : withTarget_t u32 = { tTarget = u32; }

(** Trait implementation: [traits::{u32#12}] *)
let traits_ParentTrait2U32Inst : parentTrait2_t u32 = {
  tU = u32;
  tU_clause_0 = traits_WithTargetU32Inst;
}

(** [traits::{u32#13}::convert]: forward function *)
let u32_convert (x : u32) : result u32 =
  Return x

(** Trait implementation: [traits::{u32#13}] *)
let traits_ChildTrait2U32Inst : childTrait2_t u32 = {
  parent_clause_0 = traits_ParentTrait2U32Inst;
  convert = u32_convert;
}

(** Trait declaration: [traits::CFnOnce] *)
noeq type cFnOnce_t (self args : Type0) = {
  tOutput : Type0;
  call_once : self -> args -> result tOutput;
}

(** Trait declaration: [traits::CFnMut] *)
noeq type cFnMut_t (self args : Type0) = {
  parent_clause_0 : cFnOnce_t self args;
  call_mut : self -> args -> result parent_clause_0.tOutput;
  call_mut_back : self -> args -> parent_clause_0.tOutput -> result self;
}

(** Trait declaration: [traits::CFn] *)
noeq type cFn_t (self args : Type0) = {
  parent_clause_0 : cFnMut_t self args;
  call_mut : self -> args -> result parent_clause_0.parent_clause_0.tOutput;
}

(** [traits::incr_u32]: forward function *)
let incr_u32 (x : u32) : result u32 =
  u32_add x 1

