// {{ define name "Loops" }}
// {{ define id "loops" }}
// {{ define category "Basics" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Simple for-each loop" {
    const items = [_]i32{ 1, 2, 3, 4 };
    var sum: i32 = 0;
    for (items) |item| {
        sum += item;
    }
    try std.testing.expectEqual(sum, 1 + 2 + 3 + 4);
}

test "Looping with indexes" {
    var items: [4]i32 = undefined;

    // the first item is the range being iterated over, the second gives the index
    for (4..8, 0..) |value, index| {
        items[index] = @as(i32, @intCast(value));
    }
    // notice that the range end is excluded
    const expected = [_]i32{ 4, 5, 6, 7 };
    try std.testing.expectEqualSlices(i32, &expected, &items);
}

test "For expression" {
    const x = for (1..10) |i| {
        if (i == 10) {
            break "too big"; // if break is called within the for loop, this is the result
        }
    } else els: { // if break is not called, the else block gives the result
        break :els "ok";
    };
    // if the range was 1..11, the x would be "too big"!
    try std.testing.expectEqualSlices(u8, "ok", x);
}

test "Simple while loop" {
    var done = false;
    // as in most other languages, "while" can just take a boolean variable
    while (!done) {
        done = true;
    }
    try std.testing.expect(done);
}

test "While not null" {
    // creating an iterable-like struct for this example
    const Items = struct {
        items: []i32,
        index: usize = 0,
        pub fn nextItem(self: *@This()) ?i32 {
            if (self.index >= self.items.len) {
                return null;
            }
            defer self.index += 1;
            return self.items[self.index];
        }
    };

    var items_array = [_]i32{ 1, 2, 3 };
    var items: Items = .{ .items = &items_array };

    var sum_before_null: i32 = 0;
    var has_null = false;

    // loop while the iterable does not return null
    while (items.nextItem()) |item| {
        sum_before_null += item;
    } else { // when a null is found, the else branch runs and the loop exits
        has_null = true;
    }
    try std.testing.expect(has_null);
    try std.testing.expectEqual(1 + 2 + 3, sum_before_null);
}

test "While not error" {
    // creating a struct for this example
    const Positive = struct {
        value: u32,

        pub fn decrement(self: *@This()) void {
            if (self.value > 0) self.value -= 1;
        }

        pub fn get(self: *@This()) anyerror!u32 {
            if (self.value == 0) return error.ZeroValue;
            return self.value;
        }
    };

    var positive: Positive = .{ .value = 2 };
    var sum: u32 = 0;

    // while no error, keep looping... decrement the value after each iteration.
    while (positive.get()) |value| : (positive.decrement()) {
        sum += value;
    } else |err| { // the optional else branch can capture the final error
        std.debug.assert(err == error.ZeroValue);
    }

    try std.testing.expectEqual(3, sum);
}
