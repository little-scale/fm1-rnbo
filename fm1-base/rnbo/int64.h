/* SPDX-License-Identifier: MIT */
#pragma once
/* Binary32 truncation without an FP-to-int64 runtime helper. All defined
 * float-to-int64 casts are exact; NaN maps to zero and overflow saturates. */
namespace RNBO {
inline long long fm1_float_to_int64(float value) {
    static_assert(sizeof(float) == 4 && sizeof(long long) == 8, "binary32/int64 required");
    unsigned int bits;
    __builtin_memcpy(&bits, &value, 4);
    const unsigned int exponent = (bits >> 23) & 255u;
    if (exponent < 127u) return 0;
    const bool negative = (bits >> 31) != 0;
    if (exponent >= 190u) {
        if (exponent == 255u && (bits & 0x7fffffu)) return 0;
        return negative ? (-9223372036854775807LL - 1) : 9223372036854775807LL;
    }
    const unsigned int mantissa = (bits & 0x7fffffu) | 0x800000u;
    const unsigned long long magnitude = exponent < 150u
        ? mantissa >> (150u - exponent)
        : static_cast<unsigned long long>(mantissa) << (exponent - 150u);
    const long long result = static_cast<long long>(magnitude);
    return negative ? -result : result;
}
// Integer expressions retain their full range and existing cast semantics.
template <typename T> inline long long fm1_float_to_int64(T value) {
    return static_cast<long long>(value);
}
}
