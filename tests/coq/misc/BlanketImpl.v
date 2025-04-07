(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [blanket_impl] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module BlanketImpl.

(** Trait declaration: [blanket_impl::Trait1]
    Source: 'tests/src/blanket_impl.rs', lines 3:0-3:15 *)
Record Trait1_t (Self : Type) := mkTrait1_t{}.

Arguments mkTrait1_t { _ }.

(** Trait declaration: [blanket_impl::Trait2]
    Source: 'tests/src/blanket_impl.rs', lines 4:0-6:1 *)
Record Trait2_t (Self : Type) := mkTrait2_t { Trait2_t_foo : result unit; }.

Arguments mkTrait2_t { _ }.
Arguments Trait2_t_foo { _ } _.

(** [blanket_impl::{blanket_impl::Trait2 for T}::foo]:
    Source: 'tests/src/blanket_impl.rs', lines 5:4-5:15 *)
Definition trait2_Blanket_foo
  {T : Type} (trait1Inst : Trait1_t T) : result unit :=
  Ok tt
.

(** Trait implementation: [blanket_impl::{blanket_impl::Trait2 for T}]
    Source: 'tests/src/blanket_impl.rs', lines 9:0-9:31 *)
Definition Trait2_Blanket {T : Type} (trait1Inst : Trait1_t T) : Trait2_t T
  := {|
  Trait2_t_foo := trait2_Blanket_foo trait1Inst;
|}.

(** [blanket_impl::Trait2::foo]:
    Source: 'tests/src/blanket_impl.rs', lines 5:4-5:15 *)
Definition trait2_foo_default
  {Self : Type} (self_clause : Trait2_t Self) : result unit :=
  Ok tt
.

End BlanketImpl.
