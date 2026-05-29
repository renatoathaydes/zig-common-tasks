// 
// 
// 
// Get environment variables
const std = @import("std");

// Sample starts here// Environment variables can be obtained from the Init.Minimal struct, which Zig
// can provide as an argument to the main function.
// See https://ziglang.org/download/0.16.0/release-notes.html#Juicy-Main
pub fn main(init: std.process.Init) !void {
    const env: *std.process.Environ.Map = init.environ_map;
    std.log.info("Number of env vars: {d}", .{env.count()});

    const path = env.get("PATH") orelse "";
    std.log.info("PATH={s}", .{path});
} // Sample ends
