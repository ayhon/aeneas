import Aeneas
open Aeneas.Std Result

set_option maxHeartbeats 1000000

namespace Primitives

end Primitives

namespace Tutorial.Solutions

/- [tutorial::mul2_add1]:
   Source: 'src/lib.rs', lines 11:0-11:31 -/
def mul2_add1 (x : U32) : Result U32 :=
  do
  let i ← x + x
  i + 1#u32

#check U32.add_spec

/-- Theorem about `mul2_add1`: without the `progress` tactic -/
-- @[pspec]
theorem mul2_add1_spec (x : U32) (h : 2 * ↑x + 1 ≤ U32.max)
  : ∃ y, mul2_add1 x = ok y ∧
  ↑y = 2 * ↑x + (1 : Int)
  := by
  rw [mul2_add1]
  have ⟨ x1, hEq1, hPost1 ⟩ := @U32.add_spec x x (by scalar_tac)
  simp [hEq1]
  have ⟨ x2, hEq2, hPost2 ⟩ := @U32.add_spec x1 1#u32 (by scalar_tac)
  simp [hEq2]
  scalar_tac

/-- Theorem about `mul2_add1`: with the `progress` tactic -/
-- @[pspec]
theorem mul2_add1_spec' (x : U32) (h : 2 * ↑x + 1 ≤ U32.max)
  : ∃ y, mul2_add1 x = ok y ∧
  ↑y = 2 * ↑x + (1 : Int)
  := by
  rw [mul2_add1]
  progress with U32.add_spec as ⟨ x1 ⟩
  progress as ⟨ x2 ⟩
  scalar_tac

/- [tutorial::mul2_add1_add]:
   Source: 'src/lib.rs', lines 15:0-15:43 -/
def mul2_add1_add (x : U32) (y : U32) : Result U32 :=
  do
  let i ← mul2_add1 x
  i + y

/-- Theorem about `mul2_add1_add` -/
theorem mul2_add1_add_spec (x : U32) (y : U32) (h : 2 * ↑x + 1 + ↑y ≤ U32.max) :
  ∃ z, mul2_add1_add x y = ok z ∧
  ↑z = 2 * ↑x + (1 : Int) + ↑y := by
  rw [mul2_add1_add]
  progress with mul2_add1_spec as ⟨ x1 ⟩
  progress as ⟨ x2 ⟩
  scalar_tac

/- [tutorial::CList]
   Source: 'src/lib.rs', lines 32:0-32:17 -/
inductive CList (T : Type) :=
| CCons : T → CList T → CList T
| CNil : CList T

open CList

/-- Convert a "custom" list to a standard Lean list.

    By putting this definition in the namespace `CList`, we give the possibility of using the `.`
    notation: if `x` has type `CList α` we can write `x.toList` instead of `toList x`.
 -/
@[simp] def CList.toList {α : Type} (x : CList α) : List α :=
  match x with
  | CNil => []
  | CCons hd tl => hd :: tl.toList

/- [tutorial::list_nth]:
   Source: 'src/lib.rs', lines 37:0-37:56 -/
divergent def list_nth {T : Type} (l : CList T) (i : U32) : Result T :=
  match l with
  | CList.CCons x tl =>
    if i = 0#u32
    then Result.ok x
    else do
         let i1 ← i - 1#u32
         list_nth tl i1
  | CList.CNil => Result.fail .panic

/-- Theorem about `list_nth` -/
theorem list_nth_spec {T : Type} [Inhabited T] (l : CList T) (i : U32)
  (h : i.val < l.toList.length) :
  ∃ x, list_nth l i = ok x ∧
  x = l.toList.index i.toNat
  := by
  rw [list_nth]
  split
  . split
    . simp_all
    . simp_all
      progress as ⟨ i1 ⟩
      progress as ⟨ x ⟩
      simp_all
  . simp_all
    scalar_tac

/- [tutorial::i32_id]:
   Source: 'src/lib.rs', lines 78:0-78:29 -/
divergent def i32_id (i : I32) : Result I32 :=
  if i = 0#i32
  then Result.ok 0#i32
  else do
       let i1 ← i - 1#i32
       let i2 ← i32_id i1
       i2 + 1#i32

/-- Theorem about `i32_id` -/
theorem i32_id_spec (n : I32) (h : 0 ≤ n.val) :
  i32_id n = ok n := by
  rw [i32_id]
  split
  . simp [*]
  . progress as ⟨ n1 ⟩
    progress
    progress as ⟨ n2 ⟩
    scalar_tac
termination_by n.toNat
decreasing_by
  -- We always need to start termination proofs with this tactic (it massages the goal)
  simp_wf
  -- It is an arithmetic goal:
  scalar_tac
  -- Remark: as the pattern above is quite common (`simp_wf; scalar_tac`),
  -- we introduced the tactic `scalar_decr_tac` (it does the same)

/- [tutorial::even]:
   Source: 'src/lib.rs', lines 87:0-87:28 -/
mutual divergent def even (i : U32) : Result Bool :=
  if i = 0#u32
  then Result.ok true
  else do
       let i1 ← i - 1#u32
       odd i1

/- [tutorial::odd]:
   Source: 'src/lib.rs', lines 96:0-96:27 -/
divergent def odd (i : U32) : Result Bool :=
  if i = 0#u32
  then Result.ok false
  else do
       let i1 ← i - 1#u32
       even i1

end

mutual

/-- The proof about `even` -/
theorem even_spec (n : U32) :
  ∃ b, even n = ok b ∧ (b ↔ Even n.val) := by
  rw [even]
  split
  . simp [*]
  . progress as ⟨ n' ⟩
    progress as ⟨ b ⟩
    simp [*]
    simp [Int.odd_sub]
termination_by n.toNat
decreasing_by scalar_decr_tac

/-- The proof about `odd` -/
theorem odd_spec (n : U32) :
  ∃ b, odd n = ok b ∧ (b ↔ Odd n.val) := by
  rw [odd]
  split
  . simp [*]
  . progress as ⟨ n' ⟩
    progress as ⟨ b ⟩
    simp [*]
    simp [Int.even_sub]
termination_by n.toNat
decreasing_by scalar_decr_tac

end

/- [tutorial::list_nth_mut1]: loop 0:
   Source: 'src/lib.rs', lines 107:0-116:1 -/
divergent def list_nth_mut1_loop
  {T : Type} (l : CList T) (i : U32) :
  Result (T × (T → (CList T)))
  :=
  match l with
  | CList.CCons x tl =>
    if i = 0#u32
    then
      let back := fun ret => CList.CCons ret tl
      Result.ok (x, back)
    else
      do
      let i1 ← i - 1#u32
      let (t, back) ← list_nth_mut1_loop tl i1
      let back1 :=
        fun ret => CList.CCons x (back ret)
      Result.ok (t, back1)
  | CList.CNil => Result.fail .panic

/- [tutorial::list_nth_mut1]:
   Source: 'src/lib.rs', lines 107:0-107:77 -/
@[reducible]
def list_nth_mut1
  {T : Type} (l : CList T) (i : U32) :
  Result (T × (T → (CList T)))
  :=
  list_nth_mut1_loop l i

/-
  # #####################################################################
  # ###   THE EXERCISES START HERE     ##################################
  # #####################################################################
-/

/- # Notations

  You will need to type some special characters like `↑` or `∃`, `∧`, etc..

  In order to type the special characters, you need to type the character '\' then a
  specific string (note that typing an abbreviation often works, for instance "ex" instead
  of "exists"):
  - `↑` : \ + u    ("up")
  - `→` : \ + r    ("right")
  - `∧` : \ + and
  - `∨` : \ + or
  - `∀` : \ + forall
  - `∃` : \ + exists
-/

/- # Basic tactics -/

/- `simp` simplifies the goal by applying rewriting lemmas and simplifying definitions
   marked as `@[simp]`. For instance, the lemma `List.length_cons` which states that
   `(hd :: tl).length = tl.length + 1` has been marked as `simp`: -/
#check List.length_cons
example α (hd : α) (tl : List α) : (hd :: tl).length = tl.length + 1 := by
  -- This proves the goal automatically, by using `List.length_cons` above
  simp

/- You can see which lemmas are applied by `simp` by using `simp?`.
   This is often useful to build the intuition of what `simp` does, especially when
   it simplifies the goal a lot.

   Note that `simp [...]` allows you to specify additional rewriting lemmas to apply,
   and that `simp only` allows to forbid `simp` from applying any lemmas other than
   the ones you provide: this allows you to have quite fine-grained control on the
   simplifications

   There are ways of being even more precise, for instance by using conversions
   (https://leanprover.github.io/theorem_proving_in_lean4/conv.html) and the `rw`
   tactic, but you will not need to understand those for this tutorial.

   Just be aware that `rw` doesn't apply simplification lemmas recursively, while
   `simp` repeatedly simplifies the goal until it can't make progress anymore.
 -/
example α (hd : α) (tl : List α) : (hd :: tl).length = tl.length + 1 := by
  simp? -- This prints: `simp only [List.length_cons]`

/- Your turn!

   Note that we give **tips and tricks** in the solutions: we advise to always have a look at them
   after you completed a proof.
 -/
example α (n : Nat) (x y : α) (l0 l1 l2 : List α)
  (h0 : l1 = x :: l0)
  (h1 : l2 = y :: l1)
  (h2 : l0.length = n) :
  l2.length = n + 2 := by
    simp [h0,h1,h2]

/- The `simp` tactic is quite flexible: -/
example α (a b c d e : α) (h0 : a = b) (h1 : b = c) (h2 : c = d) (h3 : d = e) : a = e := by
  -- You can give (named) assumptions to `simp` instead of theorems
  simp [h0]
  -- You can simplify an assumption rather than the goal
  simp [h2, h3] at h1
  /- Note that you can simplify the goal *and* all the assumptions with `simp at *`.

     Similarly, you can simplify the goal by usoing all the assumptions in the context with
    `simp [*]`:
   -/
  simp [*]

/- The `simp_all` tactic is quite powerful: it repeatedly simplifies the assumptions
   and the goal by using the simp lemmas and the assumptions themselves.

   Note that it supports a syntax similar to `simp`: `simp_all only [...]`
 -/
example α (a b c d e : α) (h0 : a = b) (h1 : b = c) (h2 : c = d) (h3 : d = e) : a = e := by
  simp_all

/- You may want to prove intermediate goals: you can do so with `have`. -/
example (a b c : Prop) (h0 : a → b → c) (h1 : a) (h2 : b) : c := by
  have h3 : c := by simp_all
  -- If you omit the name, Lean will use the name `this`
  have : c := by simp_all
  -- You can also use an instantiated lemma/assumption with `have`:
  have _h4 := h0 h1 h2
  -- If your lemma/assumption has a precondition (i.e., if it is an implication)
  -- you can use the keyword `by` to prove it
  have := h0 (by simp [*]) (by simp [*])
  -- The `apply` tactic allows to apply a theorem or an assumption to the goal, if
  -- the conclusion of the assumption/theorem matches the goal (here, it allows us
  -- to finish the goal)
  apply this

/- As a side note, `simp` simplifies implications, equivalences, etc. so you
   can actually use it to prove the goal below. -/
example (a b c : Prop) (h0 : a → b → c) (h1 : a) (h2 : b) : c := by
  simp_all

/- Your turn! -/
example (a b c d : Prop) (h0 : a → b → c) (h1 : c → d → e)
  (ha : a) (hb : b) (hd : d) : e := by
    apply h1 <;> try assumption
    apply h0 <;> try assumption

/- You can apply a simplification lemma the other way around: -/
example α (a b c : α) (h0 : a = b) (h1 : b = c) : a = c := by
  simp [← h1]
  simp [← h0]

/- To prove a goal of the shape `∀ x0 x1, ...` use `intro y0 y1 ...` to introduce
   the quantified variables in the context. -/
example α (p q : α → Prop) (h0 : ∀ x, p x) (h1 : ∀ x, p x → q x) : ∀ x, q x := by
  intro x
  have h2 := h0 x
  have h3 := h1 x h2
  apply h3

/- If the goal is an linear arithmetic goal, you can use `scalar_tac` to discharge it -/
example (x y z : Int) (h0 : x + y ≤ 3) (h1 : 2 * z ≤ 4) : x + y + z ≤ 5
  := by scalar_tac

/- Note that `scalar_tac` is aware of the bounds of the machine integers -/
example (x : U32) : 0 ≤ x.val ∧ x.val ≤ 2 ^ 32 - 1 := by scalar_tac

/- Renaming: note that the variables which appear in grey are variables which you can't
   reference directly, either because Lean automatically introduced fresh names for them,
   or because they are shadowed. You can use the `rename` and `rename_i` tactics to rename$
   them. -/
example α (p q r : α → Prop) (h : ∀ x, p x) (h : ∀ x, p x → q x) (h : ∀ x, q x → r x) :
  ∀ x, r x := by
  -- Rename all the unnamed variables/assumptions at once
  rename_i hp hpq
  -- The `rename` tactic allows to use a pattern to select the variable/assumption to rename
  rename ∀ (x : α), p x => h0
  rename ∀ (x : α), p x → q x => h1
  -- You can use holes in your pattern
  rename ∀ _, _ → _ => h2
  --
  simp_all

/- **Coercions**:
   The notation `↑` indicates a coercion. For instance:
   - if `x` is a machine scalar, `↑x : Int` desugars to `x.val`
   - if `v` is a vector (see exercises below), `↑v : List α` desugars to `v.val`

   Note that if you don't know what a **notation** which appears in the goal is exactly, just
   put your mouse over it.

   If you find coercions too confusing, you can set the option below to `false`.
   Note however that the goals will become significantly more verbose.
 -/
set_option pp.coercions true

/- # Reasoning about lists

   Small preparation for theorem `list_nth_mut1`.
 -/

/- Reasoning about `List.index`.

   You can use the following two lemmas.
 -/
#check List.index_zero_cons
#check List.index_nzero_cons

/- Example 1: indexing the first element of the list -/
example [Inhabited α] (i : U32) (hd : α) (tl : CList α)
  (hEq : i = 0#u32) :
  (hd :: tl.toList).index i.toNat = hd := by
  have hi : i.toNat = 0 := by scalar_tac
  simp only [hi]
  --
  have hIndex := List.index_zero_cons hd tl.toList
  simp only [hIndex]

/- Example 2: indexing in the tail -/
example [Inhabited α] (i : U32) (hd : α) (tl : CList α)
  (hEq : i ≠ 0#u32) :
  (hd :: tl.toList).index i.toNat = tl.toList.index (i.toNat - 1) := by
  -- Note that `scalar_tac` is aware of `Arith.Nat.not_eq`
  have hIndex := List.index_nzero_cons hd tl.toList i.toNat (by scalar_tac)
  simp only [hIndex]

/- Note that `List.index_zero_cons` and `List.index_nzero_cons` have been
   marked as `@[simp]` and are thus automatically applied. Also note
   that `simp` can automatically prove the premises of rewriting lemmas,
   if it has enough information.

   For this reason, `simp [*]` and `simp_all` can often do more work than
   you expect. -/
example [Inhabited α] (i : U32) (hd : α) (tl : CList α)
  (hEq : i = 0#u32) :
  (hd :: tl.toList).index i.toNat = hd := by
  simp [hEq]

/- Note that `simp_all` manages to automatically apply `List.index_nzero_cons` below,
   by using the fact that `i ≠ 0#u32`. -/
example [Inhabited α] (i : U32) (hd : α) (tl : CList α)
  (hEq : i ≠ 0#u32) :
  (hd :: tl.toList).index i.toNat = tl.toList.index (i.toNat - 1) := by
  simp_all

/- Below, you will need to reason about `List.update`.
   You can use the following lemmas.

   Those lemmas have been marked as `@[simp]`, meaning that if `simp` is properly used,
   it will manage to apply them automatically.
 -/
#check List.update_zero_cons
#check List.update_nzero_cons

/- # Some proofs of programs -/

/-- Theorem about `list_nth_mut1`.

    **Hints**:
    - you can use `progress` to automatically apply a lemma, then refine it into
      `progress as ⟨ ... ⟩` to name the variables and the post-conditions(s) it introduces.
    - if there is a disjunction or branching (like an `if then else`) in the goal, use `split`
    - if the goal is a conjunction, you can use `split_conjs` to introduce one subgoal
      per disjunct
    - you should use `progress` for as long as you see a monadic `do` block, unless you
      see a branching, in which case you should use `split`.

    **Remark**: we wrote two versions of the solution in `Solutions.lean`:
    - a verbose one, where we attempt to be precise with the simplifer and
      precisely instantiate the lemmas we need. This is for pedagogical
      purpose.
    - a simpler one, which is closer to what one would write in a real
      development
 -/
theorem list_nth_mut1_spec {T: Type} [Inhabited T] (l : CList T) (i : U32)
  (h : i.val < l.toList.length) :
  ∃ x back, list_nth_mut1 l i = ok (x, back) ∧
  x = l.toList.index i.toNat ∧
  -- Specification of the backward function
  ∀ x', (back x').toList = l.toList.update i.toNat x' := by
  rw [list_nth_mut1, list_nth_mut1_loop]
  cases l <;> try scalar_tac
  case CCons hd tl =>
    simp
    split
    case isTrue i_zero => 
      simp [i_zero]
    case isFalse i_nzero =>
      have:= @U32.sub_spec i 1#u32 (by scalar_tac)
      have⟨i1, i1_st, i1_post⟩ := this
      simp [i1_st, i1_post]
      rw[<-list_nth_mut1]
      have:= list_nth_mut1_spec tl i1 -- Induction
      have⟨get, set, st, post⟩ := this (by scalar_tac)
      have: ↑i = ↑i1 + (1 : Int) := by scalar_tac
      simp [st, post, this]


/- [tutorial::list_tail]: loop 0:
   Source: 'src/lib.rs', lines 118:0-123:1 -/
divergent def list_tail_loop
  {T : Type} (l : CList T) :
  Result ((CList T) × (CList T → CList T))
  :=
  match l with
  | CList.CCons t tl =>
    do
    let (c, back) ← list_tail_loop tl
    let back1 :=
      fun ret => CList.CCons t (back ret)
    Result.ok (c, back1)
  | CList.CNil => Result.ok (CList.CNil, fun ret => ret)

/- [tutorial::list_tail]:
   Source: 'src/lib.rs', lines 118:0-118:68 -/
@[reducible]
def list_tail
  {T : Type} (l : CList T) :
  Result ((CList T) × (CList T → CList T))
  :=
  list_tail_loop l

/- [tutorial::append_in_place]:
   Source: 'src/lib.rs', lines 125:0-125:67 -/
def append_in_place
  {T : Type} (l0 : CList T) (l1 : CList T) : Result (CList T) :=
  do
  let (_, list_tail_back) ← list_tail l0
  Result.ok (list_tail_back l1)


/-- Theorem about `list_tail`: exercise -/
@[pspec]
theorem list_tail_spec {T : Type} (l : CList T) :
  ∃ back, list_tail l = ok (CList.CNil, back) ∧
  ∀ tl', (back tl').toList = l.toList ++ tl'.toList := by
  rw [list_tail, list_tail_loop]
  split
  · rename_i tl
    rw [<-list_tail]
    have⟨back, back_st, post⟩:= list_tail_spec tl
    simp [back_st,post]
  · simp

/-- Theorem about `append_in_place`: exercise -/
@[pspec]
theorem append_in_place_spec {T : Type} (l0 l1 : CList T) :
  ∃ l2, append_in_place l0 l1 = ok l2 ∧
  l2.toList = l0.toList ++ l1.toList := by
  rw [append_in_place]
  have := list_tail_spec l0
  have⟨back, st, post⟩ := this
  simp only [st, post]
  simp
  apply post
  /- progress as ⟨back, back_post⟩ -/
  /- apply back_post -/

/- [tutorial::reverse]: loop 0:
   Source: 'src/lib.rs', lines 147:4-154:1 -/
divergent def reverse_loop
  {T : Type} (l : CList T) (out : CList T) : Result (CList T) :=
  match l with
  | CList.CCons hd tl => reverse_loop tl (CList.CCons hd out)
  | CList.CNil => Result.ok out

@[pspec]
theorem reverse_loop_spec {T : Type} (l : CList T) (out : CList T) :
  ∃ l', reverse_loop l out = ok l' ∧
  l'.toList = l.toList.reverse ++ out.toList -- Leaving the post-condition as an exercise
  := by
  rw [reverse_loop]
  split <;> simp
  apply reverse_loop_spec -- Induction!
  /- case h_1 hd tl => -/
  /-   have := reverse_loop_spec tl (CCons hd out) -/
  /-   assumption -/

/- [tutorial::reverse]:
   Source: 'src/lib.rs', lines 146:0-154:1 -/
def reverse {T : Type} (l : CList T) : Result (CList T) :=
  reverse_loop l CList.CNil

theorem reverse_spec {T : Type} (l : CList T) :
  ∃ l', reverse l = ok l' ∧
  l'.toList = l.toList.reverse -- Leaving the post-condition as an exercise
  := 
  by
  rw [reverse]
  have:= reverse_loop_spec l CNil
  simp at this
  assumption

/-
  # BIG NUMBERS
 -/

/- Deactivating some simplification procedures which are not necessary and which sometimes
   makes the goal hard to understand by reducing 2 ^ 32 to 4294967296.

   Remark: as mentioned above, if the simplifier simplifies too much, you can display the
   simplification lemmas and the simplification procedures it uses with `simp?`, `simp_all?`,
   etc. and then use `simp only` to control the set of simplifications which gets applied.
 -/
attribute [-simp] Int.reducePow Nat.reducePow

/- [tutorial::zero]: loop 0:
   Source: 'src/lib.rs', lines 6:4-11:1 -/
divergent def zero_loop
  (x : alloc.vec.Vec U32) (i : Usize) : Result (alloc.vec.Vec U32) :=
  let i1 := alloc.vec.Vec.len x
  if i < i1
  then
    do
    let (_, index_mut_back) ←
      alloc.vec.Vec.index_mut
        (core.slice.index.SliceIndexUsizeSliceTInst U32) x i
    let i2 ← i + 1#usize
    let x1 := index_mut_back 0#u32
    zero_loop x1 i2
  else Result.ok x


/-- Auxiliary definitions to interpret a vector of u32 as a mathematical integer -/
@[simp]
def toInt_aux (l : List U32) : ℤ :=
  match l with
  | [] => 0
  | x :: l =>
    x + 2 ^ 32 * toInt_aux l

@[reducible]
def toInt (x : alloc.vec.Vec U32) : ℤ := toInt_aux x.val

/-- The theorem about `zero_loop`: exercise.

    Hints:
    - if you have lemma (or assumption): `h : ∀ x, P x → Q x`, you can instantiate it and introduce it in
      the context by doing:
      `have h' := h y (by tactic)`
    - for the proof of termination: look at `i32_id_spec` above
    - if you need to do a case disjunction, use `dcases`
      Ex.: `dcases x = y` will introduce two goals, one with the assumption `x = y` and the
      other with the assumption `x ≠ y`. You can name this assumption by writing: `dcases h : x = y`
 -/
@[pspec]
theorem zero_loop_spec
  (x : alloc.vec.Vec U32) (i : Usize) (h : i.val ≤ x.length) :
  ∃ x',
    zero_loop x i = ok x' ∧
    x'.length = x.length ∧
    (∀ j, j < i.toNat → x'.val.index j = x.val.index j) ∧
    (∀ j, i.toNat ≤ j → j < x.length → x'.val.index j = 0#u32) := by
  rw [zero_loop]
  simp
  split
  case isTrue i_idx =>
    progress as ⟨_, back⟩
    progress as ⟨i2, i2_spec⟩
    progress as ⟨x', x'_len, x'_lhs, x'_rhs⟩ -- Inductive step
                                             -- It's terminating if we perform the induction on the idx
    split_conjs
    · simp [x'_len]
    · intro j j_lt_i
      /- have x'_lhs := x'_lhs j -/
      have: j < i2.toNat := by scalar_tac
      simp [x'_lhs j this, List.index_update_neq, j_lt_i]
    · intro j i_le_j j_idx
      cases eq_or_lt_of_le i_le_j
      case inl i_eq_j => 
        have: j < i2.toNat := by scalar_tac
        simp [x'_lhs j this, i_eq_j, List.index_update_eq, j_idx]
      case inr i_lt_j =>
        have: ↑i2-(1: Int)< j := by scalar_tac
        apply x'_rhs
        · scalar_tac
        · simp [List.length_update, j_idx]
  case isFalse i_oob =>
    simp
    intros
    scalar_tac
termination_by x.length - i.toNat
decreasing_by scalar_decr_tac

/- [tutorial::zero]:
   Source: 'src/lib.rs', lines 5:0-5:28 -/
def zero (x : alloc.vec.Vec U32) : Result (alloc.vec.Vec U32) :=
  zero_loop x 0#usize

/-- You will need this lemma for the proof of `zero_spec`

    Advice: do the proof of `zero_spec` first, then come back to prove this lemma.
-/
theorem all_nil_impl_toInt_eq_zero
  (l : List U32) (h : ∀ (j : ℕ), j < l.length → l.index j = 0#u32) :
  toInt_aux l = 0 := by
  /- There are two ways of proving this theorem.

     Either you use the induction tactic applied to `l` (*advised*):
     ```
     induction l
     . sorry
     . rename_i hd tl hInd -- To rename the variables introduced by the tactic
       sorry
     ```

     Or you write it as a recursive definition:
     ```
     match l with
     | [] => sorry
     | hd :: tl =>
       -- At some point you will need to introduce a recursive call:
       -- `have := all_nil_impl_toInt_eq_zero ...`
       sorry
     ```
   -/
   match l with 
   | [] => simp
   | hd :: tl =>
      have: hd = 0#u32 := by 
        apply h 0
        scalar_tac
      rw [this]
      simp; simp at h
      apply all_nil_impl_toInt_eq_zero
      intro j j_tl_idx
      have h := h (j+1) (by simp[j_tl_idx])
      assumption

/-- The theorem about `zero` -/
theorem zero_spec (x : alloc.vec.Vec U32) :
  ∃ x',
    zero x = ok x' ∧
    x'.length = x.length ∧
    toInt x' = 0 := by
  rw [zero]
  progress as ⟨x', x'_len, _, x'_rhs⟩; simp [*]
  rw [toInt]
  apply all_nil_impl_toInt_eq_zero
  intros
  apply x'_rhs _ <;> scalar_tac

/- [tutorial::add_no_overflow]: loop 0:
   Source: 'src/lib.rs', lines 19:4-24:1 -/
divergent def add_no_overflow_loop
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) (i : Usize) :
  Result (alloc.vec.Vec U32)
  :=
  let i1 := alloc.vec.Vec.len x
  if i < i1
  then
    do
    let i2 ←
      alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceTInst U32) y i
    let (i3, index_mut_back) ←
      alloc.vec.Vec.index_mut
        (core.slice.index.SliceIndexUsizeSliceTInst U32) x i
    let i4 ← i3 + i2
    let i5 ← i + 1#usize
    let x1 := index_mut_back i4
    add_no_overflow_loop x1 y i5
  else Result.ok x

theorem List.drop_index_unfold[Inhabited α](i: Nat)(ls: List α)
(i_idx: i < ls.length)
: ls.drop i = ls.index i :: ls.drop (i+1)
:= by
  match ls, i with
  | [], _  => contradiction
  | x::xs, 0 => simp
  | x::xs, i+1 => simp at *; apply List.drop_index_unfold; assumption
    

/-- You will need this lemma for the proof of `add_no_overflow_loop_spec`.

    Advice: do the proof of `add_no_overflow_loop_spec` first, then come back to prove this lemma.

    Hint: you will need to reason about non-linear arithmetic. You can use two tactics to do so:
    - `scalar_nf`, `scalar_nf at h`, `scalar_nf at *`:
      normalizes (simplifies) the expressions of the shape `a ^ k * x + ... + b ^ k * y `
    - `scalar_eq_nf`: similar, but tuned to prove goals of the shape: `... = ...`
    You can try both tactics and see their effect.
 -/
@[simp]
theorem toInt_aux_drop (l : List U32) (i : Nat) (h0 : i < l.length) :
  toInt_aux (l.drop i) = l.index i + 2 ^ 32 * toInt_aux (l.drop (i + 1)) := by
  -- NOTE: Droping i elements is the same as keeping the i-th and droping i+1
  simp [List.drop_index_unfold i l h0]

  
  --- NOTE: This is a first attempt which I commented out because I wasn't too
  ---       sure of what I was doing. I was having problems understanding where
  ---       the recursion should happen, and I think in general I've developed
  ---       a tendency to not do a double induction too freely, since it has 
  ---       happened in the past that the induction hypothesis simply get out
  ---       of hand. I took a minute to think about the proof, and tried to do
  ---       the induction on `l.drop i` at some point. This lead nowhere, but
  ---       helped me realize the fundamental property of `drop` and `index`
  ---       that we were actually exploiting here, `List.drop_index_unfold`.
  ---       With it, toInt_aux_drop is just a result of applying the definition
  ---       of toInt_aux. Furthermore, I implemented `List.drop_index_unfold`
  ---       in a more functional style, which helped me manage the complexity
  ---       of multiple induction. I'm quite happy with how simple the proofs
  ---       have turned out.

  /- let rec last_of_drop_len_sub_1{α: Type}(ls: List α)(nonempty: ls ≠ []) -/
  /- : ls.drop (ls.length - 1) = [ls.getLast nonempty] -/
  /- := by -/
  /-   match ls with -/
  /-   | x :: [] => simp -/
  /-   | _ :: y :: ys => -/ 
  /-     simp [List.getLast] -/
  /-     exact last_of_drop_len_sub_1 (y :: ys) (List.cons_ne_nil y ys) -/
  /- let rec last_of_index_len_sub_1{α: Type}[Inhabited α](ls: List α)(nonempty: ls ≠ []) -/
  /- : ls.index (ls.length - 1) = ls.getLast nonempty -/
  /- := by -/
  /-   match ls with -/
  /-   | x :: [] => simp -/
  /-   | _ :: y :: ys  => -/ 
  /-     simp [List.getLast] -/
  /-     apply last_of_index_len_sub_1 -/
      

  /- if h: l = [] then -/
  /-   subst h -/
  /-   contradiction -/
  /- else -/
  /-   have: 1 <= l.length := by exact Nat.one_le_of_lt h0 -/
  /-   if i = l.length - 1 then -/
  /-     subst i -/
  /-     rw [Nat.sub_add_cancel (by assumption)] -/
  /-     simp [ toInt_aux -/
  /-          , last_of_drop_len_sub_1 l h -/
  /-          , last_of_index_len_sub_1 l h] -/
  /-   else -/



/-- You will need this lemma for the proof of `add_no_overflow_loop_spec`.

    Advice: do the proof of `add_no_overflow_loop_spec` first, then come back to prove this lemma.

    Remark: this proof is slightly technical and requires to control rewritings precisely (we
    haven't explained how to do that above) to prove at some point that (beware of the conversions
    between ℕ and ℤ!):
    `2 ^ (i * 32) = ((2 ^ ((i - 1) * 32) * 2 ^ 32 : Int)`

    We recommend that you keep this proof until the very end then:
    - either ask for help
    - or go see the solution
 -/
@[simp]
theorem toInt_aux_update (l : List U32) (i : Nat) (x : U32) (h0 : i < l.length) :
  toInt_aux (l.update i x) = toInt_aux l + 2 ^ (32 * i) * (x - l.index i) := by
  -- NOTE: Updating a position is the same as adding the difference of changes to that position
  match l, i with
  | [], _ =>  contradiction
  | hd::tl, 0 => simp; scalar_tac
  | hd::tl, i+1 => 
      simp
      have := toInt_aux_update tl i x (by simp at h0; assumption)
      simp[this]
      scalar_nf

/-- The proof about `add_no_overflow_loop`.

    Hint: you will need to reason about non-linear arithmetic with `scalar_nf` and
    `scalar_eq_nf` (see above).
 -/
@[pspec]
theorem add_no_overflow_loop_spec
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) (i : Usize)
  (hLength : x.length = y.length)
  -- No overflow occurs when we add the individual thunks
  (hNoOverflow : ∀ (j : Nat), i.toNat ≤ j → j < x.length → (x.val.index j).val + (y.val.index j).val ≤ U32.max)
  (hi : i.val ≤ x.length) :
  ∃ x', 
    add_no_overflow_loop x y i = ok x' ∧
    x'.length = x.length ∧
    toInt x' = toInt x + 2 ^ (32 * i.toNat) * toInt_aux (y.val.drop i.toNat) := by
    -- ⟦x'⟧ = ⟦x⟧ + ⟦y[i:]⟧
  rw [add_no_overflow_loop]
  simp
  split
  case isFalse i_oob =>
    have: i.toNat = x.length := by scalar_tac
    simp [this, toInt_aux_drop, hLength]
  case isTrue i_idx => 
    progress as ⟨y_i, y_i_def⟩
    progress as ⟨x_i, x_i_def⟩
    progress as ⟨z_i, z_i_def⟩
    · simp [x_i_def, y_i_def]
      apply hNoOverflow <;> scalar_tac
    progress as ⟨succ_i, succ_i_def⟩
    progress as ⟨x', x'Length, x'Post⟩
    · intro j succ_i_le_j
      simp [succ_i_le_j, ]
      -- WARN: I can't seem to make this be immediately deduced by Lean
      -- NOTE: This was mainly a problem with different types representing the 
      --       same thing. We have i : U32 but j : ℕ
      have: (x.val.update i.toNat z_i).index j = x.val.index j := by
        apply List.index_update_neq x.val i.toNat j _ (by scalar_tac)
      -- NOTE: In general, it seems better to introduce all hypothesis if
      --       possible, since the difference in representation may not make
      --       certain matches happen automatically. In this case, for instance,
      --       we don't have j < x.length, but j < ↑x.length. However, hNoOverflow
      --       doesn't work because we don't automatically relate them. If I put
      --       j < ↑x.length in the hypothesis, however, the `scalar_tac` is able
      --       to match them.
      intro j_idx
      simp [this, hNoOverflow j (by scalar_tac) (by scalar_tac)]
    split_conjs
    · simp [x'Length]
    · -- Goal: ⟦x'⟧ = ⟦x⟧  +  2^(32·i) · ⟦ y[i:]⟧
      -- Hypo: ⟦x'⟧ = ⟦{x with i := z_i}⟧ + 2 ^(32·(i+1)) · ⟦y[i+1:]⟧
      rw [x'Post, toInt]
      -- I can probably close this branch with `scalar_tac` as long as I do
      -- the proper unfolding of `drop` and `update`. Then, I just need to
      -- check equality of the expressioons with `scalar_tac`
      simp [succ_i_def]
      -- NOTE: Applying rewrites with preconditions sucks (or idk how to do it)
      have := toInt_aux_update x.val i.toNat z_i (by scalar_tac)
      rw [this]
      have := toInt_aux_drop y.val i.toNat  (by scalar_tac)
      rw [this, <-y_i_def, <-x_i_def, z_i_def, toInt]
      simp
      -- NOTE: Since the expression is not linear, we use `ring_nf` instead of 
      --       `scalar_tac`, although there is a `nonLin` option for it.
      ring_nf 
termination_by x.length - i.toNat
decreasing_by scalar_tac

      
/- [tutorial::add_no_overflow]:
   Source: 'src/lib.rs', lines 18:0-18:50 -/
def add_no_overflow
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) :
  Result (alloc.vec.Vec U32)
  :=
  add_no_overflow_loop x y 0#usize

/-- The proof about `add_no_overflow` -/
theorem add_no_overflow_spec (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32)
  (hLength : x.length = y.length)
  (hNoOverflow : ∀ (j : Nat), j < x.length → (x.val.index j).val + (y.val.index j).val ≤ U32.max) :
  ∃ x', add_no_overflow x y = ok x' ∧
  x'.length = y.length ∧
  toInt x' = toInt x + toInt y := by
  rw [add_no_overflow]
  progress as ⟨x', x'Len, x'Post⟩
  ·intro j j_pos j_idx
   apply hNoOverflow; assumption
  split_conjs <;> simp [hLength,x'Len,x'Post]

/- [tutorial::add_with_carry]: loop 0:
   Source: 'src/lib.rs', lines 39:4-50:1 -/
divergent def add_with_carry_loop
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) (c0 : U8) (i : Usize) :
  Result (U8 × (alloc.vec.Vec U32))
  :=
  let i1 := alloc.vec.Vec.len x
  -- i1 is the length of the vector
  -- i is the counter of the loop
  if i < i1
  then
    do
    let i2 ← -- x[i]
      alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceTInst
        U32) x i
    let i3 ← Scalar.cast .U32 c0 -- carry
    let p ← core.num.U32.overflowing_add i2 i3 -- (x[i] + carry) with overflow
    let (sum, c1) := p -- (sum, didOverflowCarry)
    let i4 ← -- y[i]
      alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceTInst U32) y i
    let p1 ← core.num.U32.overflowing_add sum i4 -- (sum + y[i]) with overflow
    let (sum1, c2) := p1 -- (final, didOverflowFinal)
    let i5 ← Scalar.cast_bool .U8 c1
    let i6 ← Scalar.cast_bool .U8 c2
    let c01 ← i5 + i6 -- didOverflowCarry + didOverflowFinal
    let (_, index_mut_back) ← -- &mut x[i]
      alloc.vec.Vec.index_mut
        (core.slice.index.SliceIndexUsizeSliceTInst U32) x i
    let i7 ← i + 1#usize -- next idx
    let x1 := index_mut_back sum1 -- mutated vec
    add_with_carry_loop x1 y c01 i7 -- recurse!
  else Result.ok (c0, x)

/-- The proof about `add_with_carry_loop` -/
@[pspec]
theorem add_with_carry_loop_spec
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) (c0 : U8) (i : Usize)
  (hLength : x.length = y.length)
  (hi : i.val ≤ x.length)
  (hCarryLe : c0.val ≤ 1) :
  ∃ x' c1,
    add_with_carry_loop x y c0 i = ok (c1, x') ∧ -- statement
    x'.length = x.length ∧ -- x'Len
    c1.val ≤ 1 ∧ -- c1 is "bool"
    -- ↓ loop_invariant
    toInt x' + c1.val * 2 ^ (32 * x'.length) = 
    toInt x + 2 ^ (32 * i.toNat) * toInt_aux (y.val.drop i.toNat) + c0.val * 2 ^ (32 * i.toNat) := by
  rw [add_with_carry_loop]
  simp
  split
  case isFalse i_oob =>
    have: i.toNat = x.length := by scalar_tac
    simp [*]
  case isTrue i_idx =>
    progress as ⟨x_i, x_i_def⟩
    progress as ⟨c0', c0'_def⟩
    progress as ⟨sum_1, didOverflow_1, sum_1_def⟩
    progress as ⟨y_i, y_i_def⟩
    progress as ⟨sum_2, didOverflow_2, sum_2_def⟩
    progress as ⟨u1, u1_def⟩
    progress as ⟨u2, u2_def⟩
    progress as ⟨c01, c01_def⟩
    progress as ⟨x_i', x_i'_def⟩ -- Wait, what? I expected a backward function here
    -- Did it automatically deduce that `update` is that backward function?
    -- Is it because index_mut uses `sorry`?
    have: x_i' = x_i := by 
      rw [<-x_i_def] at x_i'_def; exact x_i'_def
    subst x_i'
    -- For now this seems to make things cleaner
    progress as ⟨succ_i, succ_i_def⟩
    -- And now, for the inductive step
    progress as ⟨x', c1, x'Length, c1_booly, loop_inv⟩
    simp
    split_conjs 
    · simp [x'Length, List.length_update]
    · assumption
    · -- This part is a bit longer. Let's write down the goal
      -- Goal: ⟦x'⟧ + c1·2^(32*x.len) = ⟦x⟧ + 2^(32*i)·⟦y[i:0]⟧ + c0·2^(32·i)
      -- Hypo: ⟦x'⟧ + c1·2^(32*x.len) = ⟦{x with i := sum_2}⟧ + 2^(32·(i+1))·⟦y[i+1:0]⟧
      -- This is quite similar to what we had before
      simp [loop_inv, succ_i_def, toInt]
      rw [
        toInt_aux_update x i.toNat sum_2 (by scalar_tac),
        toInt_aux_drop y i.toNat (by scalar_tac),
        <-x_i_def,
        <-y_i_def,
      ]
      -- Right now I can't simply `ring_nf` since the definitions
      -- for `sum_1` and `sum_2` contain conditionals.
      -- I'll destruct by cases and see if I can solve the resulting
      -- goals more easily.
      -- Before that though, let's get rid of some unimportant details
      generalize toInt_aux (List.drop (i.toNat + 1) (y.val)) = num_y_rest
      generalize toInt_aux (x.val) = num_x
      simp [ite_prop_iff_or] at sum_1_def sum_2_def
      have max_def : U32.max = 2^32 - 1 := rfl
      match sum_1_def, sum_2_def with
      | .inl ⟨bounds1, sum_1_def, didOverflow_1_def⟩
      , .inl ⟨bounds2, sum_2_def, didOverflow_2_def⟩ =>

          -- I still have a pretty complicated result that `ring_nf` is not able
          -- to close. Let's look into it a bit more carefully.
          /-
          ⊢ 2 ^ (32 * (↑i).toNat) * (↑x_i + ↑c0' - U32.max - 1 + ↑y_i - U32.max - 1 - ↑x_i)  +  2 ^ (32 * ((↑i).toNat + 1)) * num_y_rest  +  ↑c01 * 2 ^ (32 * ((↑i).toNat + 1)) =
                                                                                      ....  +  2 ^ (32 * (↑i).toNat) * 2^32 * num_y_rest  +  ↑c01 * 2 ^ (32 * (↑i).toNat) * 2^32 =
            2 ^ (32 * (↑i).toNat) * (     + ↑c0' - U32.max - 1 + ↑y_i - U32.max - 1       + 2^32 * num_y_rest + ↑c01 * 2^32 ) =
            2 ^ (32 * (↑i).toNat) * (     + ↑c0' -    2^32     + ↑y_i    - U32.max - 1       + 2^32 * num_y_rest + ↑c01 * 2^32 ) =
            -- What's crucial here is that `c01 = 2`! But this is not done automatically unless
            2 ^ (32 * (↑i).toNat) * (↑y_i + 2 ^ 32 * num_y_rest) + ↑c0 * 2 ^ (32 * (↑i).toNat)
          -/
          simp [didOverflow_1_def, didOverflow_2_def] at u1_def u2_def
          simp [u1_def, u2_def, c01_def]
          simp [sum_2_def, sum_1_def]
          scalar_tac
      | .inr ⟨bounds1, sum_1_def, didOverflow_1_def⟩
      , .inl ⟨bounds2, sum_2_def, didOverflow_2_def⟩ =>
          simp [didOverflow_1_def, didOverflow_2_def] at u1_def u2_def
          simp [u1_def, u2_def, c01_def]
          simp [sum_2_def, sum_1_def]
          simp [c0'_def]
          -- I would expect this to be closed by `ring_nf`.
          rw[max_def]
          ring_nf
      | .inl ⟨bounds1, sum_1_def, didOverflow_1_def⟩
      , .inr ⟨bounds2, sum_2_def, didOverflow_2_def⟩ =>
          simp [didOverflow_1_def, didOverflow_2_def] at u1_def u2_def
          simp [u1_def, u2_def, c01_def]
          simp [sum_2_def, sum_1_def]
          simp [c0'_def]
          rw[max_def]
          ring_nf
      | .inr ⟨bounds1, sum_1_def, didOverflow_1_def⟩
      , .inr ⟨bounds2, sum_2_def, didOverflow_2_def⟩ =>
          simp [didOverflow_1_def, didOverflow_2_def] at u1_def u2_def
          simp [u1_def, u2_def, c01_def]
          simp [sum_2_def, sum_1_def]
          simp [c0'_def]
          ring_nf
      -- These results seem to require all the same proof. We could probably use
      -- tacticals to make this shorter. Is it useful though?
termination_by x.length - i.toNat
decreasing_by 
  any_goals simp_wf
  scalar_tac
    

/- [tutorial::add_with_carry]:
   Source: 'src/lib.rs', lines 37:0-37:55 -/
def add_with_carry
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) :
  Result (U8 × (alloc.vec.Vec U32))
  :=
  add_with_carry_loop x y 0#u8 0#usize

/-- The proof about `add_with_carry` -/
@[pspec]
theorem add_with_carry_spec
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32)
  (hLength : x.length = y.length) :
  ∃ x' c, add_with_carry x y = ok (c, x') ∧
  x'.length = x.length ∧
  c.val ≤ 1 ∧
  toInt x' + c.val * 2 ^ (32 * x'.length) = toInt x + toInt y := by
  rw [add_with_carry]
  progress as ⟨x', carry, x'Len, carry_booly, loop_inv⟩
  simp [hLength, x'Len, carry_booly, loop_inv, toInt_aux_update]
  simp [hLength] at loop_inv
  rw[<-loop_inv]
  simp [hLength] 
  apply Or.inl -- Why the carry = 0?
  scalar_tac

/- Bonus exercises -/
/-- We leave it to you to state the theorems for the functions below -/

/- [tutorial::max]:
   Source: 'src/lib.rs', lines 26:0-26:37 -/
def max (x : Usize) (y : Usize) : Result Usize :=
  if x > y
  then Result.ok x
  else Result.ok y

/- [tutorial::get_or_zero]:
   Source: 'src/lib.rs', lines 30:0-30:45 -/
def get_or_zero (y : alloc.vec.Vec U32) (i : Usize) : Result U32 :=
  let i1 := alloc.vec.Vec.len y
  if i < i1
  then
    alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceTInst
      U32) y i
  else Result.ok 0#u32

/- [tutorial::add]: loop 0:
   Source: 'src/lib.rs', lines 60:4-76:1 -/
divergent def add_loop
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) (max1 : Usize) (c0 : U8)
  (i : Usize) :
  Result (alloc.vec.Vec U32)
  :=
  if i < max1
  then
    do
    let yi ← get_or_zero y i
    let i1 ←
      alloc.vec.Vec.index (core.slice.index.SliceIndexUsizeSliceTInst U32) x i
    let i2 ← Scalar.cast .U32 c0
    let p ← core.num.U32.overflowing_add i1 i2
    let (sum, c1) := p
    let p1 ← core.num.U32.overflowing_add sum yi
    let (sum1, c2) := p1
    let i3 ← Scalar.cast_bool .U8 c1
    let i4 ← Scalar.cast_bool .U8 c2
    let c01 ← i3 + i4
    let (_, index_mut_back) ←
      alloc.vec.Vec.index_mut
        (core.slice.index.SliceIndexUsizeSliceTInst U32) x i
    let i5 ← i + 1#usize
    let x1 := index_mut_back sum1
    add_loop x1 y max1 c01 i5
  else
    if c0 != 0#u8
    then do
         let i1 ← Scalar.cast .U32 c0
         alloc.vec.Vec.push x i1
    else Result.ok x

/- [tutorial::add]:
   Source: 'src/lib.rs', lines 55:0-55:38 -/
def add
  (x : alloc.vec.Vec U32) (y : alloc.vec.Vec U32) :
  Result (alloc.vec.Vec U32)
  :=
  do
  let i := alloc.vec.Vec.len x
  let i1 := alloc.vec.Vec.len y
  let max1 ← max i i1
  let x1 ← alloc.vec.Vec.resize core.clone.CloneU32 x max1 0#u32
  add_loop x1 y max1 0#u8 0#usize

end Tutorial.Solutions
