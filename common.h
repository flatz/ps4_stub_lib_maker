#pragma once

#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define JOIN_HELPER(x, y) x##y
#define JOIN(x, y) JOIN_HELPER(x, y)
#define JOIN3_HELPER(x, y, z) x##y##z
#define JOIN3(x, y, z) JOIN3_HELPER(x, y, z)

#define TYPE_PAD(size) char JOIN(_pad_, __COUNTER__)[size]
#define TYPE_VARIADIC_BEGIN(name) name { union {
#define TYPE_BEGIN(name, size) name { union { TYPE_PAD(size)
#define TYPE_END(...) }; } __VA_ARGS__
#define TYPE_FIELD(field, offset) struct { TYPE_PAD(offset); field; }

#define TYPE_CHECK_SIZE(name, size) \
	_Static_assert(sizeof(name) == (size), "Size of " #name " != " #size)

#define TYPE_CHECK_FIELD_OFFSET(name, member, offset) \
	_Static_assert(offsetof(name, member) == (offset), "Offset of " #name "." #member " != " #offset)

#define TYPE_CHECK_FIELD_SIZE(name, member, size) \
	_Static_assert(sizeof(((name*)0)->member) == (size), "Size of " #name "." #member " != " #size)

#define NEED_EXPORT __declspec(dllexport)

#define EXPORT_FUN(def) NEED_EXPORT def {}
#define EXPORT_OBJ(def) NEED_EXPORT def

#define $(name, nid) JOIN3(name, __nid_, nid)
