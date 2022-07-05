// Read file line by line
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts heretest "Read file one line at a time" {
    const max_bytes_per_line = 4096;
    var file = std.fs.cwd().openFile("my-file.txt", .{}) catch {
        // couldn't open file
        return;
    };
    defer file.close();
    // wrapping the reader into a std.io.bufferedReader is usually advised
    var reader = std.io.bufferedReader(file.reader()).reader();
    while (try reader.readUntilDelimiterOrEofAlloc(alloc, '\n', max_bytes_per_line)) |line| {
        defer alloc.free(line);
        _ = line; // use line
    }
} //  Sample ends
