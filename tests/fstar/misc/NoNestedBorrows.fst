(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [no_nested_borrows] *)
module NoNestedBorrows
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [no_nested_borrows::Pair]
    Source: 'tests/src/no_nested_borrows.rs', lines 7:0-10:1 *)
type pair_t (t1 : Type0) (t2 : Type0) = { x : t1; y : t2; }

(** [no_nested_borrows::List]
    Source: 'tests/src/no_nested_borrows.rs', lines 12:0-15:1 *)
type list_t (t : Type0) =
| List_Cons : t -> list_t t -> list_t t
| List_Nil : list_t t

(** [no_nested_borrows::One]
    Source: 'tests/src/no_nested_borrows.rs', lines 23:0-25:1 *)
type one_t (t1 : Type0) = | One_One : t1 -> one_t t1

(** [no_nested_borrows::EmptyEnum]
    Source: 'tests/src/no_nested_borrows.rs', lines 29:0-31:1 *)
type emptyEnum_t = | EmptyEnum_Empty : emptyEnum_t

(** [no_nested_borrows::Enum]
    Source: 'tests/src/no_nested_borrows.rs', lines 35:0-38:1 *)
type enum_t = | Enum_Variant1 : enum_t | Enum_Variant2 : enum_t

(** [no_nested_borrows::EmptyStruct]
    Source: 'tests/src/no_nested_borrows.rs', lines 42:0-42:25 *)
type emptyStruct_t = unit

(** [no_nested_borrows::Sum]
    Source: 'tests/src/no_nested_borrows.rs', lines 44:0-47:1 *)
type sum_t (t1 : Type0) (t2 : Type0) =
| Sum_Left : t1 -> sum_t t1 t2
| Sum_Right : t2 -> sum_t t1 t2

(** [no_nested_borrows::cast_u32_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 49:0-51:1 *)
let cast_u32_to_i32 (x : u32) : result i32 =
  scalar_cast U32 I32 x

(** [no_nested_borrows::cast_bool_to_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 53:0-55:1 *)
let cast_bool_to_i32 (x : bool) : result i32 =
  scalar_cast_bool I32 x

(** [no_nested_borrows::cast_bool_to_bool]:
    Source: 'tests/src/no_nested_borrows.rs', lines 58:0-60:1 *)
let cast_bool_to_bool (x : bool) : result bool =
  Ok x

(** [no_nested_borrows::test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 63:0-73:1 *)
let test2 : result unit =
  let* _ = u32_add 23 44 in Ok ()

(** Unit test for [no_nested_borrows::test2] *)
let _ = assert_norm (test2 = Ok ())

(** [no_nested_borrows::get_max]:
    Source: 'tests/src/no_nested_borrows.rs', lines 75:0-81:1 *)
let get_max (x : u32) (y : u32) : result u32 =
  if x >= y then Ok x else Ok y

(** [no_nested_borrows::test3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 83:0-88:1 *)
let test3 : result unit =
  let* x = get_max 4 3 in
  let* y = get_max 10 11 in
  let* z = u32_add x y in
  if z = 15 then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::test3] *)
let _ = assert_norm (test3 = Ok ())

(** [no_nested_borrows::test_neg1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 90:0-94:1 *)
let test_neg1 : result unit =
  let* y = i32_neg 3 in if y = -3 then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::test_neg1] *)
let _ = assert_norm (test_neg1 = Ok ())

(** [no_nested_borrows::refs_test1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 97:0-106:1 *)
let refs_test1 : result unit =
  if 1 = 1 then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::refs_test1] *)
let _ = assert_norm (refs_test1 = Ok ())

(** [no_nested_borrows::refs_test2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 108:0-120:1 *)
let refs_test2 : result unit =
  if 2 = 2
  then
    if 0 = 0
    then if 2 = 2 then if 2 = 2 then Ok () else Fail Failure else Fail Failure
    else Fail Failure
  else Fail Failure

(** Unit test for [no_nested_borrows::refs_test2] *)
let _ = assert_norm (refs_test2 = Ok ())

(** [no_nested_borrows::test_list1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 124:0-126:1 *)
let test_list1 : result unit =
  Ok ()

(** Unit test for [no_nested_borrows::test_list1] *)
let _ = assert_norm (test_list1 = Ok ())

(** [no_nested_borrows::copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 128:0-130:1 *)
let copy_int (x : i32) : result i32 =
  Ok x

(** [no_nested_borrows::test_unreachable]:
    Source: 'tests/src/no_nested_borrows.rs', lines 134:0-138:1 *)
let test_unreachable (b : bool) : result unit =
  massert b

(** [no_nested_borrows::test_panic]:
    Source: 'tests/src/no_nested_borrows.rs', lines 141:0-145:1 *)
let test_panic (b : bool) : result unit =
  massert b

(** [no_nested_borrows::test_panic_msg]:
    Source: 'tests/src/no_nested_borrows.rs', lines 149:0-153:1 *)
let test_panic_msg (b : bool) : result unit =
  massert b

(** [no_nested_borrows::test_copy_int]:
    Source: 'tests/src/no_nested_borrows.rs', lines 156:0-161:1 *)
let test_copy_int : result unit =
  let* y = copy_int 0 in if 0 = y then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::test_copy_int] *)
let _ = assert_norm (test_copy_int = Ok ())

(** [no_nested_borrows::is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 163:0-168:1 *)
let is_cons (#t : Type0) (l : list_t t) : result bool =
  begin match l with | List_Cons _ _ -> Ok true | List_Nil -> Ok false end

(** [no_nested_borrows::test_is_cons]:
    Source: 'tests/src/no_nested_borrows.rs', lines 170:0-174:1 *)
let test_is_cons : result unit =
  let* b = is_cons (List_Cons 0 List_Nil) in if b then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::test_is_cons] *)
let _ = assert_norm (test_is_cons = Ok ())

(** [no_nested_borrows::split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 176:0-181:1 *)
let split_list (#t : Type0) (l : list_t t) : result (t & (list_t t)) =
  begin match l with
  | List_Cons hd tl -> Ok (hd, tl)
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::test_split_list]:
    Source: 'tests/src/no_nested_borrows.rs', lines 184:0-189:1 *)
let test_split_list : result unit =
  let* p = split_list (List_Cons 0 List_Nil) in
  let (hd, _) = p in
  if hd = 0 then Ok () else Fail Failure

(** Unit test for [no_nested_borrows::test_split_list] *)
let _ = assert_norm (test_split_list = Ok ())

(** [no_nested_borrows::choose]:
    Source: 'tests/src/no_nested_borrows.rs', lines 191:0-197:1 *)
let choose
  (#t : Type0) (b : bool) (x : t) (y : t) : result (t & (t -> (t & t))) =
  if b
  then let back = fun ret -> (ret, y) in Ok (x, back)
  else let back = fun ret -> (x, ret) in Ok (y, back)

(** [no_nested_borrows::choose_test]:
    Source: 'tests/src/no_nested_borrows.rs', lines 199:0-208:1 *)
let choose_test : result unit =
  let* (z, choose_back) = choose true 0 0 in
  let* z1 = i32_add z 1 in
  if z1 = 1
  then
    let (x, y) = choose_back z1 in
    if x = 1 then if y = 0 then Ok () else Fail Failure else Fail Failure
  else Fail Failure

(** Unit test for [no_nested_borrows::choose_test] *)
let _ = assert_norm (choose_test = Ok ())

(** [no_nested_borrows::test_char]:
    Source: 'tests/src/no_nested_borrows.rs', lines 211:0-213:1 *)
let test_char : result char =
  Ok 'a'

(** [no_nested_borrows::panic_mut_borrow]:
    Source: 'tests/src/no_nested_borrows.rs', lines 216:0-218:1 *)
let panic_mut_borrow (i : u32) : result u32 =
  Fail Failure

(** [no_nested_borrows::Tree]
    Source: 'tests/src/no_nested_borrows.rs', lines 221:0-224:1 *)
type tree_t (t : Type0) =
| Tree_Leaf : t -> tree_t t
| Tree_Node : t -> nodeElem_t t -> tree_t t -> tree_t t

(** [no_nested_borrows::NodeElem]
    Source: 'tests/src/no_nested_borrows.rs', lines 226:0-229:1 *)
and nodeElem_t (t : Type0) =
| NodeElem_Cons : tree_t t -> nodeElem_t t -> nodeElem_t t
| NodeElem_Nil : nodeElem_t t

(** [no_nested_borrows::list_length]:
    Source: 'tests/src/no_nested_borrows.rs', lines 261:0-266:1 *)
let rec list_length (#t : Type0) (l : list_t t) : result u32 =
  begin match l with
  | List_Cons _ l1 -> let* i = list_length l1 in u32_add 1 i
  | List_Nil -> Ok 0
  end

(** [no_nested_borrows::list_nth_shared]:
    Source: 'tests/src/no_nested_borrows.rs', lines 269:0-282:1 *)
let rec list_nth_shared (#t : Type0) (l : list_t t) (i : u32) : result t =
  begin match l with
  | List_Cons x tl ->
    if i = 0 then Ok x else let* i1 = u32_sub i 1 in list_nth_shared tl i1
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::list_nth_mut]:
    Source: 'tests/src/no_nested_borrows.rs', lines 285:0-298:1 *)
let rec list_nth_mut
  (#t : Type0) (l : list_t t) (i : u32) : result (t & (t -> list_t t)) =
  begin match l with
  | List_Cons x tl ->
    if i = 0
    then let back = fun ret -> List_Cons ret tl in Ok (x, back)
    else
      let* i1 = u32_sub i 1 in
      let* (x1, list_nth_mut_back) = list_nth_mut tl i1 in
      let back = fun ret -> let tl1 = list_nth_mut_back ret in List_Cons x tl1
      in
      Ok (x1, back)
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::list_rev_aux]:
    Source: 'tests/src/no_nested_borrows.rs', lines 301:0-311:1 *)
let rec list_rev_aux
  (#t : Type0) (li : list_t t) (lo : list_t t) : result (list_t t) =
  begin match li with
  | List_Cons hd tl -> list_rev_aux tl (List_Cons hd lo)
  | List_Nil -> Ok lo
  end

(** [no_nested_borrows::list_rev]:
    Source: 'tests/src/no_nested_borrows.rs', lines 315:0-318:1 *)
let list_rev (#t : Type0) (l : list_t t) : result (list_t t) =
  let (li, _) = core_mem_replace l List_Nil in list_rev_aux li List_Nil

(** [no_nested_borrows::test_list_functions]:
    Source: 'tests/src/no_nested_borrows.rs', lines 320:0-334:1 *)
let test_list_functions : result unit =
  let l = List_Cons 2 List_Nil in
  let l1 = List_Cons 1 l in
  let* i = list_length (List_Cons 0 l1) in
  if i = 3
  then
    let* i1 = list_nth_shared (List_Cons 0 l1) 0 in
    if i1 = 0
    then
      let* i2 = list_nth_shared (List_Cons 0 l1) 1 in
      if i2 = 1
      then
        let* i3 = list_nth_shared (List_Cons 0 l1) 2 in
        if i3 = 2
        then
          let* (_, list_nth_mut_back) = list_nth_mut (List_Cons 0 l1) 1 in
          let ls = list_nth_mut_back 3 in
          let* i4 = list_nth_shared ls 0 in
          if i4 = 0
          then
            let* i5 = list_nth_shared ls 1 in
            if i5 = 3
            then
              let* i6 = list_nth_shared ls 2 in
              if i6 = 2 then Ok () else Fail Failure
            else Fail Failure
          else Fail Failure
        else Fail Failure
      else Fail Failure
    else Fail Failure
  else Fail Failure

(** Unit test for [no_nested_borrows::test_list_functions] *)
let _ = assert_norm (test_list_functions = Ok ())

(** [no_nested_borrows::id_mut_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 336:0-338:1 *)
let id_mut_pair1
  (#t1 : Type0) (#t2 : Type0) (x : t1) (y : t2) :
  result ((t1 & t2) & ((t1 & t2) -> (t1 & t2)))
  =
  Ok ((x, y), (fun ret -> ret))

(** [no_nested_borrows::id_mut_pair2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 340:0-342:1 *)
let id_mut_pair2
  (#t1 : Type0) (#t2 : Type0) (p : (t1 & t2)) :
  result ((t1 & t2) & ((t1 & t2) -> (t1 & t2)))
  =
  Ok (p, (fun ret -> ret))

(** [no_nested_borrows::id_mut_pair3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 344:0-346:1 *)
let id_mut_pair3
  (#t1 : Type0) (#t2 : Type0) (x : t1) (y : t2) :
  result ((t1 & t2) & (t1 -> t1) & (t2 -> t2))
  =
  Ok ((x, y), (fun ret -> ret), (fun ret -> ret))

(** [no_nested_borrows::id_mut_pair4]:
    Source: 'tests/src/no_nested_borrows.rs', lines 348:0-350:1 *)
let id_mut_pair4
  (#t1 : Type0) (#t2 : Type0) (p : (t1 & t2)) :
  result ((t1 & t2) & (t1 -> t1) & (t2 -> t2))
  =
  Ok (p, (fun ret -> ret), (fun ret -> ret))

(** [no_nested_borrows::StructWithTuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 355:0-357:1 *)
type structWithTuple_t (t1 : Type0) (t2 : Type0) = { p : (t1 & t2); }

(** [no_nested_borrows::new_tuple1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 359:0-361:1 *)
let new_tuple1 : result (structWithTuple_t u32 u32) =
  Ok { p = (1, 2) }

(** [no_nested_borrows::new_tuple2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 363:0-365:1 *)
let new_tuple2 : result (structWithTuple_t i16 i16) =
  Ok { p = (1, 2) }

(** [no_nested_borrows::new_tuple3]:
    Source: 'tests/src/no_nested_borrows.rs', lines 367:0-369:1 *)
let new_tuple3 : result (structWithTuple_t u64 i64) =
  Ok { p = (1, 2) }

(** [no_nested_borrows::StructWithPair]
    Source: 'tests/src/no_nested_borrows.rs', lines 372:0-374:1 *)
type structWithPair_t (t1 : Type0) (t2 : Type0) = { p : pair_t t1 t2; }

(** [no_nested_borrows::new_pair1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 376:0-382:1 *)
let new_pair1 : result (structWithPair_t u32 u32) =
  Ok { p = { x = 1; y = 2 } }

(** [no_nested_borrows::test_constants]:
    Source: 'tests/src/no_nested_borrows.rs', lines 384:0-389:1 *)
let test_constants : result unit =
  let* swt = new_tuple1 in
  let (i, _) = swt.p in
  if i = 1
  then
    let* swt1 = new_tuple2 in
    let (i1, _) = swt1.p in
    if i1 = 1
    then
      let* swt2 = new_tuple3 in
      let (i2, _) = swt2.p in
      if i2 = 1
      then let* swp = new_pair1 in if swp.p.x = 1 then Ok () else Fail Failure
      else Fail Failure
    else Fail Failure
  else Fail Failure

(** Unit test for [no_nested_borrows::test_constants] *)
let _ = assert_norm (test_constants = Ok ())

(** [no_nested_borrows::test_weird_borrows1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 393:0-401:1 *)
let test_weird_borrows1 : result unit =
  Ok ()

(** Unit test for [no_nested_borrows::test_weird_borrows1] *)
let _ = assert_norm (test_weird_borrows1 = Ok ())

(** [no_nested_borrows::test_mem_replace]:
    Source: 'tests/src/no_nested_borrows.rs', lines 403:0-407:1 *)
let test_mem_replace (px : u32) : result u32 =
  let (y, _) = core_mem_replace px 1 in if y = 0 then Ok 2 else Fail Failure

(** [no_nested_borrows::test_shared_borrow_bool1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 410:0-419:1 *)
let test_shared_borrow_bool1 (b : bool) : result u32 =
  if b then Ok 0 else Ok 1

(** [no_nested_borrows::test_shared_borrow_bool2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 423:0-433:1 *)
let test_shared_borrow_bool2 : result u32 =
  Ok 0

(** [no_nested_borrows::test_shared_borrow_enum1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 438:0-446:1 *)
let test_shared_borrow_enum1 (l : list_t u32) : result u32 =
  begin match l with | List_Cons _ _ -> Ok 1 | List_Nil -> Ok 0 end

(** [no_nested_borrows::test_shared_borrow_enum2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 450:0-459:1 *)
let test_shared_borrow_enum2 : result u32 =
  Ok 0

(** [no_nested_borrows::incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 461:0-463:1 *)
let incr (x : u32) : result u32 =
  u32_add x 1

(** [no_nested_borrows::call_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 465:0-468:1 *)
let call_incr (x : u32) : result u32 =
  incr x

(** [no_nested_borrows::read_then_incr]:
    Source: 'tests/src/no_nested_borrows.rs', lines 470:0-474:1 *)
let read_then_incr (x : u32) : result (u32 & u32) =
  let* x1 = u32_add x 1 in Ok (x, x1)

(** [no_nested_borrows::Tuple]
    Source: 'tests/src/no_nested_borrows.rs', lines 476:0-476:33 *)
type tuple_t (t1 : Type0) (t2 : Type0) = t1 * t2

(** [no_nested_borrows::read_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 478:0-480:1 *)
let read_tuple (x : (u32 & u32)) : result u32 =
  let (i, _) = x in Ok i

(** [no_nested_borrows::update_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 482:0-484:1 *)
let update_tuple (x : (u32 & u32)) : result (u32 & u32) =
  let (_, i) = x in Ok (1, i)

(** [no_nested_borrows::read_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 486:0-488:1 *)
let read_tuple_struct (x : tuple_t u32 u32) : result u32 =
  let (i, _) = x in Ok i

(** [no_nested_borrows::update_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 490:0-492:1 *)
let update_tuple_struct (x : tuple_t u32 u32) : result (tuple_t u32 u32) =
  let (_, i) = x in Ok (1, i)

(** [no_nested_borrows::create_tuple_struct]:
    Source: 'tests/src/no_nested_borrows.rs', lines 494:0-496:1 *)
let create_tuple_struct (x : u32) (y : u64) : result (tuple_t u32 u64) =
  Ok (x, y)

(** [no_nested_borrows::IdType]
    Source: 'tests/src/no_nested_borrows.rs', lines 499:0-499:24 *)
type idType_t (t : Type0) = t

(** [no_nested_borrows::use_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 501:0-503:1 *)
let use_id_type (#t : Type0) (x : idType_t t) : result t =
  Ok x

(** [no_nested_borrows::create_id_type]:
    Source: 'tests/src/no_nested_borrows.rs', lines 505:0-507:1 *)
let create_id_type (#t : Type0) (x : t) : result (idType_t t) =
  Ok x

(** [no_nested_borrows::not_bool]:
    Source: 'tests/src/no_nested_borrows.rs', lines 509:0-511:1 *)
let not_bool (x : bool) : result bool =
  Ok (not x)

(** [no_nested_borrows::not_u32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 513:0-515:1 *)
let not_u32 (x : u32) : result u32 =
  Ok (u32_not x)

(** [no_nested_borrows::not_i32]:
    Source: 'tests/src/no_nested_borrows.rs', lines 517:0-519:1 *)
let not_i32 (x : i32) : result i32 =
  Ok (i32_not x)

(** [no_nested_borrows::borrow_mut_tuple]:
    Source: 'tests/src/no_nested_borrows.rs', lines 521:0-523:1 *)
let borrow_mut_tuple
  (#t : Type0) (#u : Type0) (x : (t & u)) :
  result ((t & u) & ((t & u) -> (t & u)))
  =
  Ok (x, (fun ret -> ret))

(** [no_nested_borrows::ExpandSimpliy::Wrapper]
    Source: 'tests/src/no_nested_borrows.rs', lines 527:4-527:32 *)
type expandSimpliy_Wrapper_t (t : Type0) = t * t

(** [no_nested_borrows::ExpandSimpliy::check_expand_simplify_symb1]:
    Source: 'tests/src/no_nested_borrows.rs', lines 529:4-535:5 *)
let expandSimpliy_check_expand_simplify_symb1
  (x : expandSimpliy_Wrapper_t bool) : result (expandSimpliy_Wrapper_t bool) =
  let (b, _) = x in if b then Ok x else Ok x

(** [no_nested_borrows::ExpandSimpliy::Wrapper2]
    Source: 'tests/src/no_nested_borrows.rs', lines 537:4-540:5 *)
type expandSimpliy_Wrapper2_t = { b : bool; x : u32; }

(** [no_nested_borrows::ExpandSimpliy::check_expand_simplify_symb2]:
    Source: 'tests/src/no_nested_borrows.rs', lines 542:4-548:5 *)
let expandSimpliy_check_expand_simplify_symb2
  (x : expandSimpliy_Wrapper2_t) : result expandSimpliy_Wrapper2_t =
  if x.b then Ok x else Ok x

