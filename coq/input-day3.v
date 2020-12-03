Require Import Numbers.BinNums.
Require Import Coq.NArith.BinNatDef.

Inductive vector X:N -> Type :=
  | vnil : vector X 0
  | vcons : forall (x:X) (t:N), vector X t -> vector X (N.succ t).
Arguments vnil {X}.
Arguments vcons {X} _ _.

Infix "::" := vcons (at level 60, right associativity).
Notation "[ ]" := vnil (format "[ ]").
Notation "[ x ]" := (vcons x nil).
Notation "[ x ; y ; .. ; z ]" := (vcons x (vcons y .. (vcons z vnil) ..)).

Definition mv := [ 1 ; 2 ; 3].

Inductive vector (X:Type) (s:N) : Type :=
  | nil : vector X 0
  | cons : forall (n:N), binvector n -> binvector (N.succ n).


Definition bingrid (n m:N) (l:list N) : Type :=
 | grid (n m:N) (l:list N)


(*
........#....#..##..#...#.....#
...............#....##........#
.#....##...##..#...............
.#.......#......#.##..##...#...
.....#.#....#..##...#.....#....
...#.#..##...###......#..#..#.#
 *)


