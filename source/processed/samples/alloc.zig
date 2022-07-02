// {{ define name "Allocators - how to get one" }}{{ define id "allocators" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Get a test allocator" {
    const alloc = std.testing.allocator;
    var array = try alloc.alloc(u8, 10);
    try std.testing.expectEqual(@as(usize, 10), array.len);
    defer alloc.free(array);
}

test "Get a fixed buffer allocator" {
    const alloc: std.mem.Allocator = init: {
        // use an array as the "heap"
        var buffer: [1024]u8 = undefined;
        var fba = std.heap.FixedBufferAllocator.init(&buffer);
        break :init fba.allocator();
    };
    const ptr = alloc.alloc(i32, 2048);
    try std.testing.expectError(error.OutOfMemory, ptr);
} // {{ end }}{{ eval contents }} Sample ends
