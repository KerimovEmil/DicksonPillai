# Theory-Accelerated Verification Summary: $k = 1$ to 50,000,000 (50M)

- **Date of Execution:** 2026-10-08 11:35:18
- **Engine:** C++ Parallel Multi-Core 2-Adic Verifier v2 (`parallel_verifier.exe`)
- **Theorems Applied:** Theorem 1 (Mod 8 Exclusion), Theorem 5 (State Collapse $O(1)$ Filter), 2-Adic Horizon Truncation
- **Hardware:** AMD Ryzen AI 9 365 (20 logical threads | Zen 5 Architecture)
- **Range Checked:** $k \in [1, 50,000,000]$
- **Total Exceptions / Violations:** **0**
- **Verification Status:** **100% Valid (Passed - Dickson–Pillai Condition Holds)**
- **Total Execution Time:** 9009.42 seconds (150.16 minutes)
- **Aggregate Throughput:** **5,549 k/sec**

---

## 1. Extreme Diophantine Records (Longest Runs of Leading Ones in ${(3/2)^k}$)

A Dickson–Pillai failure requires $\alpha_k = \frac{L_k}{k} \ge \lambda_{\mathrm{target}} = \log_2(4/3) \approx 0.415037$.
Below are the top empirical record holders with the longest continuous runs of leading 1-bits after the binary point:

| Rank | $k$ | Leading 1s ($L_k$) | Distance to 1 ($1 - \delta_k$) | Effective $\alpha_k = L/k$ | Target Barrier |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **#1** | **25,380,333** | **26** | 1.324450e-08 | 0.000001 | 0.415037 |
| **#2** | **47,756,402** | **25** | 2.514540e-08 | 0.000001 | 0.415037 |
| **#3** | **32,669,644** | **23** | 1.033660e-07 | 0.000001 | 0.415037 |
| **#4** | **10,406,357** | **23** | 1.118300e-07 | 0.000002 | 0.415037 |
| **#5** | **35,751,948** | **22** | 1.223300e-07 | 0.000001 | 0.415037 |
| **#6** | **2,242,294** | **22** | 1.449000e-07 | 0.000010 | 0.415037 |
| **#7** | **32,669,645** | **22** | 1.550500e-07 | 0.000001 | 0.415037 |
| **#8** | **3,965,133** | **22** | 1.858430e-07 | 0.000006 | 0.415037 |
| **#9** | **43,715,361** | **22** | 2.101330e-07 | 0.000001 | 0.415037 |
| **#10** | **2,242,295** | **22** | 2.173490e-07 | 0.000010 | 0.415037 |
| **#11** | **43,715,362** | **21** | 3.151990e-07 | 0.000000 | 0.415037 |
| **#12** | **2,242,296** | **21** | 3.260240e-07 | 0.000010 | 0.415037 |
| **#13** | **26,902,707** | **21** | 3.709070e-07 | 0.000001 | 0.415037 |
| **#14** | **6,427,354** | **21** | 3.942910e-07 | 0.000003 | 0.415037 |
| **#15** | **35,069,024** | **21** | 4.163760e-07 | 0.000001 | 0.415037 |
| **#16** | **3,247,981** | **21** | 4.170040e-07 | 0.000007 | 0.415037 |
| **#17** | **835,999** | **21** | 4.684210e-07 | 0.000025 | 0.415037 |
| **#18** | **40,061,360** | **20** | 4.966930e-07 | 0.000001 | 0.415037 |
| **#19** | **16,193,691** | **20** | 5.201890e-07 | 0.000001 | 0.415037 |
| **#20** | **26,902,708** | **20** | 5.563600e-07 | 0.000001 | 0.415037 |
| **#21** | **28,832,305** | **20** | 5.719370e-07 | 0.000001 | 0.415037 |
| **#22** | **49,533,310** | **20** | 6.217370e-07 | 0.000000 | 0.415037 |
| **#23** | **35,069,025** | **20** | 6.245640e-07 | 0.000001 | 0.415037 |
| **#24** | **1,703,697** | **20** | 7.335840e-07 | 0.000012 | 0.415037 |
| **#25** | **10,652,513** | **20** | 7.367150e-07 | 0.000002 | 0.415037 |

---

## 2. Independent Verification Protocol
Any record above can be independently certified in Python without external libraries:
```python
k = 25380333
top64 = pow(3, k, 1 << k) >> (k - 64)
leading_ones = 64 - (top64 ^ ((1 << 64) - 1)).bit_length()
print(f"k={k}: leading_ones={leading_ones}, top64={hex(top64)}")
```
