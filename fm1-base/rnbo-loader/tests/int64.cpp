/* SPDX-License-Identifier: MIT */
#include <cassert>
#include <cstdint>
#include <cstring>
#include <cstdio>
#include <limits>
#include <cmath>
#include "../../rnbo/int64.h"
int main() {
    unsigned int random = 0x61234567u;
    unsigned int checked = 0;
    for (unsigned int i = 0; i < 3000000; ++i) {
        random ^= random << 13; random ^= random >> 17; random ^= random << 5;
        float value; std::memcpy(&value, &random, 4);
        if (std::isfinite(value) && value >= -9223372036854775808.0 && value < 9223372036854775808.0) {
            assert(RNBO::fm1_float_to_int64(value) == static_cast<long long>(value));
            ++checked;
        }
    }
    assert(RNBO::fm1_float_to_int64(std::numeric_limits<float>::quiet_NaN()) == 0);
    assert(RNBO::fm1_float_to_int64(std::numeric_limits<float>::infinity()) == std::numeric_limits<long long>::max());
    assert(RNBO::fm1_float_to_int64(-std::numeric_limits<float>::infinity()) == std::numeric_limits<long long>::min());
    assert(RNBO::fm1_float_to_int64(-9223372036854775808.0f) == std::numeric_limits<long long>::min());
    assert(RNBO::fm1_float_to_int64(9007199254740993LL) == 9007199254740993LL);
    std::printf("PASS %u defined binary32-to-int64 conversions and boundary/overload checks\n", checked);
}
