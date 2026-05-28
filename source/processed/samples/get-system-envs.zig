// {{ define name "Get environment variables" }}
// {{ define id "get-env-vars" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Get a single environment variable" {
    // the only other way to get this is from std.process.Init
    const environ = std.testing.environ;
    const path = try environ.getAlloc(alloc, "PATH");
    defer alloc.free(path);
    try std.testing.expect(path.len > 0);
}

test "Get all environment variables" {
    // the only other way to get this is from std.process.Init
    const environ = std.testing.environ;
    var env = try std.process.Environ.createMap(environ, alloc);
    defer env.deinit();
    try std.testing.expect(env.count() > 0);
} //{{ end }}{{ eval contents }} Sample ends
