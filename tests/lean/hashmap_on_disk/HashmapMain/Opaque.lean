-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [hashmap_main]: opaque function definitions
import Base.Primitives
import HashmapMain.Types

structure OpaqueDefs where
  
  /- [hashmap_main::hashmap_utils::deserialize] -/
  hashmap_utils_deserialize_fwd
    : State -> Result (State × (hashmap_hash_map_t UInt64))
  
  /- [hashmap_main::hashmap_utils::serialize] -/
  hashmap_utils_serialize_fwd
    : hashmap_hash_map_t UInt64 -> State -> Result (State × Unit)
  
