// {{ define name "Read user input from command line" }}
// {{ define id "user-input" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc = std.heap.page_allocator;
const max_line_size = 1024;

// Sample starts here{{ slot contents }}\
pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const maybe_input = try stdin.readUntilDelimiterOrEofAlloc(alloc, '\n', max_line_size);
    if (maybe_input) |input| {
        defer alloc.free(input);
        // use input
    }
} // {{ end }}{{ eval contents }} Sample ends

