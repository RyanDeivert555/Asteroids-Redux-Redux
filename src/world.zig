const rl = @import("raylib");
const LogoData = @import("logo.zig").LogoData;

const GameState = enum {
    logo,
    menu,
    gameplay,
    ending,
};

pub const World = struct {
    screen_width: i32,
    screen_height: i32,
    state: GameState = GameState.logo,
    logo: LogoData,

    const Self = @This();

    pub fn init(screen_width: i32, screen_height: i32) Self {
        rl.setTraceLogLevel(.log_warning);
        rl.initWindow(screen_width, screen_height, "Asteroids Redux Redux");
        rl.setTargetFPS(60);

        return Self{
            .screen_width = screen_width,
            .screen_height = screen_height,
            .logo = LogoData.init(screen_width, screen_height),
        };
    }

    pub fn deinit(_: Self) void {
        rl.closeWindow();
    }

    fn updateLogo(self: *Self) void {
        self.logo.update();
    }

    fn drawLogo(self: Self) void {
        self.logo.draw();
    }

    pub fn update(self: *Self) void {
        switch (self.state) {
            .logo => {
                self.updateLogo();
                if (self.logo.isDone()) {
                    self.state = .menu;
                }
            },
            else => {},
        }
    }

    pub fn draw(self: Self) void {
        switch (self.state) {
            .logo => self.drawLogo(),
            .menu => rl.drawText("Menu state", 100, 100, 100, rl.Color.ray_white),
            else => {},
        }
    }
};
