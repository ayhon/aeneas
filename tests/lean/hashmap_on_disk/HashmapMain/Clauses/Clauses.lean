import Base.Primitives
import HashmapMain.Types

def hashmap_list_length (l: hashmap_list_t T) :=
  match l with
  | .Nil => 0
  | .Cons _ _ l => 1 + hashmap_list_length l

theorem hashmap_list_length_cons (T: Type) k v (tl: hashmap_list_t T):
  hashmap_list_length (hashmap_list_t.Cons k v tl) = 1 + hashmap_list_length tl
:=
  by rfl

/- [hashmap_main::hashmap::HashMap::{0}::allocate_slots]: termination measure -/
@[simp]
def hashmap_hash_map_allocate_slots_loop_terminates (T : Type)
  (slots : Vec (hashmap_list_t T)) (n : Usize) :=
  (slots, n)

/- [hashmap_main::hashmap::HashMap::{0}::allocate_slots]: decreases_by tactic -/
syntax "hashmap_hash_map_allocate_slots_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_allocate_slots_loop_decreases $slots $n) =>
  `(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::clear_slots]: termination measure -/
@[simp]
def hashmap_hash_map_clear_slots_loop_terminates (T : Type)
  (slots : Vec (hashmap_list_t T)) (i : Usize) :=
  (slots, i)

/- [hashmap_main::hashmap::HashMap::{0}::clear_slots]: decreases_by tactic -/
syntax "hashmap_hash_map_clear_slots_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_clear_slots_loop_decreases $slots $i) =>
  `(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list]: termination measure -/
@[simp]
def hashmap_hash_map_insert_in_list_loop_terminates (T : Type) (key : Usize)
  (value : T) (ls : hashmap_list_t T) :=
  hashmap_list_length ls

/- [hashmap_main::hashmap::HashMap::{0}::insert_in_list]: decreases_by tactic -/
syntax "hashmap_hash_map_insert_in_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_insert_in_list_loop_decreases $key $value $ls) =>
  `(tactic|
    simp_wf;
    have h (n: Nat): n < 1 + n := (by simp_arith);
    rewrite [ hashmap_list_length_cons ];
    apply h
  )

/- [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list]: termination measure -/
@[simp]
def hashmap_hash_map_move_elements_from_list_loop_terminates (T : Type)
  (ntable : hashmap_hash_map_t T) (ls : hashmap_list_t T) :=
  (ntable, ls)

/- [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list]: decreases_by tactic -/
syntax "hashmap_hash_map_move_elements_from_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_move_elements_from_list_loop_decreases $ntable
$ls) =>`(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::move_elements]: termination measure -/
@[simp]
def hashmap_hash_map_move_elements_loop_terminates (T : Type)
  (ntable : hashmap_hash_map_t T) (slots : Vec (hashmap_list_t T)) (i : Usize)
  :=
  (ntable, slots, i)

/- [hashmap_main::hashmap::HashMap::{0}::move_elements]: decreases_by tactic -/
syntax "hashmap_hash_map_move_elements_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_move_elements_loop_decreases $ntable $slots $i) =>
  `(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list]: termination measure -/
@[simp]
def hashmap_hash_map_contains_key_in_list_loop_terminates (T : Type)
  (key : Usize) (ls : hashmap_list_t T) :=
  (key, ls)

/- [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list]: decreases_by tactic -/
syntax "hashmap_hash_map_contains_key_in_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_contains_key_in_list_loop_decreases $key $ls) =>
  `(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::get_in_list]: termination measure -/
@[simp]
def hashmap_hash_map_get_in_list_loop_terminates (T : Type) (key : Usize)
  (ls : hashmap_list_t T) :=
  (key, ls)

/- [hashmap_main::hashmap::HashMap::{0}::get_in_list]: decreases_by tactic -/
syntax "hashmap_hash_map_get_in_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_get_in_list_loop_decreases $key $ls) =>`(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list]: termination measure -/
@[simp]
def hashmap_hash_map_get_mut_in_list_loop_terminates (T : Type)
  (ls : hashmap_list_t T) (key : Usize) :=
  (ls, key)

/- [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list]: decreases_by tactic -/
syntax "hashmap_hash_map_get_mut_in_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_get_mut_in_list_loop_decreases $ls $key) =>
  `(tactic| sorry)

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list]: termination measure -/
@[simp]
def hashmap_hash_map_remove_from_list_loop_terminates (T : Type) (key : Usize)
  (ls : hashmap_list_t T) :=
  (key, ls)

/- [hashmap_main::hashmap::HashMap::{0}::remove_from_list]: decreases_by tactic -/
syntax "hashmap_hash_map_remove_from_list_loop_decreases" term+ : tactic
macro_rules
| `(tactic| hashmap_hash_map_remove_from_list_loop_decreases $key $ls) =>
  `(tactic| sorry)

