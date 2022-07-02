// {{ define name "Allocators" }}{{ define id "allocators" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Get a test allocator" {
    const alloc = std.testing.allocator;
    var array = try alloc.alloc(u8, 10);
    try std.testing.expectEqual(@as(usize, 10), array.len);
    defer alloc.free(array);
} // {{ end }}{{ eval contents }} Sample ends 
