(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap]: type definitions *)
module Hashmap.Types
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [hashmap::List] *)
type list_t (t : Type0) =
| List_Cons : usize -> t -> list_t t -> list_t t
| List_Nil : list_t t

(** [hashmap::HashMap] *)
type hashMap_t (t : Type0) =
{
  num_entries : usize;
  max_load_factor : (usize & usize);
  max_load : usize;
  slots : alloc_vec_Vec (list_t t);
}

