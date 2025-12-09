// {{ define name "void pointers" }}
// {{ define id "c-interop-void-pointers" }}
// {{ define category "C Interop" }}
// {{ eval name }}
const std = @import("std");
const alloc = std.testing.allocator;
const expect = std.testing.expect;

// Sample starts here{{ slot contents }}\
const c_code =
    \\
    \\static const void* _value;
    \\void store_void(const void* v) { _value = v; }
    \\const void* get_void() { return _value; }
;

// WARNING: @cImport will eventually go away.
//          https://github.com/ziglang/zig/issues/20630
const c = @cImport({
    // normally you would include headers or even c files, like this:
    //@cInclude("test.c");
    // but for this sample, C code is directly defined here
    @cDefine("MY_C_CODE", c_code);
});

test "deal with void pointer from C" {
    // send some value to be stored in C as a void* pointer
    c.store_void(@as(?*const anyopaque, &@as(u32, 10)));

    // retrieve the value which now is "untyped", or opaque
    const untyped_value: ?*const anyopaque = c.get_void();

    // to restore the type, we must cast it to the known type explicitly
    const value: *const u32 = @ptrCast(@alignCast( untyped_value));
    
    try std.testing.expectEqual(@as(u32, 10), value.*);
}

