(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [external]: type definitions *)
module External.Types
open Primitives
include External.TypesExternal

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** Trait declaration: [core::marker::Copy]
    Source: '/rustc/library/core/src/marker.rs', lines 472:0-472:21
    Name pattern: core::marker::Copy *)
noeq type core_marker_Copy_t (self : Type0) = {
  cloneCloneInst : core_clone_Clone self;
}

