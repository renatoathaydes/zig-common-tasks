// {{ define name "Get environment variables" }}
// {{ define id "get-env-vars" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Get a single environment variable" {
    const path = try std.process.getEnvVarOwned(alloc, "PATH");
    defer alloc.free(path);
    try std.testing.expect(path.len > 0);
}

test "Get all environment variables" {
    var env = try std.process.getEnvMap(alloc);
    defer env.deinit();
    try std.testing.expect(env.count() > 0);
} //{{ end }}{{ eval contents }} Sample ends
