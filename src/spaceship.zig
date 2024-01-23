const rl = @import("raylib");
const Movement = @import("movement.zig").Movement;
const Transform = @import("transform.zig").Transform;
const Render = @import("render.zig").Render;

pub const Spaceship = struct {
    movement: Movement,
    transform: Transform,
    render: Render,

    const Self = @This();

    pub fn init(movement: Movement, transform: Transform, render: Render) Self {
        return Self{
            .movement = movement,
            .transform = transform,
            .render = render,
        };
    }

    pub fn update(self: *Self) void {
        self.movement.update();
    }

    pub fn draw(self: Self) void {
        self.render.draw(self.movement.position, rl.Vector2.init(50.0, 50.0));
    }
};
