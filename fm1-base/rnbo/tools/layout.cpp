/* SPDX-License-Identifier: MIT */
/* Compile-only 32-bit ABI proxy. This is not FM1 machine code. */
#include "../bridge.cpp"
static_assert(sizeof(void*)==4,"32-bit pointer check");
static_assert(sizeof(size_t)==4,"32-bit allocation sizes");
static_assert(sizeof(RNBO::Int)==4,"32-bit RNBO integer check");
extern "C" {
extern const unsigned int rnbo_fm1_layout[]={
    sizeof(void*),sizeof(size_t),sizeof(RNBO::Int),sizeof(RNBO::SampleValue),
    sizeof(RNBO::MillisecondTime),sizeof(Patch),sizeof(arena),sizeof(left)+sizeof(right),
    sizeof(RNBO::MinimalEngine<>::InternalEvent),sizeof(RNBO::MinimalEngine<>)
};
}
