const std = @import("std");

pub fn build(b: *std.Build) void {
    const test_step = b.step("test", "Run all the samples");

    testAllSamples(b, test_step) catch |e| {
        std.debug.print("Error: {}", .{e});
    };
}

const test_targets = [_]std.Target.Query{
    .{}, // native
    .{
        .cpu_arch = .x86_64,
        .os_tag = .linux,
    },
    .{
        .cpu_arch = .aarch64,
        .os_tag = .macos,
    },
    .{
        .cpu_arch = .x86_64,
        .os_tag = .windows,
    },
};

const samples_dir = "source/processed/samples/";

fn testAllSamples(b: *std.Build, test_step: *std.Build.Step) !void {
    var samples = try std.fs.cwd().openDir(samples_dir, .{ .iterate = true });
    defer samples.close();
    var iterator = samples.iterate();
    var child = try iterator.next();
    var buffer: [1024]u8 = undefined;
    for (test_targets) |target| {
        while (child) |c| : (child = try iterator.next()) {
            const path = try std.fmt.bufPrint(&buffer, "{s}{s}", .{ samples_dir, c.name });
            const sample = b.addTest(.{
                .root_module = b.createModule(.{
                    .root_source_file = b.path(path),
                    .target = b.resolveTargetQuery(target),
                }),
            });
            const run_unit_test = b.addRunArtifact(sample);
            test_step.dependOn(&run_unit_test.step);
        }
    }
}
