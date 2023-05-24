-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [hashmap_main]: function definitions
import Base.Primitives
import HashmapMain.Types
import HashmapMain.ExternalFuns
import HashmapMain.Clauses.Clauses

/- [hashmap_main::hashmap::hash_key] -/
def hashmap_hash_key_fwd (k : Usize) : Result Usize :=
  Result.ret k

/- [hashmap_main::hashmap::HashMap::{0}::allocate_slots] -/
def hashmap_hash_map_allocate_slots_loop_fwd
  (T : Type) (slots : Vec (hashmap_list_t T)) (n : Usize) :
  (Result (Vec (hashmap_list_t T)))
  :=
  if 𝒽: n > (Usize.ofInt 0 (by intlit))
  then
    do
      let slots0 ⟵ vec_push_back (hashmap_list_t T) slots hashmap_list_t.Nil
      let n0 ⟵ n - (Usize.ofInt 1 (by intlit))
      let v ⟵ hashmap_hash_map_allocate_slots_loop_fwd T slots0 n0
      Result.ret v
  else Result.ret slots
termination_by hashmap_hash_map_allocate_slots_loop_fwd slots n =>
  hashmap_hash_map_allocate_slots_loop_terminates T slots n
decreasing_by hashmap_hash_map_allocate_slots_loop_decreases slots n

/- [hashmap_main::hashmap::HashMap::{0}::allocate_slots] -/
def hashmap_hash_map_allocate_slots_fwd
  (T : Type) (slots : Vec (hashmap_list_t T)) (n : Usize) :
  Result (Vec (hashmap_list_t T))
  :=
  do
    let v ⟵ hashmap_hash_map_allocate_slots_loop_fwd T slots n
    Result.ret v

/- [hashmap_main::hashmap::HashMap::{0}::new_with_capacity] -/
def hashmap_hash_map_new_with_capacity_fwd
  (T : Type) (capacity : Usize) (max_load_dividend : Usize)
  (max_load_divisor : Usize) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let v := vec_new (hashmap_list_t T)
    let slots ⟵ hashmap_hash_map_allocate_slots_fwd T v capacity
    let i ⟵ capacity * max_load_dividend
    let i0 ⟵ i / max_load_divisor
    Result.ret
      {
        hashmap_hash_map_num_entries := (Usize.ofInt 0 (by intlit)),
        hashmap_hash_map_max_load_factor :=
          (max_load_dividend, max_load_divisor),
        hashmap_hash_map_max_load := i0,
        hashmap_hash_map_slots := slots
      }

/- [hashmap_main::hashmap::HashMap::{0}::new] -/
def hashmap_hash_map_new_fwd (T : Type) : Result (hashmap_hash_map_t T) :=
  hashmap_hash_map_new_with_capacity_fwd T (Usize.ofInt 32 (by intlit))
    (Usize.ofInt 4 (by intlit)) (Usize.ofInt 5 (by intlit))

/- [hashmap_main::hashmap::HashMap::{0}::clear_slots] -/
def hashmap_hash_map_clear_slots_loop_fwd_back
  (T : Type) (slots : Vec (hashmap_list_t T)) (i : Usize) :
  (Result (Vec (hashmap_list_t T)))
  :=
  let i0 := vec_len (hashmap_list_t T) slots
  if 𝒽: i < i0
  then
    do
      let i1 ⟵ i + (Usize.ofInt 1 (by intlit))
      let slots0 ⟵
        vec_index_mut_back (hashmap_list_t T) slots i hashmap_list_t.Nil
      let v ⟵ hashmap_hash_map_clear_slots_loop_fwd_back T slots0 i1
      Result.ret v
  else Result.ret slots
termination_by hashmap_hash_map_clear_slots_loop_fwd_back slots i =>
  hashmap_hash_map_clear_slots_loop_terminates T slots i
decreasing_by hashmap_hash_map_clear_slots_loop_decreases slots i

/- [hashmap_main::hashmap::HashMap::{0}::clear_slots] -/
def hashmap_hash_map_clear_slots_fwd_back
  (T : Type) (slots : Vec (hashmap_list_t T)) :
  Result (Vec (hashmap_list_t T))
  :=
  do
    let v ⟵
      hashmap_hash_map_clear_slots_loop_fwd_back T slots
        (Usize.ofInt 0 (by intlit))
    Result.ret v

/- [hashmap_main::hashmap::HashMap::{0}::clear] -/
def hashmap_hash_map_clear_fwd_back
  (T : Type) (self : hashmap_hash_map_t T) : Result (hashmap_hash_map_t T) :=
  do
    let v ⟵
      hashmap_hash_map_clear_slots_fwd_back T self.hashmap_hash_map_slots
    Result.ret
      {
        self
          with
          hashmap_hash_map_num_entries := (Usize.ofInt 0 (by intlit)),
          hashmap_hash_map_slots := v
      }

/- [hashmap_main::hashmap::HashMap::{0}::len] -/
def hashmap_hash_map_len_fwd
  (T : Type) (self : hashmap_hash_map_t T) : Result Usize :=
  Result.ret self.hashmap_hash_map_num_entries

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list] -/
def hashmap_hash_map_insert_in_list_loop_fwd
  (T : Type) (key : Usize) (value : T) (ls : hashmap_list_t T) :
  (Result Bool)
  :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey cvalue tl =>
    if 𝒽: ckey = key
    then Result.ret false
    else
      do
        let b ⟵ hashmap_hash_map_insert_in_list_loop_fwd T key value tl
        Result.ret b
  | hashmap_list_t.Nil => Result.ret true
termination_by hashmap_hash_map_insert_in_list_loop_fwd key value ls =>
  hashmap_hash_map_insert_in_list_loop_terminates T key value ls
decreasing_by hashmap_hash_map_insert_in_list_loop_decreases key value ls

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list] -/
def hashmap_hash_map_insert_in_list_fwd
  (T : Type) (key : Usize) (value : T) (ls : hashmap_list_t T) : Result Bool :=
  do
    let b ⟵ hashmap_hash_map_insert_in_list_loop_fwd T key value ls
    Result.ret b

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list] -/
def hashmap_hash_map_insert_in_list_loop_back
  (T : Type) (key : Usize) (value : T) (ls : hashmap_list_t T) :
  (Result (hashmap_list_t T))
  :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey cvalue tl =>
    if 𝒽: ckey = key
    then Result.ret (hashmap_list_t.Cons ckey value tl)
    else
      do
        let tl0 ⟵ hashmap_hash_map_insert_in_list_loop_back T key value tl
        Result.ret (hashmap_list_t.Cons ckey cvalue tl0)
  | hashmap_list_t.Nil =>
    let l := hashmap_list_t.Nil
    Result.ret (hashmap_list_t.Cons key value l)
termination_by hashmap_hash_map_insert_in_list_loop_back key value ls =>
  hashmap_hash_map_insert_in_list_loop_terminates T key value ls
decreasing_by hashmap_hash_map_insert_in_list_loop_decreases key value ls

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list] -/
def hashmap_hash_map_insert_in_list_back
  (T : Type) (key : Usize) (value : T) (ls : hashmap_list_t T) :
  Result (hashmap_list_t T)
  :=
  do
    let l ⟵ hashmap_hash_map_insert_in_list_loop_back T key value ls
    Result.ret l

/- [hashmap_main::hashmap::HashMap::{0}::insert_no_resize] -/
def hashmap_hash_map_insert_no_resize_fwd_back
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) (value : T) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_mut_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    let inserted ⟵ hashmap_hash_map_insert_in_list_fwd T key value l
    if 𝒽: inserted
    then
      do
        let i0 ⟵ self.hashmap_hash_map_num_entries +
          (Usize.ofInt 1 (by intlit))
        let l0 ⟵ hashmap_hash_map_insert_in_list_back T key value l
        let v ⟵
          vec_index_mut_back (hashmap_list_t T) self.hashmap_hash_map_slots
            hash_mod l0
        Result.ret
          {
            self
              with
              hashmap_hash_map_num_entries := i0, hashmap_hash_map_slots := v
          }
    else
      do
        let l0 ⟵ hashmap_hash_map_insert_in_list_back T key value l
        let v ⟵
          vec_index_mut_back (hashmap_list_t T) self.hashmap_hash_map_slots
            hash_mod l0
        Result.ret { self with hashmap_hash_map_slots := v }

/- [core::num::u32::{9}::MAX] -/
def core_num_u32_max_body : Result U32 :=
  Result.ret (U32.ofInt 4294967295 (by intlit))
def core_num_u32_max_c : U32 := eval_global core_num_u32_max_body (by simp)

/- [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list] -/
def hashmap_hash_map_move_elements_from_list_loop_fwd_back
  (T : Type) (ntable : hashmap_hash_map_t T) (ls : hashmap_list_t T) :
  (Result (hashmap_hash_map_t T))
  :=
  match 𝒽: ls with
  | hashmap_list_t.Cons k v tl =>
    do
      let ntable0 ⟵ hashmap_hash_map_insert_no_resize_fwd_back T ntable k v
      let hm ⟵
        hashmap_hash_map_move_elements_from_list_loop_fwd_back T ntable0 tl
      Result.ret hm
  | hashmap_list_t.Nil => Result.ret ntable
termination_by hashmap_hash_map_move_elements_from_list_loop_fwd_back ntable ls
  =>
  hashmap_hash_map_move_elements_from_list_loop_terminates T ntable ls
decreasing_by hashmap_hash_map_move_elements_from_list_loop_decreases ntable ls

/- [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list] -/
def hashmap_hash_map_move_elements_from_list_fwd_back
  (T : Type) (ntable : hashmap_hash_map_t T) (ls : hashmap_list_t T) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let hm ⟵
      hashmap_hash_map_move_elements_from_list_loop_fwd_back T ntable ls
    Result.ret hm

/- [hashmap_main::hashmap::HashMap::{0}::move_elements] -/
def hashmap_hash_map_move_elements_loop_fwd_back
  (T : Type) (ntable : hashmap_hash_map_t T) (slots : Vec (hashmap_list_t T))
  (i : Usize) :
  (Result ((hashmap_hash_map_t T) × (Vec (hashmap_list_t T))))
  :=
  let i0 := vec_len (hashmap_list_t T) slots
  if 𝒽: i < i0
  then
    do
      let l ⟵ vec_index_mut_fwd (hashmap_list_t T) slots i
      let ls := mem_replace_fwd (hashmap_list_t T) l hashmap_list_t.Nil
      let ntable0 ⟵
        hashmap_hash_map_move_elements_from_list_fwd_back T ntable ls
      let i1 ⟵ i + (Usize.ofInt 1 (by intlit))
      let l0 := mem_replace_back (hashmap_list_t T) l hashmap_list_t.Nil
      let slots0 ⟵ vec_index_mut_back (hashmap_list_t T) slots i l0
      let p :=
        hashmap_hash_map_move_elements_loop_fwd_back T ntable0 slots0 i1
      let p ⟵ p
      let (hm, v) := p
      Result.ret (hm, v)
  else Result.ret (ntable, slots)
termination_by hashmap_hash_map_move_elements_loop_fwd_back ntable slots i =>
  hashmap_hash_map_move_elements_loop_terminates T ntable slots i
decreasing_by hashmap_hash_map_move_elements_loop_decreases ntable slots i

/- [hashmap_main::hashmap::HashMap::{0}::move_elements] -/
def hashmap_hash_map_move_elements_fwd_back
  (T : Type) (ntable : hashmap_hash_map_t T) (slots : Vec (hashmap_list_t T))
  (i : Usize) :
  Result ((hashmap_hash_map_t T) × (Vec (hashmap_list_t T)))
  :=
  do
    let p ⟵ hashmap_hash_map_move_elements_loop_fwd_back T ntable slots i
    let (hm, v) := p
    Result.ret (hm, v)

/- [hashmap_main::hashmap::HashMap::{0}::try_resize] -/
def hashmap_hash_map_try_resize_fwd_back
  (T : Type) (self : hashmap_hash_map_t T) : Result (hashmap_hash_map_t T) :=
  do
    let max_usize ⟵ Scalar.cast .Usize core_num_u32_max_c
    let capacity := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let n1 ⟵ max_usize / (Usize.ofInt 2 (by intlit))
    let (i, i0) := self.hashmap_hash_map_max_load_factor
    let i1 ⟵ n1 / i
    if 𝒽: capacity <= i1
    then
      do
        let i2 ⟵ capacity * (Usize.ofInt 2 (by intlit))
        let ntable ⟵ hashmap_hash_map_new_with_capacity_fwd T i2 i i0
        let (ntable0, _) ⟵
          hashmap_hash_map_move_elements_fwd_back T ntable
            self.hashmap_hash_map_slots (Usize.ofInt 0 (by intlit))
        Result.ret
          {
            ntable0
              with
              hashmap_hash_map_num_entries := self.hashmap_hash_map_num_entries,
              hashmap_hash_map_max_load_factor := (i, i0)
          }
    else Result.ret { self with hashmap_hash_map_max_load_factor := (i, i0) }

/- [hashmap_main::hashmap::HashMap::{0}::insert] -/
def hashmap_hash_map_insert_fwd_back
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) (value : T) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let self0 ⟵ hashmap_hash_map_insert_no_resize_fwd_back T self key value
    let i ⟵ hashmap_hash_map_len_fwd T self0
    if 𝒽: i > self0.hashmap_hash_map_max_load
    then hashmap_hash_map_try_resize_fwd_back T self0
    else Result.ret self0

/- [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list] -/
def hashmap_hash_map_contains_key_in_list_loop_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : (Result Bool) :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey t tl =>
    if 𝒽: ckey = key
    then Result.ret true
    else
      do
        let b ⟵ hashmap_hash_map_contains_key_in_list_loop_fwd T key tl
        Result.ret b
  | hashmap_list_t.Nil => Result.ret false
termination_by hashmap_hash_map_contains_key_in_list_loop_fwd key ls =>
  hashmap_hash_map_contains_key_in_list_loop_terminates T key ls
decreasing_by hashmap_hash_map_contains_key_in_list_loop_decreases key ls

/- [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list] -/
def hashmap_hash_map_contains_key_in_list_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : Result Bool :=
  do
    let b ⟵ hashmap_hash_map_contains_key_in_list_loop_fwd T key ls
    Result.ret b

/- [hashmap_main::hashmap::HashMap::{0}::contains_key] -/
def hashmap_hash_map_contains_key_fwd
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) : Result Bool :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    hashmap_hash_map_contains_key_in_list_fwd T key l

/- [hashmap_main::hashmap::HashMap::{0}::get_in_list] -/
def hashmap_hash_map_get_in_list_loop_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : (Result T) :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey cvalue tl =>
    if 𝒽: ckey = key
    then Result.ret cvalue
    else
      do
        let t ⟵ hashmap_hash_map_get_in_list_loop_fwd T key tl
        Result.ret t
  | hashmap_list_t.Nil => Result.fail Error.panic
termination_by hashmap_hash_map_get_in_list_loop_fwd key ls =>
  hashmap_hash_map_get_in_list_loop_terminates T key ls
decreasing_by hashmap_hash_map_get_in_list_loop_decreases key ls

/- [hashmap_main::hashmap::HashMap::{0}::get_in_list] -/
def hashmap_hash_map_get_in_list_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : Result T :=
  do
    let t ⟵ hashmap_hash_map_get_in_list_loop_fwd T key ls
    Result.ret t

/- [hashmap_main::hashmap::HashMap::{0}::get] -/
def hashmap_hash_map_get_fwd
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) : Result T :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    hashmap_hash_map_get_in_list_fwd T key l

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] -/
def hashmap_hash_map_get_mut_in_list_loop_fwd
  (T : Type) (ls : hashmap_list_t T) (key : Usize) : (Result T) :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey cvalue tl =>
    if 𝒽: ckey = key
    then Result.ret cvalue
    else
      do
        let t ⟵ hashmap_hash_map_get_mut_in_list_loop_fwd T tl key
        Result.ret t
  | hashmap_list_t.Nil => Result.fail Error.panic
termination_by hashmap_hash_map_get_mut_in_list_loop_fwd ls key =>
  hashmap_hash_map_get_mut_in_list_loop_terminates T ls key
decreasing_by hashmap_hash_map_get_mut_in_list_loop_decreases ls key

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] -/
def hashmap_hash_map_get_mut_in_list_fwd
  (T : Type) (ls : hashmap_list_t T) (key : Usize) : Result T :=
  do
    let t ⟵ hashmap_hash_map_get_mut_in_list_loop_fwd T ls key
    Result.ret t

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] -/
def hashmap_hash_map_get_mut_in_list_loop_back
  (T : Type) (ls : hashmap_list_t T) (key : Usize) (ret0 : T) :
  (Result (hashmap_list_t T))
  :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey cvalue tl =>
    if 𝒽: ckey = key
    then Result.ret (hashmap_list_t.Cons ckey ret0 tl)
    else
      do
        let tl0 ⟵ hashmap_hash_map_get_mut_in_list_loop_back T tl key ret0
        Result.ret (hashmap_list_t.Cons ckey cvalue tl0)
  | hashmap_list_t.Nil => Result.fail Error.panic
termination_by hashmap_hash_map_get_mut_in_list_loop_back ls key ret0 =>
  hashmap_hash_map_get_mut_in_list_loop_terminates T ls key
decreasing_by hashmap_hash_map_get_mut_in_list_loop_decreases ls key

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] -/
def hashmap_hash_map_get_mut_in_list_back
  (T : Type) (ls : hashmap_list_t T) (key : Usize) (ret0 : T) :
  Result (hashmap_list_t T)
  :=
  do
    let l ⟵ hashmap_hash_map_get_mut_in_list_loop_back T ls key ret0
    Result.ret l

/- [hashmap_main::hashmap::HashMap::{0}::get_mut] -/
def hashmap_hash_map_get_mut_fwd
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) : Result T :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_mut_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    hashmap_hash_map_get_mut_in_list_fwd T l key

/- [hashmap_main::hashmap::HashMap::{0}::get_mut] -/
def hashmap_hash_map_get_mut_back
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) (ret0 : T) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_mut_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    let l0 ⟵ hashmap_hash_map_get_mut_in_list_back T l key ret0
    let v ⟵
      vec_index_mut_back (hashmap_list_t T) self.hashmap_hash_map_slots
        hash_mod l0
    Result.ret { self with hashmap_hash_map_slots := v }

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list] -/
def hashmap_hash_map_remove_from_list_loop_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : (Result (Option T)) :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey t tl =>
    if 𝒽: ckey = key
    then
      let mv_ls :=
        mem_replace_fwd (hashmap_list_t T) (hashmap_list_t.Cons ckey t tl)
          hashmap_list_t.Nil
      match 𝒽: mv_ls with
      | hashmap_list_t.Cons i cvalue tl0 => Result.ret (Option.some cvalue)
      | hashmap_list_t.Nil => Result.fail Error.panic
    else
      do
        let opt ⟵ hashmap_hash_map_remove_from_list_loop_fwd T key tl
        Result.ret opt
  | hashmap_list_t.Nil => Result.ret Option.none
termination_by hashmap_hash_map_remove_from_list_loop_fwd key ls =>
  hashmap_hash_map_remove_from_list_loop_terminates T key ls
decreasing_by hashmap_hash_map_remove_from_list_loop_decreases key ls

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list] -/
def hashmap_hash_map_remove_from_list_fwd
  (T : Type) (key : Usize) (ls : hashmap_list_t T) : Result (Option T) :=
  do
    let opt ⟵ hashmap_hash_map_remove_from_list_loop_fwd T key ls
    Result.ret opt

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list] -/
def hashmap_hash_map_remove_from_list_loop_back
  (T : Type) (key : Usize) (ls : hashmap_list_t T) :
  (Result (hashmap_list_t T))
  :=
  match 𝒽: ls with
  | hashmap_list_t.Cons ckey t tl =>
    if 𝒽: ckey = key
    then
      let mv_ls :=
        mem_replace_fwd (hashmap_list_t T) (hashmap_list_t.Cons ckey t tl)
          hashmap_list_t.Nil
      match 𝒽: mv_ls with
      | hashmap_list_t.Cons i cvalue tl0 => Result.ret tl0
      | hashmap_list_t.Nil => Result.fail Error.panic
    else
      do
        let tl0 ⟵ hashmap_hash_map_remove_from_list_loop_back T key tl
        Result.ret (hashmap_list_t.Cons ckey t tl0)
  | hashmap_list_t.Nil => Result.ret hashmap_list_t.Nil
termination_by hashmap_hash_map_remove_from_list_loop_back key ls =>
  hashmap_hash_map_remove_from_list_loop_terminates T key ls
decreasing_by hashmap_hash_map_remove_from_list_loop_decreases key ls

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list] -/
def hashmap_hash_map_remove_from_list_back
  (T : Type) (key : Usize) (ls : hashmap_list_t T) :
  Result (hashmap_list_t T)
  :=
  do
    let l ⟵ hashmap_hash_map_remove_from_list_loop_back T key ls
    Result.ret l

/- [hashmap_main::hashmap::HashMap::{0}::remove] -/
def hashmap_hash_map_remove_fwd
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) : Result (Option T) :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_mut_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    let x ⟵ hashmap_hash_map_remove_from_list_fwd T key l
    match 𝒽: x with
    | Option.none => Result.ret Option.none
    | Option.some x0 =>
      do
        let _ ⟵ self.hashmap_hash_map_num_entries -
          (Usize.ofInt 1 (by intlit))
        Result.ret (Option.some x0)

/- [hashmap_main::hashmap::HashMap::{0}::remove] -/
def hashmap_hash_map_remove_back
  (T : Type) (self : hashmap_hash_map_t T) (key : Usize) :
  Result (hashmap_hash_map_t T)
  :=
  do
    let hash ⟵ hashmap_hash_key_fwd key
    let i := vec_len (hashmap_list_t T) self.hashmap_hash_map_slots
    let hash_mod ⟵ hash % i
    let l ⟵
      vec_index_mut_fwd (hashmap_list_t T) self.hashmap_hash_map_slots hash_mod
    let x ⟵ hashmap_hash_map_remove_from_list_fwd T key l
    match 𝒽: x with
    | Option.none =>
      do
        let l0 ⟵ hashmap_hash_map_remove_from_list_back T key l
        let v ⟵
          vec_index_mut_back (hashmap_list_t T) self.hashmap_hash_map_slots
            hash_mod l0
        Result.ret { self with hashmap_hash_map_slots := v }
    | Option.some x0 =>
      do
        let i0 ⟵ self.hashmap_hash_map_num_entries -
          (Usize.ofInt 1 (by intlit))
        let l0 ⟵ hashmap_hash_map_remove_from_list_back T key l
        let v ⟵
          vec_index_mut_back (hashmap_list_t T) self.hashmap_hash_map_slots
            hash_mod l0
        Result.ret
          {
            self
              with
              hashmap_hash_map_num_entries := i0, hashmap_hash_map_slots := v
          }

/- [hashmap_main::hashmap::test1] -/
def hashmap_test1_fwd : Result Unit :=
  do
    let hm ⟵ hashmap_hash_map_new_fwd U64
    let hm0 ⟵
      hashmap_hash_map_insert_fwd_back U64 hm (Usize.ofInt 0 (by intlit))
        (U64.ofInt 42 (by intlit))
    let hm1 ⟵
      hashmap_hash_map_insert_fwd_back U64 hm0 (Usize.ofInt 128 (by intlit))
        (U64.ofInt 18 (by intlit))
    let hm2 ⟵
      hashmap_hash_map_insert_fwd_back U64 hm1 (Usize.ofInt 1024 (by intlit))
        (U64.ofInt 138 (by intlit))
    let hm3 ⟵
      hashmap_hash_map_insert_fwd_back U64 hm2 (Usize.ofInt 1056 (by intlit))
        (U64.ofInt 256 (by intlit))
    let i ⟵ hashmap_hash_map_get_fwd U64 hm3 (Usize.ofInt 128 (by intlit))
    if 𝒽: not (i = (U64.ofInt 18 (by intlit)))
    then Result.fail Error.panic
    else
      do
        let hm4 ⟵
          hashmap_hash_map_get_mut_back U64 hm3 (Usize.ofInt 1024 (by intlit))
            (U64.ofInt 56 (by intlit))
        let i0 ⟵
          hashmap_hash_map_get_fwd U64 hm4 (Usize.ofInt 1024 (by intlit))
        if 𝒽: not (i0 = (U64.ofInt 56 (by intlit)))
        then Result.fail Error.panic
        else
          do
            let x ⟵
              hashmap_hash_map_remove_fwd U64 hm4
                (Usize.ofInt 1024 (by intlit))
            match 𝒽: x with
            | Option.none => Result.fail Error.panic
            | Option.some x0 =>
              if 𝒽: not (x0 = (U64.ofInt 56 (by intlit)))
              then Result.fail Error.panic
              else
                do
                  let hm5 ⟵
                    hashmap_hash_map_remove_back U64 hm4
                      (Usize.ofInt 1024 (by intlit))
                  let i1 ⟵
                    hashmap_hash_map_get_fwd U64 hm5
                      (Usize.ofInt 0 (by intlit))
                  if 𝒽: not (i1 = (U64.ofInt 42 (by intlit)))
                  then Result.fail Error.panic
                  else
                    do
                      let i2 ⟵
                        hashmap_hash_map_get_fwd U64 hm5
                          (Usize.ofInt 128 (by intlit))
                      if 𝒽: not (i2 = (U64.ofInt 18 (by intlit)))
                      then Result.fail Error.panic
                      else
                        do
                          let i3 ⟵
                            hashmap_hash_map_get_fwd U64 hm5
                              (Usize.ofInt 1056 (by intlit))
                          if 𝒽: not (i3 = (U64.ofInt 256 (by intlit)))
                          then Result.fail Error.panic
                          else Result.ret ()

/- [hashmap_main::insert_on_disk] -/
def insert_on_disk_fwd
  (key : Usize) (value : U64) (st : State) : Result (State × Unit) :=
  do
    let (st0, hm) ⟵ opaque_defs.hashmap_utils_deserialize_fwd st
    let hm0 ⟵ hashmap_hash_map_insert_fwd_back U64 hm key value
    let (st1, _) ⟵ opaque_defs.hashmap_utils_serialize_fwd hm0 st0
    Result.ret (st1, ())

/- [hashmap_main::main] -/
def main_fwd : Result Unit :=
  Result.ret ()

