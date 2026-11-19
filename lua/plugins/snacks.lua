-- Inline images (PNG/JPG/WebP/GIF first frame) via the kitty graphics protocol (Ghostty supports it).
-- Opening an image file shows it in the buffer; needs ImageMagick (`magick`) for conversion.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
      doc = {
        -- Render images referenced in markdown/html inline only when the cursor is on them.
        inline = false,
        float = true,
      },
    },
  },
}
