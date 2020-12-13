
Require Import input12.
Require Import ZArith.BinInt.
Require Import ZArith.BinIntDef.


Inductive pos : Type :=
  | Pos (x y:Z).

Definition move_north (p:pos) (z: Z) : pos :=
  match p with
  | Pos x y => Pos (x + z) y
  end.

Definition move_south (p:pos) (z: Z) : pos :=
  move_north p ((-1%Z) * z).

Definition move_east (p:pos) (z: Z) : pos :=
  match p with
  | Pos x y => Pos x (y + z)
  end.

Definition move_west (p:pos) (z: Z) : pos :=
  move_east p (-1%Z * z).

Lemma mul_neg_1_involutive: forall z, Z.mul (-1%Z) (Z.mul (-1%Z) z) = z.
Proof.
  intros. destruct z.
  - simpl. reflexivity.
  - simpl. reflexivity.
  - simpl. reflexivity.
Qed.

Lemma move_south_neg: forall z p, move_north p z = move_south p ((-1%Z) * z).
Proof.
  intros.
  unfold move_south.
  rewrite mul_neg_1_involutive.
  reflexivity.
Qed.

Inductive dir : Type :=
  | North
  | South
  | East
  | West.

Definition move_dir (p:pos) (d:dir) (z: Z) : pos :=
  match d with
  | North => move_north p z
  | South => move_south p z
  | East => move_east p z
  | West => move_west p z
  end.

Definition turn_right_90 (d:dir) : dir :=
  match d with
  | North => East
  | East => South
  | South => West
  | West => North
  end.

Definition turn_180 (d:dir) : dir :=
  match d with
  | North => South
  | East => West
  | South => North
  | West => East
  end.

Definition turn_right_270 (d:dir) : dir :=
  turn_right_90 (turn_right_90 (turn_right_90 d)).

Definition turn_right (d:dir) (t:turn) : dir :=
  match t with
  | _90 => turn_right_90 d
  | _180 => turn_180 d
  | _270 => turn_right_270 d
  end.

Definition turn_left (d:dir) (t:turn) : dir :=
  match t with
  | _90 => turn_right_270 d
  | _180 => turn_180 d
  | _270 => turn_right_90 d
  end.

Inductive ship : Type :=
  | Ship (p:pos) (d:dir).

Definition apply_action (a:action) (s:ship) : ship :=
  match a, s with
  | _N z, Ship p d => Ship (move_north p z) d
  | _S z, Ship p d => Ship (move_south p z) d
  | _E z, Ship p d => Ship (move_east p z) d
  | _W z, Ship p d => Ship (move_west p z) d
  | _F z, Ship p d => Ship (move_dir p d z) d
  | _L t, Ship p d => Ship p (turn_left d t)
  | _R t, Ship p d => Ship p (turn_right d t)
  end.


Definition manhatten_dist (p q: pos) : Z :=
  match p, q with
  | Pos x1 y1, Pos x2 y2 => Z.abs (x1 - x2) + Z.abs (y2 - y1)
  end.

Definition manhatten_dist_ship (s t: ship) : Z :=
  match s, t with
  | Ship p1 _, Ship p2 _ => manhatten_dist p1 p2
  end.
  

Fixpoint apply_actions (l:list action) (s:ship) : ship :=
  match l with
  | nil => s
  | x :: xs => apply_actions xs (apply_action x s)
  end.

Definition start_ship := Ship (Pos 0%Z 0%Z) East.

Definition part1_ship := apply_actions input start_ship.
Compute manhatten_dist_ship part1_ship start_ship.

Definition move_to_waypoint (z:Z) (p w:pos) : pos :=
  match w with
  | Pos x y => move_east (move_north p (z * x)) (y * z)
  end.

Definition turn_waypoint_right_90 (w: pos) : pos :=
  match w with
  | Pos x y => match x, y with
               | 0%Z, 0%Z => w
               | Z.pos x', 0%Z => Pos y x
               | Z.neg x', 0%Z => Pos y x
               | 0%Z, Z.pos y' => Pos (Z.neg y') x
               | 0%Z, Z.neg y' => Pos (Z.pos y') x
               | Z.pos x', Z.pos y' => Pos (Z.neg y') x
               | Z.pos x', Z.neg y' => Pos (Z.pos y') x
               | Z.neg x', Z.pos y' => Pos (Z.neg y') x
               | Z.neg x', Z.neg y' => Pos (Z.pos y') x
               end
  end.

Example twr90_1: turn_waypoint_right_90 (Pos 1%Z 3%Z) = Pos (-3%Z) 1%Z.
Proof. reflexivity. Qed.
Example twr90_2: turn_waypoint_right_90 (Pos (-1%Z) 3%Z) = Pos (-3%Z) (-1%Z).
Proof. reflexivity. Qed.
Example twr90_3: turn_waypoint_right_90 (Pos 1%Z (-3%Z)) = Pos 3%Z 1%Z.
Proof. simpl. reflexivity. Qed.
Example twr90_4: turn_waypoint_right_90 (Pos (-1%Z) (-3%Z)) = Pos 3%Z (-1%Z).
Proof. reflexivity. Qed.

Definition turn_waypoint_right (t:turn) (w: pos) : pos :=
  match t with
  | _90 => turn_waypoint_right_90 w
  | _180 => turn_waypoint_right_90 (turn_waypoint_right_90 w)
  | _270 => turn_waypoint_right_90 (turn_waypoint_right_90 (turn_waypoint_right_90 w))
  end.

Definition turn_waypoint_left (t:turn) (w: pos) : pos :=
  match t with
  | _270 => turn_waypoint_right_90 w
  | _180 => turn_waypoint_right_90 (turn_waypoint_right_90 w)
  | _90 => turn_waypoint_right_90 (turn_waypoint_right_90 (turn_waypoint_right_90 w))
  end.

Definition apply_action2 (a:action) (s w:ship) : ship*ship :=
  match a, s, w with
  | _N z, s, Ship p d => (s, Ship (move_north p z) d)
  | _S z, s, Ship p d => (s, Ship (move_south p z) d)
  | _E z, s, Ship p d => (s, Ship (move_east p z) d)
  | _W z, s, Ship p d => (s, Ship (move_west p z) d)
  | _F z, Ship sp sd, Ship wp wd =>
      (Ship (move_to_waypoint z sp wp) sd, Ship wp wd)
  | _L t, s, Ship wp d => (s, Ship (turn_waypoint_left t wp) d)
  | _R t, s, Ship wp d => (s, Ship (turn_waypoint_right t wp) d)
  end.

Fixpoint apply_actions2 (l:list action) (s w:ship) : ship :=
  match l with
  | nil => s
  | x :: xs => match apply_action2 x s w with
               | (s', w') => apply_actions2 xs s' w'
               end
  end.

Definition start_waypoint := Ship (Pos 1%Z 10%Z) North.
Definition part2_ship := apply_actions2 input start_ship start_waypoint.
Compute part2_ship.
Compute manhatten_dist_ship part2_ship start_ship.


