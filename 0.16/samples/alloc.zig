// 
// 
// 
// Create allocators
const std = @import("std");

// Sample starts heretest "Get the test allocator" {
    const alloc = std.testing.allocator;
    _ = alloc; // use allocator
}

test "Create a general-purpose/debug allocator" {
    // notice: GeneralPurposeAllocator was renamed DebugAllocator in Zig 0.16.0
    var gpa = std.heap.DebugAllocator(.{}){};
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
    // ArenaAllocator is Thread-safe and Lock-free since Zig 0.16.0!
    const alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // the arena allocator will free everything allocated through it
    // when it is de-initialized.
    defer alloc.deinit();
}

// An allocator can also be obtained from the Init struct, which Zig
// can provide as an argument to the main function.
// See https://ziglang.org/download/0.16.0/release-notes.html#Juicy-Main
pub fn main(init: std.process.Init) !void {
    // ArenaAllocator:
    // Permanent storage for the entire process, cleaned automatically on
    // exit. Threadsafe.
    const arena = init.arena.allocator();

    // this will be freed automatically with the arena!
    const array = try arena.alloc([16]u8, 10);
    _ = array;

    // A default-selected general purpose allocator for temporary heap
    // allocations. Debug mode will set up leak checking if possible.
    // Threadsafe.
    const temp_alloc = init.gpa;

    // this must be manually freed!
    const temp_array = try temp_alloc.alloc([16]u8, 10);
    defer temp_alloc.free(temp_array);

    // no need to de-init the allocator coming from Init!
} // Sample ends
