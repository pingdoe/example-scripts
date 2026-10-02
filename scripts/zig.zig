const std = @import("std");

pub fn main() !void {
    // EXAMPLE link replace with own url
    const url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18";
    const interval_minutes: u64 = 5;

    std.debug.print("Starting PingDoe heartbeat every {d} minutes...\n", .{interval_minutes});

    var allocator = std.heap.page_allocator;
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();

    while (true) {
        const result = client.fetch(.{
            .location = .{ .url = url },
            .method = .GET,
        }) catch |err| {
            std.debug.print("Ping failed: {}\n", .{err});
            std.time.sleep(interval_minutes * 60 * std.time.ns_per_s);
            continue;
        };

        std.debug.print("Ping successful: {d}\n", .{result.status});
        std.time.sleep(interval_minutes * 60 * std.time.ns_per_s);
    }
}
