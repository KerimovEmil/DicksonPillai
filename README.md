# The Dickson–Pillai Defect: 2-Adic Rigidity, Carry Automata, and Dynamical Repulsion

[![Lean 4](https://img.shields.io/badge/Lean_4-100%25_Verified-blue.svg)](formalization/TwoAdicDefectRigidity.lean)
[![PDF Manuscript](https://img.shields.io/badge/Manuscript-12_pages-red.svg)](paper/two_adic_proof.pdf)
[![Release](https://img.shields.io/badge/Release-v1.0.0-green.svg)](https://github.com/KerimovEmil/DicksonPillai/releases/tag/v1.0.0)

This repository hosts the formal verification, research manuscript, empirical test suites, and Diophantine barrier analyses for the **Dickson–Pillai condition** in Waring's problem:
$$g(k) = 2^k + \left\lfloor \left(\frac{3}{2}\right)^k \right\rfloor - 2 \iff D_k \ge q_k,$$
where $3^k = q_k 2^k + r_k$ and the Diophantine defect is defined by:
$$D_k := 2^k - r_k = (q_k + 1)2^k - 3^k.$$

A counterexample (failure) occurs if and only if $D_k < q_k = \lfloor(3/2)^k\rfloor$, demanding extreme Diophantine proximity:
$$\left\Vert{} \left(\frac{3}{2}\right)^k \right\Vert{} < \left(\frac{3}{4}\right)^k = 2^{-\lambda_{\mathrm{target}} k}, \quad \lambda_{\mathrm{target}} = \log_2(4/3) \approx 0.415037.$$

---

## 📁 Repository Organization

```
DicksonPillai/
├── paper/                      # Research manuscript (AMS-LaTeX and compiled PDF)
│   ├── two_adic_proof.tex
│   └── two_adic_proof.pdf      # 13-page publication draft
├── formalization/              # Zero-axiom Lean 4 formal verification
│   └── TwoAdicDefectRigidity.lean
├── scripts/                    # Empirical testing and numerical verification
│   └── two_adic_verification.py
└── explorations/               # Supplementary & exploratory Diophantine architectures
    ├── README.md               # Overview of exploratory frameworks and barriers
    ├── frey_modular_degree/    # Frey curve and Szpiro ratio bounds (σ ≥ 5.26189)
    ├── nesterenko_modular/     # Automorphic differential algebra and cusp degenerations
    ├── hermite_pade/           # Hypergeometric Padé rank degeneracies over ℚ
    ├── numerical_validation/   # Multi-threaded C++ verifier (checkpoints up to k = 25M)
    └── miscellaneous/          # Plots and visualizations
```

---

## 🔬 Core Proven Structural Theorems

All core theorems below are proven in the manuscript ([`paper/two_adic_proof.pdf`](paper/two_adic_proof.pdf)) and formally verified in Lean~4 ([`formalization/TwoAdicDefectRigidity.lean`](formalization/TwoAdicDefectRigidity.lean)):

| Theorem | Name | Mathematical Statement | Status |
| :--- | :--- | :--- | :--- |
| **Theorem 1** | **Residue Exclusion Modulo 8** | $D_k \bmod 8 \in \{5, 7\}$ for all $k \ge 3$; eliminates $75\%$ of residue classes; proves $D_k \notin \{1, 3\}$ and $D_k$ odd. | **Unconditional & Formalized ($\forall k \ge 3$)** |
| **Theorem 2** | **Even Index 2-Adic Rigidity** | For even $k \ge 6$: $v_2(D_k + 1) = v_2(k) + 2$ via LTE and ultrametric valuation. | **Unconditional (Lean Kernel Certified)** |
| **Theorem 3** | **Odd Index 2-Adic Rigidity** | $k \equiv 3 \pmod 4 \implies v_2(D_k + 3) = 3$; $k \equiv 1 \pmod 4 \implies v_2(D_k + 3) = v_2(k - 1) + 2$. | **Unconditional (Lean Kernel Certified)** |
| **Theorem 4** | **4-State Carry Drift Recurrence** | $3 D_k - D_{k+1} = C_k 2^k$, with multiplier $C_k \in \{-1, 0, 1, 2\}$ governed by a cylinder partition on $(q_k \bmod 2, \delta_k)$. | **Unconditional & Formalized ($\forall k \in \mathbb{N}$)** |
| **Theorem 5** | **State Collapse Under Failure** | Failure $D_k < q_k$ forces $\delta_k > 2/3$, strictly forbidding $C_k \in \{1, 2\}$ and locking $C_k \in \{-1, 0\}$. | **Unconditional** |
| **Theorem 6** | **Dynamical Isolation & Ratio Expansion** | Even quotient failures strictly isolated ($D_{k+1} > 2^k > 2 q_{k+1}$); odd quotients double safety ratio ($\frac{D_{k+1}}{q_{k+1}} > 1.9 \frac{D_k}{q_k}$); failure chains bounded. | **Unconditional & Formalized (Branch 1)** |
| **Theorem 7** | **Universal 2-Adic Fixed Point** | Even failure indices satisfy an exact non-linear fixed-point identity modulo $2^{k - v_2(k) - 2}$ governed by $\nu = \frac{\ln_2 3}{4} \in \mathbb{Z}_2^\times$. | **Unconditional** |

---

## 🛠️ Verification & Compilation

### Lean 4 Formal Verification
The formal verification file relies **only** on Lean 4 standard core axioms (`propext`, `Quot.sound`, `Classical.choice`):
```bash
lean formalization/TwoAdicDefectRigidity.lean
```

### Python Verification Suite
Audits all valuations, carry drift partitions, simulated failure escapes, and automaton spectrum up to $k = 100$:
```bash
python scripts/two_adic_verification.py
```

### LaTeX Manuscript Compilation
```bash
cd paper
pdflatex two_adic_proof.tex
pdflatex two_adic_proof.tex
```

---

## 📜 Citation & Releases

For academic citations, please reference the locked release tag [`v1.0.0`](https://github.com/KerimovEmil/DicksonPillai/releases/tag/v1.0.0):

```bibtex
@article{kerimov2026dicksonpillai,
  author    = {Kerimov, Emil},
  title     = {A 2-Adic Rigidity and Automata-Theoretic Framework for the Dickson--Pillai Problem in Waring's Problem},
  journal   = {Preprint},
  year      = {2026},
  note      = {Formal verification and computational engines available at \url{https://github.com/KerimovEmil/DicksonPillai} (tag v1.0.0)}
}
```
