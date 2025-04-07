(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [no_nested_borrows] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module NoNestedBorrows.

(** [no_nested_borrows::Pair]
    Source: 'tests/src/no_nested_borrows.rs', lines 7:0-10:1 *)
Record Pair_t (T1 : Type) (T2 : Type) :=
mkPair_t {
  pair_x : T1; pair_y : T2;
}
.

Arguments mkPair_t { _ } { _ }.
Arguments pair_x { _ } { _ }.
Arguments pair_y { _ } { _ }.

(** [no_nested_borrows::List]
    Source: 'tests/src/no_nested_borrows.rs', lines 12:0-15:1 *)
Inductive List_t (T : Type) :=
| List_Cons : T -> List_t T -> List_t T
| List_Nil : List_t T
.

Arguments List_Cons { _ }.
Arguments List_Nil { _ }.

(** [no_nested_borrows::One]
    Source: 'tests/src/no_nested_borrows.rs', lines 23:0-25:1 *)
Inductive One_t (T1 : Type) := | One_One : T1 -> One_t T1.

Arguments One_One { _ }.

(** [no_nested_borrows::EmptyEnum]
    Source: 'tests/src/no_nested_borrows.rs', lines 29:0-31:1 *)
Inductive EmptyEnum_t := | EmptyEnum_Empty : EmptyEnum_t.

(** [no_nested_borrows::Enum]
    Source: 'tests/src/no_nested_borrows.rs', lines 35:0-38:1 *)
Inductive Enum_t := | Enum_Variant1 : Enum_t | Enum_Variant2 : Enum_t.

(** [no_nested_borrows::EmptyStruct]
    Source: 'tests/src/no_nested_borrows.rs', lines 42:0-42:25 *)
Definition EmptyStruct_t : Type := unit.

(** [no_nested_borrows::Sum]
    Source: 'tests/src/no_nested_borrows.rs', lines 44:0-47:1 *)
Inductive Sum_t (T1 : Type) (T2 : Type) :=
| Sum_Left : T1 -> Sum_t T1 T2
| Sum_Right : T2 -> Sum_t T1 T2
.

Arguments Sum_Left { _ } { _ }.
Arguments Sum_Right { _ } { _ }.

(** [no_nested_borrows::cast_u32_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 49:0-51:1 *)
Definition cast_u32_to_i32 (x : u32) : result i32 :=
  scalar_cast U32 I32 x.

(** [no_nested_borrows::cast_bool_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 53:0-55:1 *)
Definition cast_bool_to_i32 (x : bool) : result i32 :=
  scalar_cast_bool I32 x.

(** [no_nested_borrows::cast_bool_to_bool]:
    Source: 'tests/src/no_nested_borrows.rs', lines 58:0-60:1 *)
Definition cast_bool_to_bool (x : bool) : result bool :=
  Ok x.

(** [no_nested_borrows::test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 63:0-73:1 *)
Definition test2 : result unit :=
  _ <- u32_add 23%u32 44%u32; Ok tt.

(** Unit test for [no_nested_borrows::test2] *)
Check (test2)%return.

(** [no_nested_borrows::get_max]:
    Source: 'tests/src/no_nested_borrows.rs', lines 75:0-81:1 *)
Definition get_max (x : u32) (y : u32) : result u32 :=
  if x s>= y then Ok x else Ok y
.

(** [no_nested_borrows::test3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 83:0-88:1 *)
Definition test3 : result unit :=
  x <- get_max 4%u32 3%u32;
  y <- get_max 10%u32 11%u32;
  z <- u32_add x y;
  massert (z s= 15%u32)
.

(** Unit test for [no_nested_borrows::test3] *)
Check (test3)%return.

(** [no_nested_borrows::test_neg1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 90:0-94:1 *)
Definition test_neg1 : result unit :=
  y <- i32_neg 3%i32; massert (y s= (-3)%i32)
.

(** Unit test for [no_nested_borrows::test_neg1] *)
Check (test_neg1)%return.

(** [no_nested_borrows::refs_test1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 97:0-106:1 *)
Definition refs_test1 : result unit :=
  massert (1%i32 s= 1%i32).

(** Unit test for [no_nested_borrows::refs_test1] *)
Check (refs_test1)%return.

(** [no_nested_borrows::refs_test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 108:0-120:1 *)
Definition refs_test2 : result unit :=
  _ <- massert (2%i32 s= 2%i32);
  _ <- massert (0%i32 s= 0%i32);
  _ <- massert (2%i32 s= 2%i32);
  massert (2%i32 s= 2%i32)
.

(** Unit test for [no_nested_borrows::refs_test2] *)
Check (refs_test2)%return.

(** [no_nested_borrows::test_list1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 124:0-126:1 *)
Definition test_list1 : result unit :=
  Ok tt.

(** Unit test for [no_nested_borrows::test_list1] *)
Check (test_list1)%return.

(** [no_nested_borrows::copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 128:0-130:1 *)
Definition copy_int (x : i32) : result i32 :=
  Ok x.

(** [no_nested_borrows::test_unreachable]:
    Source: 'tests/src/no_nested_borrows.rs', lines 134:0-138:1 *)
Definition test_unreachable (b : bool) : result unit :=
  massert b.

(** [no_nested_borrows::test_panic]:
    Source: 'tests/src/no_nested_borrows.rs', lines 141:0-145:1 *)
Definition test_panic (b : bool) : result unit :=
  massert b.

(** [no_nested_borrows::test_panic_msg]:
    Source: 'tests/src/no_nested_borrows.rs', lines 149:0-153:1 *)
Definition test_panic_msg (b : bool) : result unit :=
  massert b.

(** [no_nested_borrows::test_copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 156:0-161:1 *)
Definition test_copy_int : result unit :=
  y <- copy_int 0%i32; massert (0%i32 s= y)
.

(** Unit test for [no_nested_borrows::test_copy_int] *)
Check (test_copy_int)%return.

(** [no_nested_borrows::is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 163:0-168:1 *)
Definition is_cons {T : Type} (l : List_t T) : result bool :=
  match l with | List_Cons _ _ => Ok true | List_Nil => Ok false end
.

(** [no_nested_borrows::test_is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 170:0-174:1 *)
Definition test_is_cons : result unit :=
  b <- is_cons (List_Cons 0%i32 List_Nil); massert b
.

(** Unit test for [no_nested_borrows::test_is_cons] *)
Check (test_is_cons)%return.

(** [no_nested_borrows::split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 176:0-181:1 *)
Definition split_list {T : Type} (l : List_t T) : result (T * (List_t T)) :=
  match l with | List_Cons hd tl => Ok (hd, tl) | List_Nil => Fail_ Failure end
.

(** [no_nested_borrows::test_split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 184:0-189:1 *)
Definition test_split_list : result unit :=
  p <- split_list (List_Cons 0%i32 List_Nil);
  let (hd, _) := p in
  massert (hd s= 0%i32)
.

(** Unit test for [no_nested_borrows::test_split_list] *)
Check (test_split_list)%return.

(** [no_nested_borrows::choose]:
    Source: 'tests/src/no_nested_borrows.rs', lines 191:0-197:1 *)
Definition choose
  {T : Type} (b : bool) (x : T) (y : T) : result (T * (T -> (T * T))) :=
  if b
  then let back := fun (ret : T) => (ret, y) in Ok (x, back)
  else let back := fun (ret : T) => (x, ret) in Ok (y, back)
.

(** [no_nested_borrows::choose_test]:
    Source: 'tests/src/no_nested_borrows.rs', lines 199:0-208:1 *)
Definition choose_test : result unit :=
  p <- choose true 0%i32 0%i32;
  let (z, choose_back) := p in
  z1 <- i32_add z 1%i32;
  _ <- massert (z1 s= 1%i32);
  let (x, y) := choose_back z1 in
  _ <- massert (x s= 1%i32);
  massert (y s= 0%i32)
.

(** Unit test for [no_nested_borrows::choose_test] *)
Check (choose_test)%return.

(** [no_nested_borrows::test_char]:
    Source: 'tests/src/no_nested_borrows.rs', lines 211:0-213:1 *)
Definition test_char : result char :=
  Ok (char_of_byte Coq.Init.Byte.x61).

(** [no_nested_borrows::panic_mut_borrow]:
    Source: 'tests/src/no_nested_borrows.rs', lines 216:0-218:1 *)
Definition panic_mut_borrow (i : u32) : result u32 :=
  Fail_ Failure.

(** [no_nested_borrows::Tree]
    Source: 'tests/src/no_nested_borrows.rs', lines 221:0-224:1 *)
Inductive Tree_t (T : Type) :=
| Tree_Leaf : T -> Tree_t T
| Tree_Node : T -> NodeElem_t T -> Tree_t T -> Tree_t T

(** [no_nested_borrows::NodeElem]
    Source: 'tests/src/no_nested_borrows.rs', lines 226:0-229:1 *)
with NodeElem_t (T : Type) :=
| NodeElem_Cons : Tree_t T -> NodeElem_t T -> NodeElem_t T
| NodeElem_Nil : NodeElem_t T
.

Arguments Tree_Leaf { _ }.
Arguments Tree_Node { _ }.

Arguments NodeElem_Cons { _ }.
Arguments NodeElem_Nil { _ }.

(** [no_nested_borrows::list_length]:
    Source: 'tests/src/no_nested_borrows.rs', lines 261:0-266:1 *)
Fixpoint list_length {T : Type} (l : List_t T) : result u32 :=
  match l with
  | List_Cons _ l1 => i <- list_length l1; u32_add 1%u32 i
  | List_Nil => Ok 0%u32
  end
.

(** [no_nested_borrows::list_nth_shared]:
    Source: 'tests/src/no_nested_borrows.rs', lines 269:0-282:1 *)
Fixpoint list_nth_shared {T : Type} (l : List_t T) (i : u32) : result T :=
  match l with
  | List_Cons x tl =>
    if i s= 0%u32 then Ok x else (i1 <- u32_sub i 1%u32; list_nth_shared tl i1)
  | List_Nil => Fail_ Failure
  end
.

(** [no_nested_borrows::list_nth_mut]:
    Source: 'tests/src/no_nested_borrows.rs', lines 285:0-298:1 *)
Fixpoint list_nth_mut
  {T : Type} (l : List_t T) (i : u32) : result (T * (T -> List_t T)) :=
  match l with
  | List_Cons x tl =>
    if i s= 0%u32
    then let back := fun (ret : T) => List_Cons ret tl in Ok (x, back)
    else (
      i1 <- u32_sub i 1%u32;
      p <- list_nth_mut tl i1;
      let (t, list_nth_mut_back) := p in
      let back :=
        fun (ret : T) => let tl1 := list_nth_mut_back ret in List_Cons x tl1
      in
      Ok (t, back))
  | List_Nil => Fail_ Failure
  end
.

(** [no_nested_borrows::list_rev_aux]:
    Source: 'tests/src/no_nested_borrows.rs', lines 301:0-311:1 *)
Fixpoint list_rev_aux
  {T : Type} (li : List_t T) (lo : List_t T) : result (List_t T) :=
  match li with
  | List_Cons hd tl => list_rev_aux tl (List_Cons hd lo)
  | List_Nil => Ok lo
  end
.

(** [no_nested_borrows::list_rev]:
    Source: 'tests/src/no_nested_borrows.rs', lines 315:0-318:1 *)
Definition list_rev {T : Type} (l : List_t T) : result (List_t T) :=
  let (li, _) := core_mem_replace l List_Nil in list_rev_aux li List_Nil
.

(** [no_nested_borrows::test_list_functions]:
    Source: 'tests/src/no_nested_borrows.rs', lines 320:0-334:1 *)
Definition test_list_functions : result unit :=
  let l := List_Cons 2%i32 List_Nil in
  let l1 := List_Cons 1%i32 l in
  i <- list_length (List_Cons 0%i32 l1);
  _ <- massert (i s= 3%u32);
  i1 <- list_nth_shared (List_Cons 0%i32 l1) 0%u32;
  _ <- massert (i1 s= 0%i32);
  i2 <- list_nth_shared (List_Cons 0%i32 l1) 1%u32;
  _ <- massert (i2 s= 1%i32);
  i3 <- list_nth_shared (List_Cons 0%i32 l1) 2%u32;
  _ <- massert (i3 s= 2%i32);
  p <- list_nth_mut (List_Cons 0%i32 l1) 1%u32;
  let (_, list_nth_mut_back) := p in
  let ls := list_nth_mut_back 3%i32 in
  i4 <- list_nth_shared ls 0%u32;
  _ <- massert (i4 s= 0%i32);
  i5 <- list_nth_shared ls 1%u32;
  _ <- massert (i5 s= 3%i32);
  i6 <- list_nth_shared ls 2%u32;
  massert (i6 s= 2%i32)
.

(** Unit test for [no_nested_borrows::test_list_functions] *)
Check (test_list_functions)%return.

(** [no_nested_borrows::id_mut_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 336:0-338:1 *)
Definition id_mut_pair1
  {T1 : Type} {T2 : Type} (x : T1) (y : T2) :
  result ((T1 * T2) * ((T1 * T2) -> (T1 * T2)))
  :=
  Ok ((x, y), fun (ret : (T1 * T2)) => ret)
.

(** [no_nested_borrows::id_mut_pair2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 340:0-342:1 *)
Definition id_mut_pair2
  {T1 : Type} {T2 : Type} (p : (T1 * T2)) :
  result ((T1 * T2) * ((T1 * T2) -> (T1 * T2)))
  :=
  Ok (p, fun (ret : (T1 * T2)) => ret)
.

(** [no_nested_borrows::id_mut_pair3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 344:0-346:1 *)
Definition id_mut_pair3
  {T1 : Type} {T2 : Type} (x : T1) (y : T2) :
  result ((T1 * T2) * (T1 -> T1) * (T2 -> T2))
  :=
  Ok ((x, y), fun (ret : T1) => ret, fun (ret : T2) => ret)
.

(** [no_nested_borrows::id_mut_pair4]:
    Source: 'tests/src/no_nested_borrows.rs', lines 348:0-350:1 *)
Definition id_mut_pair4
  {T1 : Type} {T2 : Type} (p : (T1 * T2)) :
  result ((T1 * T2) * (T1 -> T1) * (T2 -> T2))
  :=
  Ok (p, fun (ret : T1) => ret, fun (ret : T2) => ret)
.

(** [no_nested_borrows::StructWithTuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 355:0-357:1 *)
Record StructWithTuple_t (T1 : Type) (T2 : Type) :=
mkStructWithTuple_t {
  structWithTuple_p : (T1 * T2);
}
.

Arguments mkStructWithTuple_t { _ } { _ }.
Arguments structWithTuple_p { _ } { _ }.

(** [no_nested_borrows::new_tuple1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 359:0-361:1 *)
Definition new_tuple1 : result (StructWithTuple_t u32 u32) :=
  Ok {| structWithTuple_p := (1%u32, 2%u32) |}
.

(** [no_nested_borrows::new_tuple2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 363:0-365:1 *)
Definition new_tuple2 : result (StructWithTuple_t i16 i16) :=
  Ok {| structWithTuple_p := (1%i16, 2%i16) |}
.

(** [no_nested_borrows::new_tuple3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 367:0-369:1 *)
Definition new_tuple3 : result (StructWithTuple_t u64 i64) :=
  Ok {| structWithTuple_p := (1%u64, 2%i64) |}
.

(** [no_nested_borrows::StructWithPair]
    Source: 'tests/src/no_nested_borrows.rs', lines 372:0-374:1 *)
Record StructWithPair_t (T1 : Type) (T2 : Type) :=
mkStructWithPair_t {
  structWithPair_p : Pair_t T1 T2;
}
.

Arguments mkStructWithPair_t { _ } { _ }.
Arguments structWithPair_p { _ } { _ }.

(** [no_nested_borrows::new_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 376:0-382:1 *)
Definition new_pair1 : result (StructWithPair_t u32 u32) :=
  Ok {| structWithPair_p := {| pair_x := 1%u32; pair_y := 2%u32 |} |}
.

(** [no_nested_borrows::test_constants]:
    Source: 'tests/src/no_nested_borrows.rs', lines 384:0-389:1 *)
Definition test_constants : result unit :=
  swt <- new_tuple1;
  let (i, _) := swt.(structWithTuple_p) in
  _ <- massert (i s= 1%u32);
  swt1 <- new_tuple2;
  let (i1, _) := swt1.(structWithTuple_p) in
  _ <- massert (i1 s= 1%i16);
  swt2 <- new_tuple3;
  let (i2, _) := swt2.(structWithTuple_p) in
  _ <- massert (i2 s= 1%u64);
  swp <- new_pair1;
  massert (swp.(structWithPair_p).(pair_x) s= 1%u32)
.

(** Unit test for [no_nested_borrows::test_constants] *)
Check (test_constants)%return.

(** [no_nested_borrows::test_weird_borrows1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 393:0-401:1 *)
Definition test_weird_borrows1 : result unit :=
  Ok tt.

(** Unit test for [no_nested_borrows::test_weird_borrows1] *)
Check (test_weird_borrows1)%return.

(** [no_nested_borrows::test_mem_replace]:
    Source: 'tests/src/no_nested_borrows.rs', lines 403:0-407:1 *)
Definition test_mem_replace (px : u32) : result u32 :=
  let (y, _) := core_mem_replace px 1%u32 in
  _ <- massert (y s= 0%u32);
  Ok 2%u32
.

(** [no_nested_borrows::test_shared_borrow_bool1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 410:0-419:1 *)
Definition test_shared_borrow_bool1 (b : bool) : result u32 :=
  if b then Ok 0%u32 else Ok 1%u32
.

(** [no_nested_borrows::test_shared_borrow_bool2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 423:0-433:1 *)
Definition test_shared_borrow_bool2 : result u32 :=
  Ok 0%u32.

(** [no_nested_borrows::test_shared_borrow_enum1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 438:0-446:1 *)
Definition test_shared_borrow_enum1 (l : List_t u32) : result u32 :=
  match l with | List_Cons _ _ => Ok 1%u32 | List_Nil => Ok 0%u32 end
.

(** [no_nested_borrows::test_shared_borrow_enum2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 450:0-459:1 *)
Definition test_shared_borrow_enum2 : result u32 :=
  Ok 0%u32.

(** [no_nested_borrows::incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 461:0-463:1 *)
Definition incr (x : u32) : result u32 :=
  u32_add x 1%u32.

(** [no_nested_borrows::call_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 465:0-468:1 *)
Definition call_incr (x : u32) : result u32 :=
  incr x.

(** [no_nested_borrows::read_then_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 470:0-474:1 *)
Definition read_then_incr (x : u32) : result (u32 * u32) :=
  x1 <- u32_add x 1%u32; Ok (x, x1)
.

(** [no_nested_borrows::Tuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 476:0-476:33 *)
Definition Tuple_t (T1 : Type) (T2 : Type) : Type := T1 * T2.

(** [no_nested_borrows::read_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 478:0-480:1 *)
Definition read_tuple (x : (u32 * u32)) : result u32 :=
  let (i, _) := x in Ok i
.

(** [no_nested_borrows::update_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 482:0-484:1 *)
Definition update_tuple (x : (u32 * u32)) : result (u32 * u32) :=
  let (_, i) := x in Ok (1%u32, i)
.

(** [no_nested_borrows::read_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 486:0-488:1 *)
Definition read_tuple_struct (x : Tuple_t u32 u32) : result u32 :=
  let (i, _) := x in Ok i
.

(** [no_nested_borrows::update_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 490:0-492:1 *)
Definition update_tuple_struct
  (x : Tuple_t u32 u32) : result (Tuple_t u32 u32) :=
  let (_, i) := x in Ok (1%u32, i)
.

(** [no_nested_borrows::create_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 494:0-496:1 *)
Definition create_tuple_struct
  (x : u32) (y : u64) : result (Tuple_t u32 u64) :=
  Ok (x, y)
.

(** [no_nested_borrows::IdType]
    Source: 'tests/src/no_nested_borrows.rs', lines 499:0-499:24 *)
Definition IdType_t (T : Type) : Type := T.

(** [no_nested_borrows::use_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 501:0-503:1 *)
Definition use_id_type {T : Type} (x : IdType_t T) : result T :=
  Ok x.

(** [no_nested_borrows::create_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 505:0-507:1 *)
Definition create_id_type {T : Type} (x : T) : result (IdType_t T) :=
  Ok x.

(** [no_nested_borrows::not_bool]:
    Source: 'tests/src/no_nested_borrows.rs', lines 509:0-511:1 *)
Definition not_bool (x : bool) : result bool :=
  Ok (negb x).

(** [no_nested_borrows::not_u32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 513:0-515:1 *)
Definition not_u32 (x : u32) : result u32 :=
  Ok (scalar_not x).

(** [no_nested_borrows::not_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 517:0-519:1 *)
Definition not_i32 (x : i32) : result i32 :=
  Ok (scalar_not x).

(** [no_nested_borrows::borrow_mut_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 521:0-523:1 *)
Definition borrow_mut_tuple
  {T : Type} {U : Type} (x : (T * U)) :
  result ((T * U) * ((T * U) -> (T * U)))
  :=
  Ok (x, fun (ret : (T * U)) => ret)
.

(** [no_nested_borrows::ExpandSimpliy::Wrapper]
    Source: 'tests/src/no_nested_borrows.rs', lines 527:4-527:32 *)
Definition ExpandSimpliy_Wrapper_t (T : Type) : Type := T * T.

(** [no_nested_borrows::ExpandSimpliy::check_expand_simplify_symb1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 529:4-535:5 *)
Definition expandSimpliy_check_expand_simplify_symb1
  (x : ExpandSimpliy_Wrapper_t bool) : result (ExpandSimpliy_Wrapper_t bool) :=
  let (b, _) := x in if b then Ok x else Ok x
.

(** [no_nested_borrows::ExpandSimpliy::Wrapper2]
    Source: 'tests/src/no_nested_borrows.rs', lines 537:4-540:5 *)
Record ExpandSimpliy_Wrapper2_t :=
mkExpandSimpliy_Wrapper2_t {
  expandSimpliy_Wrapper2_b : bool; expandSimpliy_Wrapper2_x : u32;
}
.

(** [no_nested_borrows::ExpandSimpliy::check_expand_simplify_symb2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 542:4-548:5 *)
Definition expandSimpliy_check_expand_simplify_symb2
  (x : ExpandSimpliy_Wrapper2_t) : result ExpandSimpliy_Wrapper2_t :=
  if x.(expandSimpliy_Wrapper2_b)
  then
    Ok
      {|
        expandSimpliy_Wrapper2_b := true;
        expandSimpliy_Wrapper2_x := x.(expandSimpliy_Wrapper2_x)
      |}
  else
    Ok
      {|
        expandSimpliy_Wrapper2_b := false;
        expandSimpliy_Wrapper2_x := x.(expandSimpliy_Wrapper2_x)
      |}
.

End NoNestedBorrows.
