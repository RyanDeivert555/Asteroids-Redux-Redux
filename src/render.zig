const rl = @import("raylib");
const Transform = @import("transform.zig").Transform;

pub const Render = struct {
    shape: Transform,
    color: rl.Color,
    texture: ?rl.Texture2D,

    const Self = @This();

    pub fn init(shape: Transform, color: rl.Color, texture: ?rl.Texture2D) Self {
        return Self{
            .shape = shape,
            .color = color,
            .texture = texture,
        };
    }

    pub fn drawTexture(self: Self, position: rl.Vector2) void {
        const texture = self.texture.?;
        const width = @as(f32, @floatFromInt(texture.width));
        const height = @as(f32, @floatFromInt(texture.height));
        const scaled_width = self.shape.scale.x * width;
        const scaled_height = self.shape.scale.y * height;
        const x = position.x;
        const y = position.y;
        const origin = self.shape.origin;
        const rotation = self.shape.rotation;

        const src_rect = rl.Rectangle.init(0.0, 0.0, width, height);
        const dest_rect = rl.Rectangle.init(x, y, scaled_width, scaled_height);

        rl.drawTexturePro(texture, src_rect, dest_rect, origin, rotation, self.color);
    }

    pub fn draw(self: Self, position: rl.Vector2, size: rl.Vector2) void {
        const width = size.x;
        const height = size.y;
        const scaled_width = self.shape.scale.x * width;
        const scaled_height = self.shape.scale.y * height;
        const x = position.x;
        const y = position.y;
        const origin = self.shape.origin;
        const rotation = self.shape.rotation;

        const rect = rl.Rectangle.init(x, y, scaled_width, scaled_height);

        rl.drawRectanglePro(rect, origin, rotation, self.color);
    }
};
