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
    Source: 'tests/src/no_nested_borrows.rs', lines 4:0-4:23 *)
Record Pair_t (T1 T2 : Type) := mkPair_t { pair_x : T1; pair_y : T2; }.

Arguments mkPair_t { _ _ }.
Arguments pair_x { _ _ }.
Arguments pair_y { _ _ }.

(** [no_nested_borrows::List]
    Source: 'tests/src/no_nested_borrows.rs', lines 9:0-9:16 *)
Inductive List_t (T : Type) :=
| List_Cons : T -> List_t T -> List_t T
| List_Nil : List_t T
.

Arguments List_Cons { _ }.
Arguments List_Nil { _ }.

(** [no_nested_borrows::One]
    Source: 'tests/src/no_nested_borrows.rs', lines 20:0-20:16 *)
Inductive One_t (T1 : Type) := | One_One : T1 -> One_t T1.

Arguments One_One { _ }.

(** [no_nested_borrows::EmptyEnum]
    Source: 'tests/src/no_nested_borrows.rs', lines 26:0-26:18 *)
Inductive EmptyEnum_t := | EmptyEnum_Empty : EmptyEnum_t.

(** [no_nested_borrows::Enum]
    Source: 'tests/src/no_nested_borrows.rs', lines 32:0-32:13 *)
Inductive Enum_t := | Enum_Variant1 : Enum_t | Enum_Variant2 : Enum_t.

(** [no_nested_borrows::EmptyStruct]
    Source: 'tests/src/no_nested_borrows.rs', lines 39:0-39:22 *)
Definition EmptyStruct_t : Type := unit.

(** [no_nested_borrows::Sum]
    Source: 'tests/src/no_nested_borrows.rs', lines 41:0-41:20 *)
Inductive Sum_t (T1 T2 : Type) :=
| Sum_Left : T1 -> Sum_t T1 T2
| Sum_Right : T2 -> Sum_t T1 T2
.

Arguments Sum_Left { _ _ }.
Arguments Sum_Right { _ _ }.

(** [no_nested_borrows::cast_u32_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 46:0-46:37 *)
Definition cast_u32_to_i32 (x : u32) : result i32 :=
  scalar_cast U32 I32 x.

(** [no_nested_borrows::cast_bool_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 50:0-50:39 *)
Definition cast_bool_to_i32 (x : bool) : result i32 :=
  scalar_cast_bool I32 x.

(** [no_nested_borrows::cast_bool_to_bool]:
    Source: 'tests/src/no_nested_borrows.rs', lines 55:0-55:41 *)
Definition cast_bool_to_bool (x : bool) : result bool :=
  Ok x.

(** [no_nested_borrows::test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 60:0-60:14 *)
Definition test2 : result unit :=
  _ <- u32_add 23%u32 44%u32; Ok tt.

(** Unit test for [no_nested_borrows::test2] *)
Check (test2 )%return.

(** [no_nested_borrows::get_max]:
    Source: 'tests/src/no_nested_borrows.rs', lines 72:0-72:37 *)
Definition get_max (x : u32) (y : u32) : result u32 :=
  if x s>= y then Ok x else Ok y
.

(** [no_nested_borrows::test3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 80:0-80:14 *)
Definition test3 : result unit :=
  x <- get_max 4%u32 3%u32;
  y <- get_max 10%u32 11%u32;
  z <- u32_add x y;
  if negb (z s= 15%u32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test3] *)
Check (test3 )%return.

(** [no_nested_borrows::test_neg1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 87:0-87:18 *)
Definition test_neg1 : result unit :=
  y <- i32_neg 3%i32; if negb (y s= (-3)%i32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test_neg1] *)
Check (test_neg1 )%return.

(** [no_nested_borrows::refs_test1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 94:0-94:19 *)
Definition refs_test1 : result unit :=
  if negb (1%i32 s= 1%i32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::refs_test1] *)
Check (refs_test1 )%return.

(** [no_nested_borrows::refs_test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 105:0-105:19 *)
Definition refs_test2 : result unit :=
  if negb (2%i32 s= 2%i32)
  then Fail_ Failure
  else
    if negb (0%i32 s= 0%i32)
    then Fail_ Failure
    else
      if negb (2%i32 s= 2%i32)
      then Fail_ Failure
      else if negb (2%i32 s= 2%i32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::refs_test2] *)
Check (refs_test2 )%return.

(** [no_nested_borrows::test_list1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 121:0-121:19 *)
Definition test_list1 : result unit :=
  Ok tt.

(** Unit test for [no_nested_borrows::test_list1] *)
Check (test_list1 )%return.

(** [no_nested_borrows::test_box1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 126:0-126:18 *)
Definition test_box1 : result unit :=
  p <- alloc_boxed_Box_deref_mut i32 0%i32;
  let (_, deref_mut_back) := p in
  b <- deref_mut_back 1%i32;
  x <- alloc_boxed_Box_deref i32 b;
  if negb (x s= 1%i32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test_box1] *)
Check (test_box1 )%return.

(** [no_nested_borrows::copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 136:0-136:30 *)
Definition copy_int (x : i32) : result i32 :=
  Ok x.

(** [no_nested_borrows::test_unreachable]:
    Source: 'tests/src/no_nested_borrows.rs', lines 142:0-142:32 *)
Definition test_unreachable (b : bool) : result unit :=
  if b then Fail_ Failure else Ok tt
.

(** [no_nested_borrows::test_panic]:
    Source: 'tests/src/no_nested_borrows.rs', lines 150:0-150:26 *)
Definition test_panic (b : bool) : result unit :=
  if b then Fail_ Failure else Ok tt
.

(** [no_nested_borrows::test_copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 157:0-157:22 *)
Definition test_copy_int : result unit :=
  y <- copy_int 0%i32; if negb (0%i32 s= y) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test_copy_int] *)
Check (test_copy_int )%return.

(** [no_nested_borrows::is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 164:0-164:38 *)
Definition is_cons (T : Type) (l : List_t T) : result bool :=
  match l with | List_Cons _ _ => Ok true | List_Nil => Ok false end
.

(** [no_nested_borrows::test_is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 171:0-171:21 *)
Definition test_is_cons : result unit :=
  b <- is_cons i32 (List_Cons 0%i32 List_Nil);
  if negb b then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test_is_cons] *)
Check (test_is_cons )%return.

(** [no_nested_borrows::split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 177:0-177:48 *)
Definition split_list (T : Type) (l : List_t T) : result (T * (List_t T)) :=
  match l with | List_Cons hd tl => Ok (hd, tl) | List_Nil => Fail_ Failure end
.

(** [no_nested_borrows::test_split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 185:0-185:24 *)
Definition test_split_list : result unit :=
  p <- split_list i32 (List_Cons 0%i32 List_Nil);
  let (hd, _) := p in
  if negb (hd s= 0%i32) then Fail_ Failure else Ok tt
.

(** Unit test for [no_nested_borrows::test_split_list] *)
Check (test_split_list )%return.

(** [no_nested_borrows::choose]:
    Source: 'tests/src/no_nested_borrows.rs', lines 192:0-192:70 *)
Definition choose
  (T : Type) (b : bool) (x : T) (y : T) : result (T * (T -> result (T * T))) :=
  if b
  then let back := fun (ret : T) => Ok (ret, y) in Ok (x, back)
  else let back := fun (ret : T) => Ok (x, ret) in Ok (y, back)
.

(** [no_nested_borrows::choose_test]:
    Source: 'tests/src/no_nested_borrows.rs', lines 200:0-200:20 *)
Definition choose_test : result unit :=
  p <- choose i32 true 0%i32 0%i32;
  let (z, choose_back) := p in
  z1 <- i32_add z 1%i32;
  if negb (z1 s= 1%i32)
  then Fail_ Failure
  else (
    p1 <- choose_back z1;
    let (x, y) := p1 in
    if negb (x s= 1%i32)
    then Fail_ Failure
    else if negb (y s= 0%i32) then Fail_ Failure else Ok tt)
.

(** Unit test for [no_nested_borrows::choose_test] *)
Check (choose_test )%return.

(** [no_nested_borrows::test_char]:
    Source: 'tests/src/no_nested_borrows.rs', lines 212:0-212:26 *)
Definition test_char : result char :=
  Ok (char_of_byte Coq.Init.Byte.x61).

(** [no_nested_borrows::Tree]
    Source: 'tests/src/no_nested_borrows.rs', lines 217:0-217:16 *)
Inductive Tree_t (T : Type) :=
| Tree_Leaf : T -> Tree_t T
| Tree_Node : T -> NodeElem_t T -> Tree_t T -> Tree_t T

(** [no_nested_borrows::NodeElem]
    Source: 'tests/src/no_nested_borrows.rs', lines 222:0-222:20 *)
with NodeElem_t (T : Type) :=
| NodeElem_Cons : Tree_t T -> NodeElem_t T -> NodeElem_t T
| NodeElem_Nil : NodeElem_t T
.

Arguments Tree_Leaf { _ }.
Arguments Tree_Node { _ }.

Arguments NodeElem_Cons { _ }.
Arguments NodeElem_Nil { _ }.

(** [no_nested_borrows::list_length]:
    Source: 'tests/src/no_nested_borrows.rs', lines 257:0-257:48 *)
Fixpoint list_length (T : Type) (l : List_t T) : result u32 :=
  match l with
  | List_Cons _ l1 => i <- list_length T l1; u32_add 1%u32 i
  | List_Nil => Ok 0%u32
  end
.

(** [no_nested_borrows::list_nth_shared]:
    Source: 'tests/src/no_nested_borrows.rs', lines 265:0-265:62 *)
Fixpoint list_nth_shared (T : Type) (l : List_t T) (i : u32) : result T :=
  match l with
  | List_Cons x tl =>
    if i s= 0%u32
    then Ok x
    else (i1 <- u32_sub i 1%u32; list_nth_shared T tl i1)
  | List_Nil => Fail_ Failure
  end
.

(** [no_nested_borrows::list_nth_mut]:
    Source: 'tests/src/no_nested_borrows.rs', lines 281:0-281:67 *)
Fixpoint list_nth_mut
  (T : Type) (l : List_t T) (i : u32) :
  result (T * (T -> result (List_t T)))
  :=
  match l with
  | List_Cons x tl =>
    if i s= 0%u32
    then let back := fun (ret : T) => Ok (List_Cons ret tl) in Ok (x, back)
    else (
      i1 <- u32_sub i 1%u32;
      p <- list_nth_mut T tl i1;
      let (t, list_nth_mut_back) := p in
      let back :=
        fun (ret : T) => tl1 <- list_nth_mut_back ret; Ok (List_Cons x tl1) in
      Ok (t, back))
  | List_Nil => Fail_ Failure
  end
.

(** [no_nested_borrows::list_rev_aux]:
    Source: 'tests/src/no_nested_borrows.rs', lines 297:0-297:63 *)
Fixpoint list_rev_aux
  (T : Type) (li : List_t T) (lo : List_t T) : result (List_t T) :=
  match li with
  | List_Cons hd tl => list_rev_aux T tl (List_Cons hd lo)
  | List_Nil => Ok lo
  end
.

(** [no_nested_borrows::list_rev]:
    Source: 'tests/src/no_nested_borrows.rs', lines 311:0-311:42 *)
Definition list_rev (T : Type) (l : List_t T) : result (List_t T) :=
  let (li, _) := core_mem_replace (List_t T) l List_Nil in
  list_rev_aux T li List_Nil
.

(** [no_nested_borrows::test_list_functions]:
    Source: 'tests/src/no_nested_borrows.rs', lines 316:0-316:28 *)
Definition test_list_functions : result unit :=
  let l := List_Cons 2%i32 List_Nil in
  let l1 := List_Cons 1%i32 l in
  i <- list_length i32 (List_Cons 0%i32 l1);
  if negb (i s= 3%u32)
  then Fail_ Failure
  else (
    i1 <- list_nth_shared i32 (List_Cons 0%i32 l1) 0%u32;
    if negb (i1 s= 0%i32)
    then Fail_ Failure
    else (
      i2 <- list_nth_shared i32 (List_Cons 0%i32 l1) 1%u32;
      if negb (i2 s= 1%i32)
      then Fail_ Failure
      else (
        i3 <- list_nth_shared i32 (List_Cons 0%i32 l1) 2%u32;
        if negb (i3 s= 2%i32)
        then Fail_ Failure
        else (
          p <- list_nth_mut i32 (List_Cons 0%i32 l1) 1%u32;
          let (_, list_nth_mut_back) := p in
          ls <- list_nth_mut_back 3%i32;
          i4 <- list_nth_shared i32 ls 0%u32;
          if negb (i4 s= 0%i32)
          then Fail_ Failure
          else (
            i5 <- list_nth_shared i32 ls 1%u32;
            if negb (i5 s= 3%i32)
            then Fail_ Failure
            else (
              i6 <- list_nth_shared i32 ls 2%u32;
              if negb (i6 s= 2%i32) then Fail_ Failure else Ok tt))))))
.

(** Unit test for [no_nested_borrows::test_list_functions] *)
Check (test_list_functions )%return.

(** [no_nested_borrows::id_mut_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 332:0-332:89 *)
Definition id_mut_pair1
  (T1 T2 : Type) (x : T1) (y : T2) :
  result ((T1 * T2) * ((T1 * T2) -> result (T1 * T2)))
  :=
  Ok ((x, y), Ok)
.

(** [no_nested_borrows::id_mut_pair2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 336:0-336:88 *)
Definition id_mut_pair2
  (T1 T2 : Type) (p : (T1 * T2)) :
  result ((T1 * T2) * ((T1 * T2) -> result (T1 * T2)))
  :=
  let (t, t1) := p in Ok ((t, t1), Ok)
.

(** [no_nested_borrows::id_mut_pair3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 340:0-340:93 *)
Definition id_mut_pair3
  (T1 T2 : Type) (x : T1) (y : T2) :
  result ((T1 * T2) * (T1 -> result T1) * (T2 -> result T2))
  :=
  Ok ((x, y), Ok, Ok)
.

(** [no_nested_borrows::id_mut_pair4]:
    Source: 'tests/src/no_nested_borrows.rs', lines 344:0-344:92 *)
Definition id_mut_pair4
  (T1 T2 : Type) (p : (T1 * T2)) :
  result ((T1 * T2) * (T1 -> result T1) * (T2 -> result T2))
  :=
  let (t, t1) := p in Ok ((t, t1), Ok, Ok)
.

(** [no_nested_borrows::StructWithTuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 351:0-351:34 *)
Record StructWithTuple_t (T1 T2 : Type) :=
mkStructWithTuple_t {
  structWithTuple_p : (T1 * T2);
}
.

Arguments mkStructWithTuple_t { _ _ }.
Arguments structWithTuple_p { _ _ }.

(** [no_nested_borrows::new_tuple1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 355:0-355:48 *)
Definition new_tuple1 : result (StructWithTuple_t u32 u32) :=
  Ok {| structWithTuple_p := (1%u32, 2%u32) |}
.

(** [no_nested_borrows::new_tuple2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 359:0-359:48 *)
Definition new_tuple2 : result (StructWithTuple_t i16 i16) :=
  Ok {| structWithTuple_p := (1%i16, 2%i16) |}
.

(** [no_nested_borrows::new_tuple3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 363:0-363:48 *)
Definition new_tuple3 : result (StructWithTuple_t u64 i64) :=
  Ok {| structWithTuple_p := (1%u64, 2%i64) |}
.

(** [no_nested_borrows::StructWithPair]
    Source: 'tests/src/no_nested_borrows.rs', lines 368:0-368:33 *)
Record StructWithPair_t (T1 T2 : Type) :=
mkStructWithPair_t {
  structWithPair_p : Pair_t T1 T2;
}
.

Arguments mkStructWithPair_t { _ _ }.
Arguments structWithPair_p { _ _ }.

(** [no_nested_borrows::new_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 372:0-372:46 *)
Definition new_pair1 : result (StructWithPair_t u32 u32) :=
  Ok {| structWithPair_p := {| pair_x := 1%u32; pair_y := 2%u32 |} |}
.

(** [no_nested_borrows::test_constants]:
    Source: 'tests/src/no_nested_borrows.rs', lines 380:0-380:23 *)
Definition test_constants : result unit :=
  swt <- new_tuple1;
  let (i, _) := swt.(structWithTuple_p) in
  if negb (i s= 1%u32)
  then Fail_ Failure
  else (
    swt1 <- new_tuple2;
    let (i1, _) := swt1.(structWithTuple_p) in
    if negb (i1 s= 1%i16)
    then Fail_ Failure
    else (
      swt2 <- new_tuple3;
      let (i2, _) := swt2.(structWithTuple_p) in
      if negb (i2 s= 1%u64)
      then Fail_ Failure
      else (
        swp <- new_pair1;
        if negb (swp.(structWithPair_p).(pair_x) s= 1%u32)
        then Fail_ Failure
        else Ok tt)))
.

(** Unit test for [no_nested_borrows::test_constants] *)
Check (test_constants )%return.

(** [no_nested_borrows::test_weird_borrows1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 389:0-389:28 *)
Definition test_weird_borrows1 : result unit :=
  Ok tt.

(** Unit test for [no_nested_borrows::test_weird_borrows1] *)
Check (test_weird_borrows1 )%return.

(** [no_nested_borrows::test_mem_replace]:
    Source: 'tests/src/no_nested_borrows.rs', lines 399:0-399:37 *)
Definition test_mem_replace (px : u32) : result u32 :=
  let (y, _) := core_mem_replace u32 px 1%u32 in
  if negb (y s= 0%u32) then Fail_ Failure else Ok 2%u32
.

(** [no_nested_borrows::test_shared_borrow_bool1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 406:0-406:47 *)
Definition test_shared_borrow_bool1 (b : bool) : result u32 :=
  if b then Ok 0%u32 else Ok 1%u32
.

(** [no_nested_borrows::test_shared_borrow_bool2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 419:0-419:40 *)
Definition test_shared_borrow_bool2 : result u32 :=
  Ok 0%u32.

(** [no_nested_borrows::test_shared_borrow_enum1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 434:0-434:52 *)
Definition test_shared_borrow_enum1 (l : List_t u32) : result u32 :=
  match l with | List_Cons _ _ => Ok 1%u32 | List_Nil => Ok 0%u32 end
.

(** [no_nested_borrows::test_shared_borrow_enum2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 446:0-446:40 *)
Definition test_shared_borrow_enum2 : result u32 :=
  Ok 0%u32.

(** [no_nested_borrows::incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 457:0-457:24 *)
Definition incr (x : u32) : result u32 :=
  u32_add x 1%u32.

(** [no_nested_borrows::call_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 461:0-461:35 *)
Definition call_incr (x : u32) : result u32 :=
  incr x.

(** [no_nested_borrows::read_then_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 466:0-466:41 *)
Definition read_then_incr (x : u32) : result (u32 * u32) :=
  x1 <- u32_add x 1%u32; Ok (x, x1)
.

(** [no_nested_borrows::Tuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 472:0-472:24 *)
Definition Tuple_t (T1 T2 : Type) : Type := T1 * T2.

(** [no_nested_borrows::use_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 474:0-474:48 *)
Definition use_tuple_struct (x : Tuple_t u32 u32) : result (Tuple_t u32 u32) :=
  let (_, i) := x in Ok (1%u32, i)
.

(** [no_nested_borrows::create_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 478:0-478:61 *)
Definition create_tuple_struct
  (x : u32) (y : u64) : result (Tuple_t u32 u64) :=
  Ok (x, y)
.

(** [no_nested_borrows::IdType]
    Source: 'tests/src/no_nested_borrows.rs', lines 483:0-483:20 *)
Definition IdType_t (T : Type) : Type := T.

(** [no_nested_borrows::use_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 485:0-485:40 *)
Definition use_id_type (T : Type) (x : IdType_t T) : result T :=
  Ok x.

(** [no_nested_borrows::create_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 489:0-489:43 *)
Definition create_id_type (T : Type) (x : T) : result (IdType_t T) :=
  Ok x.

End NoNestedBorrows.
