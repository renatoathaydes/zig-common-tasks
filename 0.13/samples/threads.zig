// Threads and channels
const std = @import("std");
const expectEqual = std.testing.expectEqual;

// Sample starts hereconst Val = std.atomic.Value(u32);
const Order = std.builtin.AtomicOrder;

fn toRunInThread(v: *Val) void {
    const value = v.load(Order.acquire);
    v.store(value + 1, Order.release);
}

test "Pass an atomic value to a Thread and wait for it to be modified" {
    const allocator = std.heap.page_allocator;

    // an atomic value to be updated by another Thread
    var value = Val.init(42);

    const thread = try std.Thread.spawn(.{
        // optional config
        .allocator = allocator,
        .stack_size = 1024,
    }, toRunInThread, .{&value});

    // must either join() or detach()
    thread.join();

    try expectEqual(@as(u32, 43), value.load(Order.unordered));
} //  Sample ends
