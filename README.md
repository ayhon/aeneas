<p><div style="text-align: center">
<img src="static/Aeneas.jpg"
     alt="Lapyx removing arrowhead from Aeneas" title="Lapyx removing arrowhead from Aeneas"
     style=""/>
<figcaption>
Unknown author, <i>Lapyx removing arrowhead from Aeneas</i> [Fresco].
Wall in Pompei, digital image from Michael Lahanis.
<a href="https://commons.wikimedia.org/w/index.php?curid=1357010">Source</a>
</figcaption>
</div></p>

# Aeneas

Aeneas is a compiler from LLBC, a language inspired by Rust's MIR, to pure lambda calculus.
It is intended to be used in combination with [Charon](https://github.com/Kachoc/charon),
which compiles Rust programs to LLBC, to allow the verification of Rust programs in
proof assistants. It currently has a backend for the [F\*](https://www.fstar-lang.org)
theorem prover, and we intend to add backends for other provers such as
[Coq](https://coq.inria.fr/), [HOL4](https://hol-theorem-prover.org/) or
[LEAN](https://leanprover.github.io/).

## Project Structure

- `src`: the OCaml sources. Note that we rely on Dune to build the project.
- `fstar`: F\* files providing basic definitions and notations for the
  generated code (basic definitions for arithmetic types and operations,
  collections like vectors, etc.).
- `tests`: files generated by applying Aeneas on some of the test files of Charon,
  completed with hand-written files (proof scripts, mostly).
- `rust-tests`: miscelleanous files, to test the semantics of Rust or generate
  code in a one-shot manner (mostly used for the arithmetic definitions, for
  instance to generate `MIN` and `MAX` constants for all the integer types
  supported by Rust).

## Usage

The simplest way to run Aeneas is to execute `dune exec -- src/main.exe [OPTIONS] LLBC_FILE`,
where `LLBC_FILE` is an .llbc file generated by Charon.

Aeneas provides a lot of flags and options to tweak its behaviour: you can use `--help`
to display a detailed documentation.

## Targeted Subset And Current Limitations

We target **safe** Rust.

We have the following limitations, that we plan to address one by one:

- **no loops**: ongoing work. We are currently working on a "join" operation on
  environments to address this issue.
- **no functions pointers/closures/traits**: ongoing work.
- **limited type parametricity**: it is not possible for now to instantiate a type
  parameter with a type containing a borrow. This is mostly an engineering
  issue. We intend to quickly address the issue for types (i.e., allow `Option<&mut T>`),
  and later address it for functions (i.e., allow `f<&mut T>` - we consider this to
  be less urgent).
- **no nested borrows in function signatures**. See the paper for a detailed
  discussion. We might allow nested borrows while forbiding what we call
  "borrow overwrites" (see the paper) as a first step towards supporting this feature.
- **no interior mutability**: long-term effort. Interior mutability introduces
  true aliasing: we will probably have to combine our pure lambda calculus
  with separation logic to address this.
  Note that interior mutability is mostly anecdotical in sequential execution,
  but necessary for concurrent execution (it is exploited by the synchronisation
  primitives).
- **no concurrent execution**: long-term effort. We plan to address coarse-grained
  parallelism as a long-term goal.
