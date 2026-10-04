# Supplementary & Exploratory Diophantine Frameworks

This directory archives alternative Diophantine architectures, preliminary exploratory frameworks, and numerical verification engines investigated for the Dickson–Pillai condition in Waring's problem:
$$g(k) = 2^k + \lfloor(3/2)^k\rfloor - 2 \iff D_k \ge q_k, \quad D_k := (q_k + 1)2^k - 3^k.$$

While the main manuscript (see [`../paper/`](../paper/)) develops the 2-adic rigidity, carry automata, and dynamical repulsion laws, the files in this directory document comparative methodologies and the exact algebraic barriers where classical approaches stall.

---

## Directory Overview

### 📁 `frey_modular_degree/` (Frey–Hellegouarch Curves & Szpiro Bounds)
* **[`frey_proof.tex`](./frey_modular_degree/frey_proof.tex) / [`frey_proof.pdf`](./frey_modular_degree/frey_proof.pdf):** Investigates the Frey curve $E_k : y^2 = x(x - r_k)(x + 2^k q_k)$ associated with the ternary partition $r_k + 2^k q_k = 3^k$.
* **[`formalization/FreyDicksonPillai.lean`](./frey_modular_degree/formalization/FreyDicksonPillai.lean):** Lean 4 formalization of the Frey curve discriminant, conductor bounds, and Szpiro ratio $\sigma(E_k)$.
* **[`critique_and_salvage.md`](./frey_modular_degree/critique_and_salvage.md):** Detailed analysis showing that failure forces $\sigma_{\mathrm{fail}} \ge 5.26189$, whereas unconditional modular degree bounds (Hoffstein–Lockhart 1994) yield only $\sigma \le 12$, requiring an effective version of the $abc$ conjecture over $\mathbb{Q}$.

### 📁 `nesterenko_modular/` (Automorphic & Differential Algebra Framework)
* **[`modular_proof.tex`](./nesterenko_modular/modular_proof.tex) / [`modular_proof.pdf`](./nesterenko_modular/modular_pdf.pdf):** Investigates Nesterenko's differential algebra on Eisenstein series $(\mathbb{Q}[q, E_2, E_4, E_6], \theta)$ evaluated at $q_k = 2^{-k}$.
* **[`modular_forms.py`](./nesterenko_modular/modular_forms.py) & [`auxiliary_modular_polynomial.py`](./nesterenko_modular/auxiliary_modular_polynomial.py):** High-precision evaluation of Eisenstein series and monomial kernel solvers.
* **Analysis:** Demonstrates how cusp degeneration as $q \to 0$ and algebraic independence resultants restore the classical Baker barrier.

### 📁 `hermite_pade/` (Simultaneous Hypergeometric Padé Approximants)
* **[`paper.tex`](./hermite_pade/paper.tex) / [`paper.pdf`](./hermite_pade/paper.pdf):** Comprehensive study of Padé approximants to algebraic and hypergeometric functions.
* **[`formalization/DicksonPillai.lean`](./hermite_pade/formalization/DicksonPillai.lean):** Lean 4 proofs of Diophantine exponent hierarchies and modular transformations.
* **[`hermite_pade_systematic.py`](./hermite_pade/hermite_pade_systematic.py) & [`pade_hypergeometric.py`](./hermite_pade/pade_hypergeometric.py):** Numerical verification showing that simultaneous systems for $(1-z)^{\pm 1/2}$ at $z = 1/9$ drop rank over $\mathbb{Q}$ ($3 f_1 - \frac{8}{3} f_2 = 0$), collapsing back to Bennett's exponent $\lambda = 0.787$.

### 📁 `numerical_validation/` (High-Throughput Streaming Engines)
* **[`parallel_verifier.cpp`](./numerical_validation/parallel_verifier.cpp):** Multi-threaded C++ engine utilizing unrolled 128-bit limb arithmetic.
* **[`verification_records/`](./numerical_validation/verification_records/):** Certified checkpoint logs verifying zero exceptions up to $k = 25{,}000{,}000$.

### 📁 `miscellaneous/`
* **Plots:** High-resolution figures illustrating danger envelopes, Padé error decay, and empirical safety margins.
