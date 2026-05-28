// {{ define name "Process - execute" }}
// {{ define id "exec-process" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;
const assert = std.debug.assert;

// Sample starts here{{ slot contents }}\
test "Execute a process (inherit stdout and stderr)" {
    const io = std.testing.io;

    // the command to run
    const argv = [_][]const u8{ "ls", "./" };

    // init a ChildProcess... cleanup is done by calling wait().
    var proc = try std.process.spawn(io, .{
        .argv = &argv,
        // here, we ignore the streams to avoid the zig build blocking...
        // by default, the streams are set to `.inherit`, so just remove these in most cases!
        .stdin = .ignore,
        .stdout = .ignore,
        .stderr = .ignore,
    });

    //std.debug.print("Spawned process PID={}\n", .{proc.id});

    // the process only ends after this call returns.
    const term = try proc.wait(io);

    // term can be .Exited, .Signal, .Stopped, .Unknown
    try std.testing.expectEqual(0, switch (term) {
        .exited => |code| code,
        else => 1,
    });
}

test "Execute a process (consume stdout and stderr into allocated memory)" {
    const io = std.testing.io;

    // the command to run
    const argv = [_][]const u8{ "ls", "./" };

    // init a ChildProcess... cleanup is done by calling wait().
    var proc = try std.process.spawn(io, .{
        .argv = &argv,
        .stdin = .ignore,
        .stdout = .pipe,
        .stderr = .pipe,
    });

    // on success, the pipe streams are assigned to File objects.
    assert(proc.stdout != null);
    assert(proc.stderr != null);

    const term = try proc.wait(io);

    try std.testing.expectEqual(0, switch (term) {
        .exited => |code| code,
        else => 1,
    });
}
