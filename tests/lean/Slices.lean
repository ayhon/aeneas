-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [slices]
import Aeneas
open Aeneas.Std Result Error
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace slices

/- [slices::slice_subslice_from_shared]:
   Source: 'tests/src/slices.rs', lines 3:0-5:1 -/
def slice_subslice_from_shared (x : Slice U32) : Result (Slice U32) :=
  core.slice.index.Slice.index (core.slice.index.SliceIndexRangeFromUsizeSlice
    U32) x { start := 0#usize }

/- [slices::slice_subslice_from_mut]:
   Source: 'tests/src/slices.rs', lines 7:0-9:1 -/
def slice_subslice_from_mut
  (x : Slice U32) : Result ((Slice U32) × (Slice U32 → Slice U32)) :=
  core.slice.index.Slice.index_mut
    (core.slice.index.SliceIndexRangeFromUsizeSlice U32) x { start := 0#usize }

end slices
