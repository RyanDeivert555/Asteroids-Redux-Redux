const rl = @import("raylib");
// hardcoded shit

const LogoState = enum {
    blinking,
    top_left_grow,
    bottom_right_grow,
    letters_appearing,
    reset,
};

pub const LogoData = struct {
    x: i32,
    y: i32,
    frame_count: i32 = 0,
    letter_count: i32 = 0,
    top_side_rect_width: i32 = 16,
    left_side_rect_height: i32 = 16,
    bottom_side_rect_width: i32 = 16,
    right_side_rect_height: i32 = 16,
    state: LogoState = .blinking,
    alpha: f32 = 1.0,

    const Self = @This();
    const outline_color = rl.Color.ray_white;
    //const background_color = rl.Color.black;

    pub fn init(screen_width: i32, screen_height: i32) Self {
        const x = @divTrunc(screen_width, 2) - 128;
        const y = @divTrunc(screen_height, 2) - 128;

        return Self{
            .x = x,
            .y = y,
        };
    }

    pub fn update(self: *Self) void {
        if (self.state == .blinking) {
            self.frame_count += 1;
            if (self.frame_count == 120) {
                self.state = .top_left_grow;
                self.frame_count = 0;
            }
        } else if (self.state == .top_left_grow) {
            self.top_side_rect_width += 4;
            self.left_side_rect_height += 4;

            if (self.top_side_rect_width == 256) {
                self.state = .bottom_right_grow;
            }
        } else if (self.state == .bottom_right_grow) {
            self.bottom_side_rect_width += 4;
            self.right_side_rect_height += 4;

            if (self.bottom_side_rect_width == 256) {
                self.state = .letters_appearing;
            }
        } else if (self.state == .letters_appearing) {
            self.frame_count += 1;

            if (@divTrunc(self.frame_count, 12) >= 1) {
                self.letter_count += 1;
                self.frame_count = 0;
            }

            if (self.letter_count >= 10) {
                self.alpha -= 0.02;

                if (self.alpha <= 0.0) {
                    self.alpha = 0.0;
                    self.state = .reset;
                }
            }
        } else if (self.state == .reset) {
            // TODO: add reset condition
            if (false) {
                self.frame_count = 0;
                self.letter_count = 0;
                self.top_side_rect_width = 16;
                self.left_side_rect_height = 16;
                self.bottom_side_rect_width = 16;
                self.right_side_rect_height = 16;
                self.alpha = 1.0;
                self.state = .blinking;
            }
        }
    }

    pub fn draw(self: Self) void {
        if (self.state == .blinking) {
            if (@mod(@divTrunc(self.frame_count, 15), 2) >= 1) {
                rl.drawRectangle(self.x, self.y, 16, 16, outline_color);
            }
        } else if (self.state == .top_left_grow) {
            rl.drawRectangle(self.x, self.y, self.top_side_rect_width, 16, outline_color);
            rl.drawRectangle(self.x, self.y, 16, self.left_side_rect_height, outline_color);
        } else if (self.state == LogoState.bottom_right_grow) {
            rl.drawRectangle(self.x, self.y, self.top_side_rect_width, 16, outline_color);
            rl.drawRectangle(self.x, self.y, 16, self.left_side_rect_height, outline_color);

            rl.drawRectangle(self.x + 240, self.y, 16, self.right_side_rect_height, outline_color);
            rl.drawRectangle(self.x, self.y + 240, self.bottom_side_rect_width, 16, outline_color);
        } else if (self.state == .letters_appearing) {
            rl.drawRectangle(self.x, self.y, self.top_side_rect_width, 16, rl.fade(outline_color, self.alpha));
            rl.drawRectangle(self.x, self.y + 16, 16, self.left_side_rect_height - 32, rl.fade(outline_color, self.alpha));

            rl.drawRectangle(self.x + 240, self.y + 16, 16, self.right_side_rect_height - 32, rl.fade(outline_color, self.alpha));
            rl.drawRectangle(self.x, self.y + 240, self.bottom_side_rect_width, 16, rl.fade(outline_color, self.alpha));

            //rl.drawRectangle(@divTrunc(rl.getScreenWidth(), 2) - 112, @divTrunc(rl.getScreenHeight(), 2) - 112, 224, 224, rl.fade(background_color, self.alpha));

            rl.drawText(rl.textSubtext("raylib", 0, self.letter_count), @divTrunc(rl.getScreenWidth(), 2) - 44, @divTrunc(rl.getScreenHeight(), 2) + 48, 50, rl.fade(outline_color, self.alpha));
        }
    }

    pub fn isDone(self: Self) bool {
        return self.state == .reset;
    }
};
