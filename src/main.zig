const rl = @import("raylib");
const AssetManager = @import("asset_manager.zig").AssetManager;
const Game = @import("world.zig").Game;
const Movement = @import("movement.zig").Movement;
const Transform = @import("transform.zig").Transform;
const Render = @import("render.zig").Render;
const Spaceship = @import("spaceship.zig").Spaceship;

pub fn main() !void {
    // TODO: have setup all in Game struct if possible
    rl.setTraceLogLevel(rl.TraceLogLevel.log_warning);
    const width = 800;
    const height = 600;
    rl.initWindow(width, height, "Asteroids Redux Redux");
    defer rl.closeWindow();
    rl.setTargetFPS(60);

    var game = Game.init(width, height);

    const movement = Movement.init(rl.Vector2.init(50.0, 50.0), rl.Vector2.init(1.0, 1.0), 100.0);
    const transform = Transform.init(rl.Vector2.init(1.0, 1.0), rl.Vector2.init(0.0, 0.0), 0.0);
    const render = Render.init(transform, rl.Color.blue, null);

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
