// Create allocators
const std = @import("std");

// Sample starts heretest "Get the test allocator" {
    const alloc = std.testing.allocator;
    _ = alloc; // use allocator
}

test "Create a general-purpose allocator" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // call deinit to free it if necessary
    defer _ = gpa.deinit();
    _ = gpa.allocator(); // use allocator
}

test "Get system-native page allocator" {
    const alloc: std.mem.Allocator = std.heap.page_allocator;
    _ = alloc; // use allocator
}

test "Create a fixed buffer allocator" {
    const alloc: std.mem.Allocator = init: {
        // use an array as the "heap"
        var buffer: [1024]u8 = undefined;
        var fba = std.heap.FixedBufferAllocator.init(&buffer);
        break :init fba.allocator();
    };
    _ = alloc; // use allocator
}

test "Get an Arena allocator" {
    const alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // the arena allocator will free everything allocated through it
    // when it is de-initialized.
    defer alloc.deinit();
} //  Sample ends
