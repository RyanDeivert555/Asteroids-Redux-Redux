const rl = @import("raylib");

pub fn main() !void {
    rl.initWindow(800, 600, "Asteroids Redux Redux");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.white);
    }
}
