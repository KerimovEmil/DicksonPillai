from decimal import Decimal, getcontext
getcontext().prec = 40

records = [
    (22, 835999),
    (23, 2242294),
]

for rank, k in records:
    top64 = pow(3, k, 1 << k) >> (k - 64)
    frac = Decimal(top64) / Decimal(1 << 64)
    dist = Decimal(1) - frac
    lead_ones = 64 - (top64 ^ ((1 << 64) - 1)).bit_length()
    print(f"Rank {rank}: k = {k}")
    print(f"  fract((3/2)^{k}) = {frac:.20f}")
    print(f"  1 - fract        = {dist:.10e}")
    print(f"  leading ones     = {lead_ones}")
    print(f"  1/k              = {Decimal(1)/Decimal(k):.10e}")
    print(f"  in A153664?      = {'YES' if dist < Decimal(1)/Decimal(k) else 'NO'}")
    print()
