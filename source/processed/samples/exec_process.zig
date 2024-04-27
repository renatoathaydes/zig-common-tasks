// {{ define name "Process - execute" }}{{ define id "exec-process" }}{{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Execute a process (inherit stdout and stderr)" {
    // the command to run
    const argv = [_][]const u8{ "ls", "./" };

    // init a ChildProcess... cleanup is done by calling wait().
    var proc = std.ChildProcess.init(&argv, alloc);

    // ignore the streams to avoid the zig build blocking...
    // REMOVE THESE IF YOU ACTUALLY WANT TO INHERIT THE STREAMS.
    proc.stdin_behavior = .Ignore;
    proc.stdout_behavior = .Ignore;
    proc.stderr_behavior = .Ignore;

    try proc.spawn();

    //std.debug.print("Spawned process PID={}\n", .{proc.id});

    // the process only ends after this call returns.
    const term = try proc.wait();

    // term can be .Exited, .Signal, .Stopped, .Unknown
    try std.testing.expectEqual(term, std.ChildProcess.Term{ .Exited = 0 });
}

test "Execute a process (consume stdout and stderr into allocated memory)" {
    // the command to run
    const argv = [_][]const u8{ "ls", "./" };

    const proc = try std.ChildProcess.run(.{
        .allocator = alloc,
        .argv = &argv,
    });

    // on success, we own the output streams
    defer alloc.free(proc.stdout);
    defer alloc.free(proc.stderr);

    const term = proc.term;

    try std.testing.expectEqual(term, std.ChildProcess.Term{ .Exited = 0 });
    try std.testing.expect(proc.stdout.len != 0);
    try std.testing.expectEqual(proc.stderr.len, 0);
}
