// Get environment variables
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts heretest "Get a single environment variable" {
    const path = try std.process.getEnvVarOwned(alloc, "PATH");
    defer alloc.free(path);
    try std.testing.expect(path.len > 0);
}

test "Get all environment variables" {
    var env = try std.process.getEnvMap(alloc);
    defer env.deinit();
    try std.testing.expect(env.count() > 0);
} // Sample ends
