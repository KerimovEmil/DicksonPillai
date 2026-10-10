# OEIS Sequence A153663 Submission & Analysis

- **Sequence ID:** [OEIS A153663](https://oeis.org/A153663)
- **Title:** Minimal exponents $m$ such that the fractional part of $(3/2)^m$ reaches a maximum (when starting with $m=1$).
- **Status:** Correction & extension submitted to the OEIS editorial review queue (October 2026).
- **Author of Correction:** Emil Kerimov

---

## 1. Summary of Correction

In the May 2012 extension by Robert Price, terms $a(22) = 835999$ through $a(25) = 92600006$ were added, jumping directly from $a(23) = 2242294$ to $a(24) = 25380333$. Price included the following comment:

> *"The fractional part of k=835999 is .999999 5 which is greater than (k-1)/k. The fractional part of k=2242294 is .999999 8 which is greater than (k-1)/k. The fractional part of k=25380333 is .999999 98 which is greater than (k-1)/k. The fractional part of k=92600006 is .999999 998 which is greater than (k-1)/k. So, all additional numbers in this sequence must be in A153664 and >3*10^8."*

### Why $k = 10{,}406{,}357$ Was Omitted

The assumption that all subsequent record exponents must satisfy the polynomial proximity condition $\delta_k > 1 - 1/k$ ([OEIS A153664](https://oeis.org/A153664)) is a heuristic that fails at $k = 10{,}406{,}357$:

1. **Upper Record Definition (A153663):** Requires only that $\delta_m > \delta_k$ for all $1 \le k < m$.
2. **Comparison with Preceding Record ($k = 2{,}242{,}294$):**
   - At $k = 2{,}242{,}294$: $1 - \delta_{2242294} \approx 1.448996 \times 10^{-7}$ (22 leading binary ones).
   - At $k = 10{,}406{,}357$: $1 - \delta_{10406357} \approx 1.118300 \times 10^{-7}$ (23 leading binary ones).
   - Since $1.118300 \times 10^{-7} < 1.448996 \times 10^{-7}$, we have:
     $$\delta_{10406357} > \delta_{2242294}.$$
3. **Absence from A153664:**
   - $1/k = 1/10406357 \approx 9.6095 \times 10^{-8}$.
   - Because $1.1183 \times 10^{-7} > 9.6095 \times 10^{-8}$, $k = 10{,}406{,}357$ narrowly misses A153664, causing it to be absent from the filtered search space in 2012.

An exhaustive multi-core verification across all $k \le 50{,}000{,}000$ confirmed that no index between $2{,}242{,}294$ and $10{,}406{,}357$ achieves a larger fractional part.

---

## 2. Updated 26-Term Sequence

```
1, 5, 8, 10, 12, 14, 46, 58, 105, 157, 163, 455, 1060, 1256, 2677, 8093, 28277, 33327,
49304, 158643, 164000, 835999, 2242294, 10406357, 25380333, 92600006
```

---

## 3. Certified Table of Order Statistics

| Rank | $k$ | Leading 1s ($L_k$) | Distance to 1 ($1 - \delta_k$) | $L_{\mathrm{fail}}$ Required | Bit Margin | Safety Factor vs. $(3/4)^k$ | Status |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **1** | 1 | 1 | $5.0000 \times 10^{-1}$ | 0 | -1 | $10^{-0.2}$ | Original |
| **6** | 14 | 3 | $7.0740 \times 10^{-2}$ | 5 | 2 | $10^{0.6}$ | Original |
| **11** | 163 | 7 | $4.4986 \times 10^{-3}$ | 67 | 60 | $10^{18.0}$ | Original |
| **16** | 8,093 | 13 | $8.0987 \times 10^{-5}$ | 3,358 | 3,345 | $10^{1,007.0}$ | Original |
| **19** | 49,304 | 17 | $7.3640 \times 10^{-6}$ | 20,463 | 20,446 | $10^{6,154.8}$ | Original |
| **21** | 164,000 | 19 | $1.7533 \times 10^{-6}$ | 68,066 | 68,047 | $10^{20,484.2}$ | Original |
| **22** | 835,999 | 21 | $4.6842 \times 10^{-7}$ | 346,970 | 346,949 | $10^{104,442.3}$ | Original |
| **23** | 2,242,294 | 22 | $1.4490 \times 10^{-7}$ | 930,636 | 930,614 | $10^{280,142.5}$ | Original |
| **24** | **10,406,357** | **23** | **$1.1183 \times 10^{-7}$** | **4,319,028** | **4,319,005** | **$10^{1,300,150.1}$** | **NEW DISCOVERY** |
| **25** | 25,380,333 | 26 | $1.3245 \times 10^{-8}$ | 10,533,789 | 10,533,763 | $10^{3,170,978.9}$ | Shifted (was #24) |
| **26** | 92,600,006 | 29 | $1.2500 \times 10^{-9}$ | 38,432,474 | 38,432,445 | $10^{11,569,318.9}$ | Shifted (was #25) |

---

## 4. Associated Files in this Directory

- [`b153663.txt`](./b153663.txt): Official OEIS b-file with all 26 certified terms ($n = 1 \dots 26$).
- [`oeis_record_verifier.py`](./oeis_record_verifier.py): Standalone script to reproduce the order statistics and valuations.
