const rl = @import("raylib");
const rlm = @import("raylib-math");
const std = @import("std");
const Allocator = std.mem.Allocator;
const Textures = std.ArrayList(rl.Texture2D);

pub const AssetManager = struct {
    textures: Textures,

    const Self = @This();

    pub fn init(allocator: Allocator) Self {
        return Self{ .textures = Textures.init(allocator) };
    }

    pub fn loadTexture(self: *Self, fileName: [:0]const u8) !usize {
        const texture = rl.loadTexture(fileName);
        try self.textures.append(texture);

        return self.textures.items.len - 1;
    }

    fn getTexture(self: Self, id: usize) rl.Texture2D {
        return self.textures[id];
    }

    pub fn getSize(self: Self, id: usize) rl.Vector2 {
        const texture = self.getTexture(id);
        const width = @as(f32, @floatFromInt(texture.width));
        const height = @as(f32, @floatFromInt(texture.height));

        return rl.Vector2.init(width, height);
    }

    pub fn getCenter(self: Self, id: usize, scale: rl.Vector2) rl.Vector2 {
        const size = self.getSize(id);
        const scaled_size = rlm.vector2Scale(size, scale);
        const center = rlm.vector2Scale(scaled_size, 0.5);

        return center;
    }

    pub fn draw(self: Self, id: usize, position: rl.Vector2, scale: rl.Vector2, rotation: f32, origin: rl.Vector2, tint: rl.Color) void {
        const texture = self.getTexture(id);
        const size = self.getSize(id);
        const width = size.x;
        const height = size.y;

        const src_rect = rl.Rectangle.init(0.0, 0.0, width, height);
        const dest_rect = rl.Rectangle.init(position.x, position.y, width * scale.x, height * scale.y);

        rl.drawTexturePro(texture, src_rect, dest_rect, origin, rotation, tint);
    }

    pub fn unloadTextures(self: Self) void {
        for (self.textures.items) |texture| {
            rl.unloadTexture(texture);
        }
    }
};
