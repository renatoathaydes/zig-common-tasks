// {{ define name "Memory Safety" }}
// {{ define id "memory-safety" }}
// {{ define category "Memory Management" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Stack allocated data" {
    const Example = struct {
        fn createDataOnTheStack() anyerror![]u8 {
            // unless using allocators, data is allocated on the stack, not heap
            const data = [_]u8{ 1, 2 };

            // data on the stack can only be used while in the scope of the function
            try std.testing.expectEqual(1, data[0]); // OK

            // very, very bad (does NOT COMPILE since Zig 0.16.0)
            // return &data;

            // we cannot return a pointer to stack data, so an error is the only way out!
            return error.CannotReturnLocalVariablePointer;
        }
    };

    const empty: []u8 = &[_]u8{};

    _ = Example.createDataOnTheStack() catch empty;
}

test "Allocator-owned data" {
    const Example = struct {
        // in Zig, it is good practice to always take an allocator as an argument
        // in any function that needs to allocate memory outside the stack.
        fn createDataWithAllocator(allocator: std.mem.Allocator) anyerror![]u8 {
            const local_data = [_]u8{ 1, 2 };
            const data = try allocator.alloc(u8, 2);
            @memcpy(data, &local_data);
            return data; // OK, data is not allocated on the stack!
        }
    };

    const alloc = std.testing.allocator;

    const data = try Example.createDataWithAllocator(alloc);

    // Allocator-allocated data must be freed using the same allocator!
    // In tests, use `std.testing.allocator` and Zig will detect memory leaks and other errors.
    // In Debug mode, you will get warnings or errors when using `std.heapGeneralPurposeAllocator`
    // in cases like double-free, use-after-free and memory leaks.
    defer alloc.free(data);

    try std.testing.expectEqual(1, data[0]); // OK!

    // Zig does bounds-checking in safe mode (it panics on error).
    // To opt-out, use `-O ReleaseFast`
    try std.testing.expectEqual(2, data[1]); // OK!
}
