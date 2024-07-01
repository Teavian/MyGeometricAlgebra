pub fn main() !void {
    const a: PGA.Grade0 = .{ .one = 1 };
    const b: PGA.Grade3 = .{
        .e012 = 2,
        .e013 = 3,
        .e023 = 5,
        .e123 = 7,
    };
    std.debug.print("a^b = {any}\n", .{a.span(b)});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();
    // try stdout.print("Run `zig build test` to run the tests.\n", .{});
    // try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

const std = @import("std");
const PGA = @import("PGA3Df32.zig");
