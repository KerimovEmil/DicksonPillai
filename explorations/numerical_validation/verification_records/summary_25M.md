# Theory-Accelerated Verification Summary: $k = 1$ to 25,000,000 (25M)

- **Date of Execution:** 2026-10-08 09:04:57
- **Engine:** C++ Parallel Multi-Core 2-Adic Verifier v2 (`parallel_verifier.exe`)
- **Theorems Applied:** Theorem 1 (Mod 8 Exclusion), Theorem 5 (State Collapse $O(1)$ Filter), 2-Adic Horizon Truncation
- **Hardware:** AMD Ryzen AI 9 365 (20 logical threads | Zen 5 Architecture)
- **Range Checked:** $k \in [1, 25,000,000]$
- **Total Exceptions / Violations:** **0**
- **Verification Status:** **100% Valid (Passed - Dickson–Pillai Condition Holds)**
- **Total Execution Time:** 1522.58 seconds (25.38 minutes)
- **Aggregate Throughput:** **16,419 k/sec**

---

## 1. Extreme Diophantine Records (Longest Runs of Leading Ones in ${(3/2)^k}$)

A Dickson–Pillai failure requires $\alpha_k = \frac{L_k}{k} \ge \lambda_{\mathrm{target}} = \log_2(4/3) \approx 0.415037$.
Below are the top empirical record holders with the longest continuous runs of leading 1-bits after the binary point:

| Rank | $k$ | Leading 1s ($L_k$) | Distance to 1 ($1 - \delta_k$) | Effective $\alpha_k = L/k$ | Target Barrier |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **#1** | **10,406,357** | **23** | 1.118300e-07 | 0.000002 | 0.415037 |
| **#2** | **2,242,294** | **22** | 1.449000e-07 | 0.000010 | 0.415037 |
| **#3** | **3,965,133** | **22** | 1.858430e-07 | 0.000006 | 0.415037 |
| **#4** | **2,242,295** | **22** | 2.173490e-07 | 0.000010 | 0.415037 |
| **#5** | **2,242,296** | **21** | 3.260240e-07 | 0.000010 | 0.415037 |
| **#6** | **6,427,354** | **21** | 3.942910e-07 | 0.000003 | 0.415037 |
| **#7** | **3,247,981** | **21** | 4.170040e-07 | 0.000007 | 0.415037 |
| **#8** | **835,999** | **21** | 4.684210e-07 | 0.000025 | 0.415037 |
| **#9** | **16,193,691** | **20** | 5.201890e-07 | 0.000001 | 0.415037 |
| **#10** | **1,703,697** | **20** | 7.335840e-07 | 0.000012 | 0.415037 |
| **#11** | **10,652,513** | **20** | 7.367150e-07 | 0.000002 | 0.415037 |
| **#12** | **16,193,692** | **20** | 7.802830e-07 | 0.000001 | 0.415037 |
| **#13** | **2,460,186** | **19** | 1.004880e-06 | 0.000008 | 0.415037 |
| **#14** | **24,405,480** | **19** | 1.082460e-06 | 0.000001 | 0.415037 |
| **#15** | **16,193,693** | **19** | 1.170420e-06 | 0.000001 | 0.415037 |
| **#16** | **4,361,902** | **19** | 1.171550e-06 | 0.000005 | 0.415037 |
| **#17** | **19,210,978** | **19** | 1.262820e-06 | 0.000001 | 0.415037 |
| **#18** | **20,867,331** | **19** | 1.448570e-06 | 0.000001 | 0.415037 |
| **#19** | **2,460,187** | **19** | 1.507320e-06 | 0.000008 | 0.415037 |
| **#20** | **23,935,234** | **19** | 1.533650e-06 | 0.000001 | 0.415037 |
| **#21** | **10,837,316** | **19** | 1.569790e-06 | 0.000002 | 0.415037 |
| **#22** | **2,647,152** | **19** | 1.588110e-06 | 0.000007 | 0.415037 |
| **#23** | **24,405,481** | **19** | 1.623690e-06 | 0.000001 | 0.415037 |
| **#24** | **18,054,658** | **19** | 1.637170e-06 | 0.000001 | 0.415037 |
| **#25** | **9,980,902** | **19** | 1.637320e-06 | 0.000002 | 0.415037 |

---

## 2. Independent Verification Protocol
Any record above can be independently certified in Python without external libraries:
```python
k = 10406357
top64 = pow(3, k, 1 << k) >> (k - 64)
leading_ones = 64 - (top64 ^ ((1 << 64) - 1)).bit_length()
print(f"k={k}: leading_ones={leading_ones}, top64={hex(top64)}")
```
