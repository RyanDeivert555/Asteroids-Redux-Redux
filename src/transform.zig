const rl = @import("raylib");

pub const Transform = struct {
    scale: rl.Vector2,
    origin: rl.Vector2,
    rotation: f32,

    const Self = @This();

    pub fn init(scale: rl.Vector2, origin: rl.Vector2, rotation: f32) Self {
        return Self{
            .scale = scale,
            .origin = origin,
            .rotation = rotation,
        };
    }
};
