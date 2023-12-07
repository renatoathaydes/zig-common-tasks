const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const test_step = b.step("test", "Run all the samples");

    testAllSamples(b, test_step) catch |e| {
        std.debug.print("Error: {}", .{e});
    };
}

const samples_dir = "source/processed/samples/";

fn testAllSamples(b: *std.build.Builder, test_step: *std.build.Step) !void {
    var samples = try std.fs.cwd().openIterableDir(samples_dir, .{});
    defer samples.close();
    var iterator = samples.iterate();
    var child = try iterator.next();
    var buffer: [1024]u8 = undefined;
    while (child) |c| : (child = try iterator.next()) {
        const path = try std.fmt.bufPrint(&buffer, "{s}{s}", .{ samples_dir, c.name });
        const sample = b.addTest(.{
            .root_source_file = .{ .path = path },
        }); 
        test_step.dependOn(&sample.step);
    }
}
