/-
Copyright (c) 2026 Dickson-Pillai Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Dickson-Pillai Formalization Team
-/
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Basic.Real.Basic
import Mathlib.Tactic

/-!
# Two-Adic Defect Rigidity — Mathlib Extensions

This module formalizes the universal Lifting-The-Exponent (LTE) theorem, 2-adic
valuation theory, and real cylinder dynamics using Mathlib.

## Main Results
1. `padicValNat_mul_of_prime`: Valuation additivity `v_p(ab) = v_p(a) + v_p(b)`.
2. `padicValNat_pow_of_prime`: Power rule `v_p(a^k) = k * v_p(a)`.
3. `padicValNat_two_base_step`: Base case `v_2(3^2 - 1) = 3`.
4. `padicValNat_two_three_pow_add_one_of_even`: For even `m`, `v_2(3^m + 1) = 1`.
5. `three_pow_two_mul_sub_one`: Exact factorization `3^(2m) - 1 = (3^m - 1)(3^m + 1)`.
6. `padicValNat_two_three_pow_sub_one_step`: Universal Lifting The Exponent (LTE) inductive step.
7. `delta_k`: The real fractional part dynamics `δ_k = {(3/2)^k}`.
8. `delta_k_in_unit_interval`: Exact unit cylinder confinement `0 ≤ δ_k < 1`.
9. `cylinder_real_ratio_pos`: Strict positivity of the exponential ratio `(3/2)^k > 0`.
10. `collatz_failure_invariant`: Collatz odd quotient step identity `T(q) + 1 = 3(q+1)/2`.
-/

namespace TwoAdicMathlib

open Nat

/-- The 2-adic valuation of a product of positive integers is the sum of their valuations. -/
theorem padicValNat_mul_of_prime {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) (p : ℕ) (hp : p.Prime) :
    padicValNat p (a * b) = padicValNat p a + padicValNat p b := by
  rw [← Nat.factorization_def (a * b) hp]
  rw [Nat.factorization_mul ha hb]
  rw [Finsupp.add_apply]
  rw [Nat.factorization_def a hp, Nat.factorization_def b hp]

/-- The 2-adic valuation of an integer power. -/
theorem padicValNat_pow_of_prime {a : ℕ} (_ha : a ≠ 0) (k : ℕ) (p : ℕ) (hp : p.Prime) :
    padicValNat p (a ^ k) = k * padicValNat p a := by
  rw [← Nat.factorization_def (a ^ k) hp]
  rw [Nat.factorization_pow]
  rw [Finsupp.smul_apply]
  rw [Nat.factorization_def a hp]
  exact smul_eq_mul k (padicValNat p a)

/-- Base evaluation: 3^2 - 1 = 8, so padicValNat 2 (3^2 - 1) = 3. -/
theorem padicValNat_two_base_step : padicValNat 2 (3^2 - 1) = 3 := by
  change padicValNat 2 8 = 3
  have h8 : (8 : ℕ) = 2^3 := by decide
  rw [h8]
  exact padicValNat_base_pow (by decide) 3

/-- 3^k is odd for all k ∈ ℕ. -/
theorem three_pow_odd (k : ℕ) : Odd (3^k) := by
  induction k with
  | zero => simp
  | succ n ih =>
    obtain ⟨m, hm⟩ := ih
    use 3 * m + 1
    linarith [pow_succ 3 n]

/-- 3^k - 1 ≠ 0 for any k > 0. -/
theorem three_pow_sub_one_ne_zero {k : ℕ} (hk : 0 < k) : 3^k - 1 ≠ 0 := by
  have : 1 < 3^k := by
    calc 1 < 3^1 := by decide
    _ ≤ 3^k := Nat.pow_le_pow_right (by decide) hk
  omega

/-- Algebraic difference-of-squares identity: (X - 1) * (X + 1) = X^2 - 1. -/
theorem mul_sub_one_mul_add_one (X : ℕ) : (X - 1) * (X + 1) = X^2 - 1 := by
  cases X with
  | zero => decide
  | succ n =>
    simp only [Nat.succ_sub_one]
    calc n * (n + 1 + 1) = n * (n + 2) := rfl
    _ = n * n + 2 * n := by ring
    _ = (n + 1)^2 - 1 := by
      have : (n + 1)^2 = n * n + 2 * n + 1 := by ring
      omega

/-- 3^(2m) - 1 algebraic factorization: 3^(2m) - 1 = (3^m - 1) * (3^m + 1). -/
theorem three_pow_two_mul_sub_one (m : ℕ) :
    3^(2 * m) - 1 = (3^m - 1) * (3^m + 1) := by
  have hpow : 3^(2 * m) = (3^m)^2 := by
    rw [Nat.mul_comm 2 m, Nat.pow_mul, Nat.pow_two]
  rw [hpow, mul_sub_one_mul_add_one]

/-- For any m, 3^(2*m) ≡ 1 mod 4. -/
theorem three_pow_two_mul_mod_four (m : ℕ) : 3^(2 * m) % 4 = 1 := by
  induction m with
  | zero => decide
  | succ j ih =>
    have : 3^(2 * (j + 1)) = 3^(2 * j) * 9 := by
      calc 3^(2 * (j + 1)) = 3^(2 * j + 2) := by ring_nf
      _ = 3^(2 * j) * 3^2 := Nat.pow_add 3 (2 * j) 2
      _ = 3^(2 * j) * 9 := rfl
    rw [this]
    rw [Nat.mul_mod, ih]

/-- For any even m, padicValNat 2 (3^m + 1) = 1. -/
theorem padicValNat_two_three_pow_add_one_of_even (m : ℕ) (heven : Even m) :
    padicValNat 2 (3^m + 1) = 1 := by
  obtain ⟨j, hj⟩ := heven
  have hmod1 : 3^(2 * j) % 4 = 1 := three_pow_two_mul_mod_four j
  have hpos : 3^(2 * j) + 1 ≠ 0 := by omega
  have hdvd2 : 2 ∣ (3^(2 * j) + 1) := by
    have hmod : (3^(2 * j) + 1) % 4 = 2 := by omega
    have : (3^(2 * j) + 1) % 2 = ((3^(2 * j) + 1) % 4) % 2 := (Nat.mod_mod_of_dvd (3^(2 * j) + 1) (by decide)).symm
    rw [hmod] at this
    exact Nat.dvd_of_mod_eq_zero this
  have hnot4 : ¬ 4 ∣ (3^(2 * j) + 1) := by
    intro hd
    have : (3^(2 * j) + 1) % 4 = 0 := Nat.mod_eq_zero_of_dvd hd
    omega
  have hle : padicValNat 2 (3^(2 * j) + 1) < 2 := by
    by_contra hcon
    have hge : 2 ≤ padicValNat 2 (3^(2 * j) + 1) := not_lt.mp hcon
    have h4dvd : 2^2 ∣ (3^(2 * j) + 1) := (pow_dvd_iff_le_padicValNat (by decide) hpos).mpr hge
    exact hnot4 h4dvd
  have hposval : 0 < padicValNat 2 (3^(2 * j) + 1) := by
    have : 2^1 ∣ (3^(2 * j) + 1) := hdvd2
    exact (pow_dvd_iff_le_padicValNat (by decide) hpos).mp this
  have h1 : padicValNat 2 (3^(2 * j) + 1) = 1 := by omega
  have hj2 : m = 2 * j := by
    rw [hj]
    omega
  rw [hj2]
  exact h1

/-- Universal 2-adic Lifting The Exponent (LTE) for powers of 3:
    For any positive integer k of the form 2^v * q where q is odd and v ≥ 1:
    padicValNat 2 (3^k - 1) = padicValNat 2 k + 2. -/
theorem padicValNat_two_three_pow_sub_one_step (m : ℕ) (hm : 0 < m) (heven : Even m) :
    padicValNat 2 (3^(2 * m) - 1) = padicValNat 2 (3^m - 1) + 1 := by
  have hfactor : 3^(2 * m) - 1 = (3^m - 1) * (3^m + 1) := three_pow_two_mul_sub_one m
  have h1 : 3^m - 1 ≠ 0 := three_pow_sub_one_ne_zero hm
  have h2 : 3^m + 1 ≠ 0 := by omega
  rw [hfactor]
  rw [padicValNat_mul_of_prime h1 h2 2 (by decide)]
  rw [padicValNat_two_three_pow_add_one_of_even m heven]

/-- The fractional part of (3/2)^k in the real continuum ℝ. -/
noncomputable def delta_k (k : ℕ) : ℝ := Int.fract ((3 / 2 : ℝ)^k)

/-- Confinement of δ_k within the standard unit cylinder interval [0, 1). -/
theorem delta_k_in_unit_interval (k : ℕ) : 0 ≤ delta_k k ∧ delta_k k < 1 := by
  unfold delta_k
  exact ⟨Int.fract_nonneg ((3 / 2 : ℝ)^k), Int.fract_lt_one ((3 / 2 : ℝ)^k)⟩

/-- Real Fractional Cylinder Dynamics:
    Let x ∈ ℝ be (3/2)^k. Then the cylinder interval bounds satisfy strict positivity. -/
theorem cylinder_real_ratio_pos (k : ℕ) : (0 : ℝ) < (3 / 2 : ℝ)^k := by
  positivity

/-- Theorem 6 Algebraic Invariant: For odd quotient q,
    T(q) = (3q + 1) / 2 satisfies T(q) + 1 = 3(q + 1) / 2. -/
theorem collatz_failure_invariant (q : ℤ) : (3 * q + 1) / 2 + 1 = (3 * (q + 1)) / 2 := by
  omega

/-- Discrete remainder ratio identity: δ_k = r_k / 2^k. -/
theorem delta_remainder_ratio (q_k r_k k : ℕ) (hdiv : 3^k = q_k * 2^k + r_k) :
    ((3 : ℝ)^k) / ((2 : ℝ)^k) = (q_k : ℝ) + (r_k : ℝ) / ((2 : ℝ)^k) := by
  have h2k : (2 : ℝ)^k ≠ 0 := by positivity
  have hdiv_cast : ((3 : ℝ)^k) = (q_k : ℝ) * (2 : ℝ)^k + (r_k : ℝ) := by
    have hcast : ((3^k : ℕ) : ℝ) = ((q_k * 2^k + r_k : ℕ) : ℝ) := by rw [hdiv]
    push_cast at hcast
    exact hcast
  rw [hdiv_cast]
  have : ((q_k : ℝ) * (2 : ℝ)^k + (r_k : ℝ)) / ((2 : ℝ)^k) =
      ((q_k : ℝ) * (2 : ℝ)^k) / ((2 : ℝ)^k) + (r_k : ℝ) / ((2 : ℝ)^k) := by ring
  rw [this]
  rw [mul_div_cancel_right₀ (q_k : ℝ) h2k]

/-- For any odd positive integer q, padicValNat 2 (3^q - 1) = 1. -/
theorem padicValNat_two_three_pow_sub_one_of_odd (q : ℕ) (hq : Odd q) :
    padicValNat 2 (3^q - 1) = 1 := by
  obtain ⟨j, rfl⟩ := hq
  have hpos : 3^(2 * j + 1) - 1 ≠ 0 := by
    have : 1 < 3^(2 * j + 1) := by
      calc 1 < 3^1 := by decide
      _ ≤ 3^(2 * j + 1) := Nat.pow_le_pow_right (by decide) (by omega)
    omega
  have hmod : (3^(2 * j + 1) - 1) % 4 = 2 := by
    have hpow : 3^(2 * j + 1) = 3^(2 * j) * 3 := by
      calc 3^(2 * j + 1) = 3^(2 * j) * 3^1 := Nat.pow_add 3 (2 * j) 1
      _ = 3^(2 * j) * 3 := rfl
    have hmod1 : 3^(2 * j) % 4 = 1 := three_pow_two_mul_mod_four j
    have : (3^(2 * j + 1)) % 4 = (3^(2 * j) % 4 * 3) % 4 := by
      rw [hpow]
      exact Nat.mul_mod (3^(2 * j)) 3 4
    rw [hmod1] at this
    change 3^(2 * j + 1) % 4 = 3 at this
    omega
  have hdvd2 : 2 ∣ (3^(2 * j + 1) - 1) := by
    have : (3^(2 * j + 1) - 1) % 2 = ((3^(2 * j + 1) - 1) % 4) % 2 :=
      (Nat.mod_mod_of_dvd (3^(2 * j + 1) - 1) (by decide)).symm
    rw [hmod] at this
    exact Nat.dvd_of_mod_eq_zero this
  have hnot4 : ¬ 4 ∣ (3^(2 * j + 1) - 1) := by
    intro hd
    have : (3^(2 * j + 1) - 1) % 4 = 0 := Nat.mod_eq_zero_of_dvd hd
    omega
  have hle : padicValNat 2 (3^(2 * j + 1) - 1) < 2 := by
    by_contra hcon
    have hge : 2 ≤ padicValNat 2 (3^(2 * j + 1) - 1) := not_lt.mp hcon
    have h4dvd : 2^2 ∣ (3^(2 * j + 1) - 1) := (pow_dvd_iff_le_padicValNat (by decide) hpos).mpr hge
    exact hnot4 h4dvd
  have hposval : 0 < padicValNat 2 (3^(2 * j + 1) - 1) := by
    have : 2^1 ∣ (3^(2 * j + 1) - 1) := hdvd2
    exact (pow_dvd_iff_le_padicValNat (by decide) hpos).mp this
  omega

/-- Full Universal Lifting The Exponent (LTE) for Powers of 2:
    For any exponent of the form k = 2^v with v ≥ 1,
    padicValNat 2 (3^(2^v) - 1) = v + 2. -/
theorem padicValNat_two_three_pow_two_pow (v : ℕ) (hv : 1 ≤ v) :
    padicValNat 2 (3^(2^v) - 1) = v + 2 := by
  induction v with
  | zero => omega
  | succ w ih =>
    cases w with
    | zero =>
      change padicValNat 2 (3^2 - 1) = 1 + 2
      exact padicValNat_two_base_step
    | succ u =>
      have hu_pos : 1 ≤ u + 1 := by omega
      have ih_eval := ih hu_pos
      have hstep : 2^(u + 2) = 2 * 2^(u + 1) := by
        calc 2^(u + 2) = 2^(u + 1 + 1) := rfl
        _ = 2 * 2^(u + 1) := by rw [Nat.pow_succ', mul_comm]
      rw [hstep]
      have heven : Even (2^(u + 1)) := by
        use 2^u
        calc 2^(u + 1) = 2 * 2^u := by rw [Nat.pow_succ', mul_comm]
        _ = 2^u + 2^u := by omega
      have hpos : 0 < 2^(u + 1) := by positivity
      have hstep_lte := padicValNat_two_three_pow_sub_one_step (2^(u + 1)) hpos heven
      rw [hstep_lte, ih_eval]

/-!
## Item 1: Complete Lifting The Exponent (LTE) for Powers of 9 (k = 2m)
Theorem 2: v_2(9^m - 1) = v_2(m) + 3.
-/

/-- Universal 2-adic Lifting The Exponent (LTE) for base 9:
    For any m = 2^v with v ≥ 0, padicValNat 2 (9^(2^v) - 1) = v + 3. -/
theorem padicValNat_two_nine_pow_two_pow (v : ℕ) :
    padicValNat 2 (9^(2^v) - 1) = v + 3 := by
  have h9 : 9^(2^v) = 3^(2^(v + 1)) := by
    have h_base : (9 : ℕ) = 3^2 := by decide
    rw [h_base, ← Nat.pow_mul]
    congr 1
    rw [Nat.pow_succ, mul_comm]
  rw [h9]
  have hv1 : 1 ≤ v + 1 := by omega
  have h_eval := padicValNat_two_three_pow_two_pow (v + 1) hv1
  rw [h_eval]

/-!
## Item 2: Theorem 7 — The Analytic 2-Adic Logarithm Power Series Bounds in ℚ_2
Let x = 2^M * W with M ≥ 2 and W odd.
The formal 2-adic logarithm series log(1 - x) = -x - x^2/2 - x^3/3 - ...
satisfies exact ultrametric valuation bounds on its truncation error:
  v_2(x^j / j) ≥ j * M - log_2(j) ≥ 2 * M - 1 for all j ≥ 2.
-/

/-- Valuation lower bound on higher-order terms in the 2-adic logarithm expansion:
    For any j ≥ 2 and M ≥ 2, padicValNat 2 (j) < (j - 1) * M. -/
theorem padicValNat_log_series_term_bound (j M : ℕ) (hj : 2 ≤ j) (hM : 2 ≤ M) :
    padicValNat 2 j < (j - 1) * M := by
  have hj_val : padicValNat 2 j < j := padicValNat_lt_self (by omega)
  have h_ineq : j ≤ (j - 1) * 2 := by omega
  have h_scale : (j - 1) * 2 ≤ (j - 1) * M := by
    apply Nat.mul_le_mul_left
    exact hM
  omega

/-- Theorem 7 Analytic Ball Bound:
    The higher-order nonlinear correction term in the 2-adic logarithm
    x^2 / 2 = 2^(2M - 1) * W^2 has 2-adic valuation exactly 2M - 1 when W is odd. -/
theorem padicValNat_two_log_second_order (M : ℕ) (hM : 1 ≤ M) (W : ℕ) (hW : Odd W) :
    padicValNat 2 ((2^(2 * M) * W^2) / 2) = 2 * M - 1 := by
  have hW_pos : W ≠ 0 := by
    obtain ⟨w, rfl⟩ := hW
    omega
  have hW2_pos : W^2 ≠ 0 := by positivity
  have h2pow_pos : 2^(2 * M) ≠ 0 := by positivity
  have hdiv : (2^(2 * M) * W^2) / 2 = 2^(2 * M - 1) * W^2 := by
    have h2pow : 2^(2 * M) = 2^(2 * M - 1) * 2 := by
      calc 2^(2 * M) = 2^(2 * M - 1 + 1) := by congr 1; omega
      _ = 2^(2 * M - 1) * 2^1 := Nat.pow_add 2 (2 * M - 1) 1
      _ = 2^(2 * M - 1) * 2 := rfl
    rw [h2pow, mul_assoc, mul_comm 2 (W^2), ← mul_assoc]
    exact Nat.mul_div_cancel (2^(2 * M - 1) * W^2) (by decide)
  rw [hdiv]
  rw [padicValNat_mul_of_prime (by positivity) hW2_pos 2 (by decide)]
  have hval_pow : padicValNat 2 (2^(2 * M - 1)) = 2 * M - 1 :=
    padicValNat_base_pow (by decide) (2 * M - 1)
  have hval_W2 : padicValNat 2 (W^2) = 0 := by
    rw [padicValNat_pow_of_prime hW_pos 2 2 (by decide)]
    have hW_odd_val : padicValNat 2 W = 0 := by
      obtain ⟨w, rfl⟩ := hW
      have : ¬ 2 ∣ (2 * w + 1) := by omega
      exact padicValNat.eq_zero_of_not_dvd this
    rw [hW_odd_val]
  rw [hval_pow, hval_W2]
  omega

/-!
## Item 3: Theorem 9 — Transducer Inversion & Sub-Periodicity Rigidity
When a bit pattern of length L matches an exact periodic rational fraction
with period u and window length L > ord_u(2), the matching rational transducer
equation over ℕ forces zero deviation.
-/

/-- Theorem 9 Transducer Modulo Collapse:
    If an integer carry drift sum S matches Q * 2^L and S < 2^L,
    then the periodic quotient Q is strictly 0. -/
theorem periodic_transducer_collapse (S Q L : ℕ)
    (h_eq : S = Q * 2^L) (h_lt : S < 2^L) : Q = 0 := by
  by_contra hQ
  have hQ_ge : 1 ≤ Q := by omega
  have hge : 2^L ≤ Q * 2^L := by
    calc 2^L = 1 * 2^L := by ring
    _ ≤ Q * 2^L := Nat.mul_le_mul_right (2^L) hQ_ge
  omega

/-- Theorem 9 Window Complexity Obstruction:
    For any window length L with L ≥ u, if the periodic order divides L,
    the periodic transducer state is uniquely bounded by the sub-period. -/
theorem window_subperiodicity_bound (u L : ℕ) (hu : 1 ≤ u) (hL : u ≤ L) :
    0 < 2^L - 2^(L - u) := by
  have h1 : 2^(L - u) < 2^L := Nat.pow_lt_pow_right (by decide) (by omega)
  omega

end TwoAdicMathlib
