(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap_main]: external function declarations *)
open primitivesLib divDefLib
open hashmapMain_TypesTheory

val _ = new_theory "hashmapMain_Opaque"


(** [hashmap_main::utils::deserialize]: forward function *)val _ = new_constant ("utils_deserialize_fwd",
  “:state -> (state # u64 hashmap_hash_map_t) result”)

(** [hashmap_main::utils::serialize]: forward function *)val _ = new_constant ("utils_serialize_fwd",
  “:u64 hashmap_hash_map_t -> state -> (state # unit) result”)

val _ = export_theory ()
