const rl = @import("raylib");
const AssetManager = @import("asset_manager.zig").AssetManager;
const World = @import("world.zig").World;
const Movement = @import("movement.zig").Movement;
const Transform = @import("transform.zig").Transform;
const Render = @import("render.zig").Render;
const Spaceship = @import("spaceship.zig").Spaceship;

pub fn main() void {
    const width = 800;
    const height = 600;

    var game = World.init(width, height);
    defer game.deinit();

    const movement = Movement.init(rl.Vector2.init(50.0, 50.0), rl.Vector2.init(1.0, 1.0), 100.0);
    const transform = Transform.init(rl.Vector2.init(1.0, 1.0), rl.Vector2.init(0.0, 0.0), 0.0);
    const render = Render.init(transform, rl.Color.blue, rl.loadTexture("assets/ship1.png"));

    var spaceship = Spaceship.init(movement, transform, render);

    while (!rl.windowShouldClose()) {
        game.update();
        spaceship.update();
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.black);
        game.draw();
        spaceship.draw();
        rl.drawFPS(0, 0);
    }
}
