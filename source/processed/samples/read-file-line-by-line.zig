// {{ define name "Read file line by line" }}{{ define id "read-file-line-by-line" }}{{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Read file one line at a time" {
    const max_bytes_per_line = 4096;
    var file = std.fs.cwd().openFile("my-file.txt", .{}) catch {
        // couldn't open file
        return;
    };
    defer file.close();

    var read_buffer: [max_bytes_per_line]u8 = undefined;
    var reader = file.readerStreaming(&read_buffer).interface;

    while (try reader.takeDelimiter('\n')) |line| {
        // use line
        _ = line;
    }
} // {{ end }}{{ eval contents }} Sample ends
