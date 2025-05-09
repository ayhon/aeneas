-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [mini_tree]
import Aeneas
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace mini_tree

/- [mini_tree::Node]
   Source: 'tests/src/mini_tree.rs', lines 3:0-5:1 -/
inductive Node where
| mk : Option Node → Node

def Node.child (x : Node) := match x with | Node.mk x1 => x1

@[simp]
theorem Node.child._simpLemma_ (child : Option Node) :
  (Node.mk child).child = child := by rfl

/- [mini_tree::Tree]
   Source: 'tests/src/mini_tree.rs', lines 9:0-11:1 -/
structure Tree where
  root : Option Node

/- [mini_tree::{mini_tree::Tree}::explore]: loop 0:
   Source: 'tests/src/mini_tree.rs', lines 17:8-19:9 -/
def Tree.explore_loop (current_tree : Option Node) : Result Unit :=
  match current_tree with
  | none => ok ()
  | some current_node => Tree.explore_loop current_node.child
partial_fixpoint

/- [mini_tree::{mini_tree::Tree}::explore]:
   Source: 'tests/src/mini_tree.rs', lines 14:4-20:5 -/
@[reducible]
def Tree.explore (self : Tree) : Result Unit :=
  Tree.explore_loop self.root

end mini_tree
