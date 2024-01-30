const rl = @import("raylib");
const Movement = @import("movement.zig").Movement;
const Transform = @import("transform.zig").Transform;
const Render = @import("render.zig").Render;
const Lifetime = @import("lifetime.zig");

pub const Spaceship = struct {
    movement: Movement,
    transform: Transform,
    render: Render,
    lifetime: Lifetime.Lifetime(Spaceship, Spaceship.alive),

    const Self = @This();

    pub fn init(movement: Movement, transform: Transform, render: Render) Self {
        return Self{
            .movement = movement,
            .transform = transform,
            .render = render,
            .lifetime = Lifetime.Lifetime(Self, Self.alive).init(true),
        };
    }

    fn alive(_: *const Self) bool {
        return true;
    }

    pub fn update(self: *Self) void {
        _ = self.lifetime.checkLifetime(self);
        self.movement.update();
    }

    pub fn draw(self: Self) void {
        //self.render.draw(self.movement.position, rl.Vector2.init(50.0, 50.0));
        self.render.drawTexture(self.movement.position);
    }
};
