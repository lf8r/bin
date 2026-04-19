#!/usr/bin/env python3
"""
Generate a desktop wallpaper PNG with hostname centered in large font.

Save this as, e.g., `make_hostname_wallpaper.py` and run:
    python3 make_hostname_wallpaper.py
"""

import os
import socket
from PIL import Image, ImageDraw, ImageFont

# --- Config
WIDTH, HEIGHT = 1920, 1080
BG_COLOR = (18, 24, 38)        # dark background
TEXT_COLOR = (245, 245, 245)   # light text
TEXT_SHADOW = (0, 0, 0)        # subtle drop‑shadow
FONT_SIZES = {"main": 120, "small": 42}
OUTPUT_PATH = os.path.expanduser("~/Pictures/hostname_wallpaper.png")
# ---


def get_hostname():
    return socket.gethostname()


def get_font(size):
    # Try a few common fonts; fallback to default if not found.
    font_paths = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf",
    ]
    for path in font_paths:
        if os.path.exists(path):
            return ImageFont.truetype(path, size)
    # Fallback: default font (smaller sizes)
    return ImageFont.truetype(None, size)


def main():
    hostname = get_hostname()

    img = Image.new("RGB", (WIDTH, HEIGHT), BG_COLOR)
    draw = ImageDraw.Draw(img)

    # Main hostname text
    font = get_font(FONT_SIZES["main"])
    bbox = draw.textbbox((0, 0), hostname, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    x = (WIDTH - text_w) // 2
    y = (HEIGHT - text_h) // 2 - 40

    # Optional soft shadow
    for dx, dy in [(4, 4), (3, 3), (2, 2)]:
        draw.text((x + dx, y + dy), hostname, font=font, fill=TEXT_SHADOW)

    # Actual text
    draw.text((x, y), hostname, font=font, fill=TEXT_COLOR)

    # Sublabel (optional)
    sub = os.getenv("HOSTIP", "")
    small_font = get_font(FONT_SIZES["small"])
    bbox_sub = draw.textbbox((0, 0), sub, font=small_font)
    sw, sh = bbox_sub[2] - bbox_sub[0], bbox_sub[3] - bbox_sub[1]
    draw.text(
        ((WIDTH - sw) // 2, y + text_h + 20),
        sub,
        font=small_font,
        fill=(180, 190, 210),  # muted light color
    )

    # Ensure output directory exists
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    img.save(OUTPUT_PATH)
    print(f"Generated: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
