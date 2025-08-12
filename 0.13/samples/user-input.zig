// Read user input from command line
const std = @import("std");

const alloc = std.heap.page_allocator;
const max_line_size = 1024;

// Sample starts herepub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const maybe_input = try stdin.readUntilDelimiterOrEofAlloc(alloc, '\n', max_line_size);
    if (maybe_input) |input| {
        defer alloc.free(input);
        // use input
    }
} //  Sample ends

