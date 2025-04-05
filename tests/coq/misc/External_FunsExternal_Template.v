(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [external]: external functions.
-- This is a template file: rename it to "FunsExternal.lean" and fill the holes. *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Require Import External_Types.
Include External_Types.
Module External_FunsExternal_Template.

(** [core::cell::{core::cell::Cell<T>}#10::get]:
    Source: '/rustc/library/core/src/cell.rs', lines 541:4-541:32
    Name pattern: [core::cell::{core::cell::Cell<@T>}::get] *)
Axiom core_cell_Cell_get :
  forall{T : Type} (markerCopyInst : core_marker_Copy T),
        core_cell_Cell_t T -> state -> result (state * T)
.

(** [core::cell::{core::cell::Cell<T>}#11::get_mut]:
    Source: '/rustc/library/core/src/cell.rs', lines 621:4-621:45
    Name pattern: [core::cell::{core::cell::Cell<@T>}::get_mut] *)
Axiom core_cell_Cell_get_mut :
  forall{T : Type},
        core_cell_Cell_t T -> state -> result (state * (T * (T -> state ->
          (state * (core_cell_Cell_t T)))))
.

End External_FunsExternal_Template.
