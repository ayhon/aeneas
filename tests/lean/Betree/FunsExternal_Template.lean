-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [betree]: external functions.
-- This is a template file: rename it to "FunsExternal.lean" and fill the holes.
import Aeneas
import Betree.Types
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false
open betree

/- [betree::betree_utils::load_internal_node]:
   Source: 'src/betree_utils.rs', lines 98:0-112:1 -/
axiom betree_utils.load_internal_node
  : U64 → State → Result (State × (betree.List (U64 × betree.Message)))

/- [betree::betree_utils::store_internal_node]:
   Source: 'src/betree_utils.rs', lines 115:0-129:1 -/
axiom betree_utils.store_internal_node
  :
  U64 → betree.List (U64 × betree.Message) → State → Result (State ×
    Unit)

/- [betree::betree_utils::load_leaf_node]:
   Source: 'src/betree_utils.rs', lines 132:0-142:1 -/
axiom betree_utils.load_leaf_node
  : U64 → State → Result (State × (betree.List (U64 × U64)))

/- [betree::betree_utils::store_leaf_node]:
   Source: 'src/betree_utils.rs', lines 145:0-155:1 -/
axiom betree_utils.store_leaf_node
  : U64 → betree.List (U64 × U64) → State → Result (State × Unit)

