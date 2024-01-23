const rl = @import("raylib");
const rlm = @import("raylib-math");

pub const Movement = struct {
    position: rl.Vector2,
    direction: rl.Vector2,
    speed: f32,

    const Self = @This();

    pub fn init(position: rl.Vector2, direction: rl.Vector2, speed: f32) Self {
        return Self{
            .position = position,
            .direction = direction,
            .speed = speed,
        };
    }

    pub fn setDirection(self: *Self, new_direction: rl.Vector2) void {
        self.direction = rlm.vector2Normalize(new_direction);
    }

    pub fn update(self: *Self) void {
        const dt = rl.getFrameTime();
        self.position = rlm.vector2Add(self.position, rlm.vector2Scale(self.direction, self.speed * dt));
    }
};
