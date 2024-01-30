pub fn Lifetime(comptime T: type, comptime condition: fn (*const T) bool) type {
    return struct {
        alive: bool,

        const Self = @This();

        pub fn init(initial_state: bool) Self {
            return Self{
                .alive = initial_state,
            };
        }

        pub fn checkLifetime(self: *Self, parent: *const T) bool {
            self.alive = condition(parent);

            return self.alive;
        }
    };
}

fn alive(num: *const i32) bool {
    return num.* > 10;
}

test "lifetime" {
    const std = @import("std");

    var lifetime = Lifetime(i32, alive).init(true);
    var num1: i32 = 10;
    var num2: i32 = 100;
    try std.testing.expect(lifetime.checkLifetime(&num1) == false);
    try std.testing.expect(lifetime.checkLifetime(&num2) == true);
}

// other possible implementation
// pub fn Lifetime(comptime condition: anytype) type {
//     return struct {
//         alive: bool,

//         const Self = @This();

//         pub fn init(initial_state: bool) Self {
//             return Self{
//                 .alive = initial_state,
//             };
//         }

//         pub fn checkLifetime(self: *Self, args: anytype) bool {
//             self.alive = @call(.auto, condition, args);
//             return self.alive;
//         }
//     };
// }

// fn alive(num: i32) bool {
//     return num > 10;
// }

// test "lifetime" {
//     var lifetime = Lifetime(alive).init(true);
//     try std.testing.expect(lifetime.checkLifetime(.{10}) == false);
//     try std.testing.expect(lifetime.checkLifetime(.{100}) == true);
// }
