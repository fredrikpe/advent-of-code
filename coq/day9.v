Require Import input9.
Require Import NArith.BinNat.
Require Import NArith.BinNatDef.

Fixpoint make_pairs_with n l : list (N*N) :=
  match l with
  | nil => nil
  | x :: xs => (x, n) :: make_pairs_with n xs
  end.

Fixpoint make_pairs l : list (N*N) :=
  match l with
  | nil => nil
  | x :: xs => make_pairs_with x xs ++ make_pairs xs
  end.

Compute make_pairs_with 3%N [1%N ; 2%N].
Compute make_pairs [ 3%N ; 1%N ; 2%N].

Fixpoint contains {X:Type} (f:X -> bool) (l:list X) : bool :=
  match l with
  | nil => false
  | x :: xs => if f x then true else contains f xs
  end.

Definition contains_by_pair (f:(N*N) -> bool) (l:list N) : bool :=
  contains f (make_pairs l).

Definition pair_sum p : N :=
  N.add (fst p) (snd p).

Compute pair_sum (6%N, 7%N).


Definition contains_pair_sum (n:N) (l:list N) : bool :=
  contains (fun p => N.eqb (pair_sum p) n)  (make_pairs l).

Fixpoint take {X:Type} (n:nat) (l:list X) : list X :=
  match l, n with
  | nil, _ => nil
  | x :: xs, O => nil
  | x :: xs, S n' => x :: take n' xs
  end.

Compute take 2 [1;2;3].

Fixpoint slice {X:Type} (n m:nat) (l:list X) : list X :=
  match l, n, m with
  | nil, _, _ => nil
  | l', O, m => take (m + 1) l'
  | x :: xs, S n', m => slice n' m xs
  end.

Compute slice 3 0 [1;2;3].

Fixpoint rev {X:Type} (l:list X) : list X :=
  match l with
  | nil => nil
  | x :: xs => rev xs ++ [x]
  end.

Fixpoint filter_by_next_n {X:Type}
  (f:X -> list X -> bool) (n:nat) (l: list X) : list X :=
  match l with
  | nil => nil
  | x :: xs => if f x (slice 0 (n - 1) xs)
       then x :: filter_by_next_n f n xs
       else filter_by_next_n f n xs
  end.

Definition filter_by_prev_n {X:Type} f n l : list X :=
  rev (filter_by_next_n f n (rev l)).

Definition head {X:Type} l : option X :=
  match l with
  | nil => None
  | x :: xs => Some x
  end.

Example filter_pair_sum:
  filter_by_prev_n contains_pair_sum 2 [1%N;2%N;3%N;4%N;7%N] = [3%N;7%N].
Proof. reflexivity. Qed.

Fixpoint filter_by_next_n_first_m {X:Type}
  (f:X -> list X -> bool) (n m:nat) (l: list X) : list X :=
  match l, m with
  | nil, _ => nil
  | x :: xs, O => nil
  | x :: xs, S m' => if f x (slice 0 (n - 1) xs)
       then x :: filter_by_next_n_first_m  f n m' xs
       else filter_by_next_n_first_m f n m' xs
  end.

Definition tautologi_1 {X:Type} (x:X) (l:list X) : bool :=
  true.
Lemma tautologi_1_true: forall (X:Type) (x:X) (l:list X),
  tautologi_1 x l = true.
Proof. intros. reflexivity. Qed.

Lemma filter_by_next_n_first_m_nil:
  forall (X:Type) (l:list X) (n m:nat),
  l = [] -> filter_by_next_n_first_m tautologi_1 n m l = [].
Proof.
  intros. rewrite H. destruct m.
  - reflexivity.
  - reflexivity.
Qed.

Lemma filter_by_next_n_first_m_with_tautologi_head:
  forall (X:Type) (x:X) (xs: list X) (n m:nat),
  filter_by_next_n_first_m tautologi_1 n (S m) (x::xs) =
  x :: filter_by_next_n_first_m tautologi_1 n m xs.
Proof.
  intros. reflexivity.
Qed.

Lemma filter_by_next_n_first_m_with_tautologi:
  forall (X:Type) (l: list X) (n m:nat),
  filter_by_next_n_first_m tautologi_1 n m l = take m l.
Proof.
  intros X l. induction l.
  - intros. destruct m.
    + reflexivity.
    + reflexivity.
  - intros. destruct m.
    + simpl. reflexivity.
    + rewrite filter_by_next_n_first_m_with_tautologi_head.
      rewrite IHl. simpl. reflexivity.
Qed.

Definition filter_by_next_n_skip_m {X:Type}
  (f:X -> list X -> bool) (n m:nat) (l: list X) : list X :=
  filter_by_next_n_first_m f n (length l - m) l.

Definition filter_by_prev_n_skip_m {X:Type} f n m l : list X :=
  rev (filter_by_next_n_skip_m f n m (rev l)).

Example foo:
  filter_by_prev_n_skip_m contains_pair_sum 2 3 [1%N;2%N;3%N;4%N;7%N] = [7%N].
Proof. reflexivity. Qed.

Definition part1 (slice_length:nat) input : option N :=
  head (
    filter_by_prev_n_skip_m
    (fun x l => negb (contains_pair_sum x l))
    slice_length slice_length input
  ).

Example test_part1: part1 5 test_input = Some 127%N.
Proof. reflexivity. Qed.


Theorem fasolt: forall x xs,
  contains_pair_sum x xs = false ->
  exists x, part1 (length (x::xs)) (x::xs) = Some x.
Proof.
Admitted.

Fixpoint sum (l: list N) : N :=
  match l with
  | nil => 0%N
  | x :: xs => N.add x (sum xs)
  end.


Fixpoint init {X:Type} (l: list X) : list X :=
  match l with
  | nil => nil
  | x :: nil => nil
  | x :: xs => x :: init xs
  end.

Fixpoint tail {X:Type} (l: list X) : list X :=
  match l with
  | nil => nil
  | x :: xs => xs
  end.

Fixpoint take_while_helper {X:Type} (f:list X -> bool) (h l: list X) : list X :=
  match l with
  | nil => nil
  | x :: xs => if f (app h [x])
      then take_while_helper f (h ++ [x]) xs
      else h
  end.

Definition take_while {X:Type} (f:list X -> bool) (l: list X) : list X :=
  take_while_helper f [] l.

Fixpoint sublists_by_helper {X:Type} (f:list X -> bool) (h l:list X)
  : list (list X) :=
  match l with
  | nil => nil
  | x :: xs => if f (x :: h)
      then (x :: h) :: sublists_by_helper f (x :: h) xs
      else sublists_by_helper f (x :: h) xs
  end.

Fixpoint sublists_by {X:Type} (f:list X -> bool) (l:list X) : list (list X) :=
  match l with
  | nil => nil
  | x :: xs => sublists_by_helper f [x] xs ++ sublists_by f xs
  end.

Fixpoint max_elem_helper (n:option N) (l:list N) : option N :=
  match l, n with
  | nil, _ => n
  | x :: xs, None => max_elem_helper (Some x) xs
  | x :: xs, Some y => if N.ltb x y
        then max_elem_helper (Some y) xs
        else max_elem_helper (Some x) xs
  end.

Fixpoint max_elem (l:list N) : option N :=
  max_elem_helper None l.

Fixpoint min_elem_helper (n:option N) (l:list N) : option N :=
  match l, n with
  | nil, _ => n
  | x :: xs, None => max_elem_helper (Some x) xs
  | x :: xs, Some y => if N.ltb x y
        then min_elem_helper (Some x) xs
        else min_elem_helper (Some y) xs
  end.

Fixpoint min_elem (l:list N) : option N :=
  min_elem_helper None l.

Definition add_min_max (l:list N) :=
  match max_elem l, min_elem l with
  | None, _ => None
  | _, None => None
  | Some max, Some min => Some (N.add max min)
  end.

Definition map {X Y:Type} (opt:option X) (f:X -> Y) : option Y :=
  match opt with
  | None => None
  | Some x => Some (f x)
  end.

Definition flat_map {X Y:Type} (opt:option X) (f:X -> option Y) : option Y :=
  match opt with
  | None => None
  | Some x => f x
  end.

Definition part2 (n:nat) (input:list N) :=
  flat_map
    (flat_map
      (map
          (part1 n input)
          (fun x => sublists_by (fun l => N.eqb (sum l) x) input)
      )
      head
    )
    add_min_max.

Compute part1 25 input.
Compute part2 25 input.
