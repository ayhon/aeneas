-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [hashmap]: function definitions
import Aeneas
import Hashmap.Types
import Hashmap.FunsExternal
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace hashmap

/- [hashmap::hash_key]:
   Source: 'tests/src/hashmap.rs', lines 38:0-43:1 -/
def hash_key (k : Usize) : Result Usize :=
  ok k

/- [hashmap::{core::clone::Clone for hashmap::Fraction}#1::clone]:
   Source: 'tests/src/hashmap.rs', lines 45:9-45:14 -/
def ClonehashmapFraction.clone (self : Fraction) : Result Fraction :=
  ok self

/- Trait implementation: [hashmap::{core::clone::Clone for hashmap::Fraction}#1]
   Source: 'tests/src/hashmap.rs', lines 45:9-45:14 -/
@[reducible]
def core.clone.ClonehashmapFraction : core.clone.Clone Fraction := {
  clone := ClonehashmapFraction.clone
}

/- Trait implementation: [hashmap::{core::marker::Copy for hashmap::Fraction}#2]
   Source: 'tests/src/hashmap.rs', lines 45:16-45:20 -/
@[reducible]
def core.marker.CopyhashmapFraction : core.marker.Copy Fraction := {
  cloneInst := core.clone.ClonehashmapFraction
}

/- [hashmap::{hashmap::HashMap<T>}::allocate_slots]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 70:8-73:9 -/
divergent def HashMap.allocate_slots_loop
  {T : Type} (slots : alloc.vec.Vec (AList T)) (n : Usize) :
  Result (alloc.vec.Vec (AList T))
  :=
  if n > 0#usize
  then
    do
    let slots1 ← alloc.vec.Vec.push slots AList.Nil
    let n1 ← n - 1#usize
    HashMap.allocate_slots_loop slots1 n1
  else ok slots

/- [hashmap::{hashmap::HashMap<T>}::allocate_slots]:
   Source: 'tests/src/hashmap.rs', lines 69:4-75:5 -/
@[reducible]
def HashMap.allocate_slots
  {T : Type} (slots : alloc.vec.Vec (AList T)) (n : Usize) :
  Result (alloc.vec.Vec (AList T))
  :=
  HashMap.allocate_slots_loop slots n

/- [hashmap::{hashmap::HashMap<T>}::new_with_capacity]:
   Source: 'tests/src/hashmap.rs', lines 78:4-89:5 -/
def HashMap.new_with_capacity
  (T : Type) (capacity : Usize) (max_load_factor : Fraction) :
  Result (HashMap T)
  :=
  do
  let slots ← HashMap.allocate_slots (alloc.vec.Vec.new (AList T)) capacity
  let i ← capacity * max_load_factor.dividend
  let i1 ← i / max_load_factor.divisor
  ok
    {
      num_entries := 0#usize,
      max_load_factor,
      max_load := i1,
      saturated := false,
      slots
    }

/- [hashmap::{hashmap::HashMap<T>}::new]:
   Source: 'tests/src/hashmap.rs', lines 91:4-100:5 -/
def HashMap.new (T : Type) : Result (HashMap T) :=
  HashMap.new_with_capacity T 32#usize
    { dividend := 4#usize, divisor := 5#usize }

/- [hashmap::{hashmap::HashMap<T>}::clear]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 106:8-109:9 -/
divergent def HashMap.clear_loop
  {T : Type} (slots : alloc.vec.Vec (AList T)) (i : Usize) :
  Result (alloc.vec.Vec (AList T))
  :=
  let i1 := alloc.vec.Vec.len slots
  if i < i1
  then
    do
    let (_, index_mut_back) ←
      alloc.vec.Vec.index_mut (core.slice.index.SliceIndexUsizeSliceInst (AList
        T)) slots i
    let i2 ← i + 1#usize
    let slots1 := index_mut_back AList.Nil
    HashMap.clear_loop slots1 i2
  else ok slots

/- [hashmap::{hashmap::HashMap<T>}::clear]:
   Source: 'tests/src/hashmap.rs', lines 102:4-110:5 -/
def HashMap.clear {T : Type} (self : HashMap T) : Result (HashMap T) :=
  do
  let hm ← HashMap.clear_loop self.slots 0#usize
  ok { self with num_entries := 0#usize, slots := hm }

/- [hashmap::{hashmap::HashMap<T>}::len]:
   Source: 'tests/src/hashmap.rs', lines 112:4-114:5 -/
def HashMap.len {T : Type} (self : HashMap T) : Result Usize :=
  ok self.num_entries

/- [hashmap::{hashmap::HashMap<T>}::insert_in_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 1:0-135:9 -/
divergent def HashMap.insert_in_list_loop
  {T : Type} (key : Usize) (value : T) (ls : AList T) :
  Result (Bool × (AList T))
  :=
  match ls with
  | AList.Cons ckey cvalue tl =>
    if ckey = key
    then ok (false, AList.Cons ckey value tl)
    else
      do
      let (b, tl1) ← HashMap.insert_in_list_loop key value tl
      ok (b, AList.Cons ckey cvalue tl1)
  | AList.Nil => ok (true, AList.Cons key value AList.Nil)

/- [hashmap::{hashmap::HashMap<T>}::insert_in_list]:
   Source: 'tests/src/hashmap.rs', lines 119:4-136:5 -/
@[reducible]
def HashMap.insert_in_list
  {T : Type} (key : Usize) (value : T) (ls : AList T) :
  Result (Bool × (AList T))
  :=
  HashMap.insert_in_list_loop key value ls

/- [hashmap::{hashmap::HashMap<T>}::insert_no_resize]:
   Source: 'tests/src/hashmap.rs', lines 139:4-147:5 -/
def HashMap.insert_no_resize
  {T : Type} (self : HashMap T) (key : Usize) (value : T) :
  Result (HashMap T)
  :=
  do
  let hash ← hash_key key
  let i := alloc.vec.Vec.len self.slots
  let hash_mod ← hash % i
  let (a, index_mut_back) ←
    alloc.vec.Vec.index_mut (core.slice.index.SliceIndexUsizeSliceInst (AList
      T)) self.slots hash_mod
  let (inserted, a1) ← HashMap.insert_in_list key value a
  if inserted
  then
    do
    let i1 ← self.num_entries + 1#usize
    let v := index_mut_back a1
    ok { self with num_entries := i1, slots := v }
  else let v := index_mut_back a1
       ok { self with slots := v }

/- [hashmap::{hashmap::HashMap<T>}::move_elements_from_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 201:12-208:17 -/
divergent def HashMap.move_elements_from_list_loop
  {T : Type} (ntable : HashMap T) (ls : AList T) : Result (HashMap T) :=
  match ls with
  | AList.Cons k v tl =>
    do
    let ntable1 ← HashMap.insert_no_resize ntable k v
    HashMap.move_elements_from_list_loop ntable1 tl
  | AList.Nil => ok ntable

/- [hashmap::{hashmap::HashMap<T>}::move_elements_from_list]:
   Source: 'tests/src/hashmap.rs', lines 198:4-211:5 -/
@[reducible]
def HashMap.move_elements_from_list
  {T : Type} (ntable : HashMap T) (ls : AList T) : Result (HashMap T) :=
  HashMap.move_elements_from_list_loop ntable ls

/- [hashmap::{hashmap::HashMap<T>}::move_elements]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 187:8-194:9 -/
divergent def HashMap.move_elements_loop
  {T : Type} (ntable : HashMap T) (slots : alloc.vec.Vec (AList T)) (i : Usize)
  :
  Result ((HashMap T) × (alloc.vec.Vec (AList T)))
  :=
  let i1 := alloc.vec.Vec.len slots
  if i < i1
  then
    do
    let (a, index_mut_back) ←
      alloc.vec.Vec.index_mut (core.slice.index.SliceIndexUsizeSliceInst (AList
        T)) slots i
    let (ls, a1) := core.mem.replace a AList.Nil
    let ntable1 ← HashMap.move_elements_from_list ntable ls
    let i2 ← i + 1#usize
    let slots1 := index_mut_back a1
    HashMap.move_elements_loop ntable1 slots1 i2
  else ok (ntable, slots)

/- [hashmap::{hashmap::HashMap<T>}::move_elements]:
   Source: 'tests/src/hashmap.rs', lines 185:4-195:5 -/
@[reducible]
def HashMap.move_elements
  {T : Type} (ntable : HashMap T) (slots : alloc.vec.Vec (AList T)) :
  Result ((HashMap T) × (alloc.vec.Vec (AList T)))
  :=
  HashMap.move_elements_loop ntable slots 0#usize

/- [hashmap::{hashmap::HashMap<T>}::try_resize]:
   Source: 'tests/src/hashmap.rs', lines 162:4-181:5 -/
def HashMap.try_resize {T : Type} (self : HashMap T) : Result (HashMap T) :=
  do
  let capacity := alloc.vec.Vec.len self.slots
  let n1 ← core_usize_max / 2#usize
  let i ← n1 / self.max_load_factor.dividend
  if capacity <= i
  then
    do
    let i1 ← capacity * 2#usize
    let ntable ← HashMap.new_with_capacity T i1 self.max_load_factor
    let (ntable1, _) ← HashMap.move_elements ntable self.slots
    ok { self with max_load := ntable1.max_load, slots := ntable1.slots }
  else ok { self with saturated := true }

/- [hashmap::{hashmap::HashMap<T>}::insert]:
   Source: 'tests/src/hashmap.rs', lines 151:4-158:5 -/
def HashMap.insert
  {T : Type} (self : HashMap T) (key : Usize) (value : T) :
  Result (HashMap T)
  :=
  do
  let self1 ← HashMap.insert_no_resize self key value
  let i ← HashMap.len self1
  if i > self1.max_load
  then if self1.saturated
       then ok self1
       else HashMap.try_resize self1
  else ok self1

/- [hashmap::{hashmap::HashMap<T>}::contains_key_in_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 1:0-233:9 -/
divergent def HashMap.contains_key_in_list_loop
  {T : Type} (key : Usize) (ls : AList T) : Result Bool :=
  match ls with
  | AList.Cons ckey _ tl =>
    if ckey = key
    then ok true
    else HashMap.contains_key_in_list_loop key tl
  | AList.Nil => ok false

/- [hashmap::{hashmap::HashMap<T>}::contains_key_in_list]:
   Source: 'tests/src/hashmap.rs', lines 221:4-234:5 -/
@[reducible]
def HashMap.contains_key_in_list
  {T : Type} (key : Usize) (ls : AList T) : Result Bool :=
  HashMap.contains_key_in_list_loop key ls

/- [hashmap::{hashmap::HashMap<T>}::contains_key]:
   Source: 'tests/src/hashmap.rs', lines 214:4-218:5 -/
def HashMap.contains_key
  {T : Type} (self : HashMap T) (key : Usize) : Result Bool :=
  do
  let hash ← hash_key key
  let i := alloc.vec.Vec.len self.slots
  let hash_mod ← hash % i
  let a ←
    alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceInst (AList T))
      self.slots hash_mod
  HashMap.contains_key_in_list key a

/- [hashmap::{hashmap::HashMap<T>}::get_in_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 240:8-248:5 -/
divergent def HashMap.get_in_list_loop
  {T : Type} (key : Usize) (ls : AList T) : Result (Option T) :=
  match ls with
  | AList.Cons ckey cvalue tl =>
    if ckey = key
    then ok (some cvalue)
    else HashMap.get_in_list_loop key tl
  | AList.Nil => ok none

/- [hashmap::{hashmap::HashMap<T>}::get_in_list]:
   Source: 'tests/src/hashmap.rs', lines 239:4-248:5 -/
@[reducible]
def HashMap.get_in_list
  {T : Type} (key : Usize) (ls : AList T) : Result (Option T) :=
  HashMap.get_in_list_loop key ls

/- [hashmap::{hashmap::HashMap<T>}::get]:
   Source: 'tests/src/hashmap.rs', lines 250:4-254:5 -/
def HashMap.get
  {T : Type} (self : HashMap T) (key : Usize) : Result (Option T) :=
  do
  let hash ← hash_key key
  let i := alloc.vec.Vec.len self.slots
  let hash_mod ← hash % i
  let a ←
    alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceInst (AList T))
      self.slots hash_mod
  HashMap.get_in_list key a

/- [hashmap::{hashmap::HashMap<T>}::get_mut_in_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 257:8-265:5 -/
divergent def HashMap.get_mut_in_list_loop
  {T : Type} (ls : AList T) (key : Usize) :
  Result ((Option T) × (Option T → AList T))
  :=
  match ls with
  | AList.Cons ckey cvalue tl =>
    if ckey = key
    then
      let back :=
        fun ret =>
          let t := match ret with
                   | some t1 => t1
                   | _ => cvalue
          AList.Cons ckey t tl
      ok (some cvalue, back)
    else
      do
      let (o, back) ← HashMap.get_mut_in_list_loop tl key
      let back1 := fun ret => let tl1 := back ret
                              AList.Cons ckey cvalue tl1
      ok (o, back1)
  | AList.Nil => let back := fun ret => AList.Nil
                 ok (none, back)

/- [hashmap::{hashmap::HashMap<T>}::get_mut_in_list]:
   Source: 'tests/src/hashmap.rs', lines 256:4-265:5 -/
@[reducible]
def HashMap.get_mut_in_list
  {T : Type} (ls : AList T) (key : Usize) :
  Result ((Option T) × (Option T → AList T))
  :=
  HashMap.get_mut_in_list_loop ls key

/- [hashmap::{hashmap::HashMap<T>}::get_mut]:
   Source: 'tests/src/hashmap.rs', lines 268:4-272:5 -/
def HashMap.get_mut
  {T : Type} (self : HashMap T) (key : Usize) :
  Result ((Option T) × (Option T → HashMap T))
  :=
  do
  let hash ← hash_key key
  let i := alloc.vec.Vec.len self.slots
  let hash_mod ← hash % i
  let (a, index_mut_back) ←
    alloc.vec.Vec.index_mut (core.slice.index.SliceIndexUsizeSliceInst (AList
      T)) self.slots hash_mod
  let (o, get_mut_in_list_back) ← HashMap.get_mut_in_list a key
  let back :=
    fun ret =>
      let a1 := get_mut_in_list_back ret
      let v := index_mut_back a1
      { self with slots := v }
  ok (o, back)

/- [hashmap::{hashmap::HashMap<T>}::remove_from_list]: loop 0:
   Source: 'tests/src/hashmap.rs', lines 1:0-299:17 -/
divergent def HashMap.remove_from_list_loop
  {T : Type} (key : Usize) (ls : AList T) : Result ((Option T) × (AList T)) :=
  match ls with
  | AList.Cons ckey t tl =>
    if ckey = key
    then
      let (mv_ls, _) := core.mem.replace ls AList.Nil
      match mv_ls with
      | AList.Cons _ cvalue tl1 => ok (some cvalue, tl1)
      | AList.Nil => fail panic
    else
      do
      let (o, tl1) ← HashMap.remove_from_list_loop key tl
      ok (o, AList.Cons ckey t tl1)
  | AList.Nil => ok (none, AList.Nil)

/- [hashmap::{hashmap::HashMap<T>}::remove_from_list]:
   Source: 'tests/src/hashmap.rs', lines 276:4-302:5 -/
@[reducible]
def HashMap.remove_from_list
  {T : Type} (key : Usize) (ls : AList T) : Result ((Option T) × (AList T)) :=
  HashMap.remove_from_list_loop key ls

/- [hashmap::{hashmap::HashMap<T>}::remove]:
   Source: 'tests/src/hashmap.rs', lines 305:4-317:5 -/
def HashMap.remove
  {T : Type} (self : HashMap T) (key : Usize) :
  Result ((Option T) × (HashMap T))
  :=
  do
  let hash ← hash_key key
  let i := alloc.vec.Vec.len self.slots
  let hash_mod ← hash % i
  let (a, index_mut_back) ←
    alloc.vec.Vec.index_mut (core.slice.index.SliceIndexUsizeSliceInst (AList
      T)) self.slots hash_mod
  let (x, a1) ← HashMap.remove_from_list key a
  match x with
  | none => let v := index_mut_back a1
            ok (none, { self with slots := v })
  | some _ =>
    do
    let i1 ← self.num_entries - 1#usize
    let v := index_mut_back a1
    ok (x, { self with num_entries := i1, slots := v })

/- [hashmap::insert_on_disk]:
   Source: 'tests/src/hashmap.rs', lines 336:0-343:1 -/
def insert_on_disk
  (key : Usize) (value : U64) (st : State) : Result (State × Unit) :=
  do
  let (st1, hm) ← utils.deserialize st
  let hm1 ← HashMap.insert hm key value
  utils.serialize hm1 st1

end hashmap
