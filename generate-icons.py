#!/usr/bin/env python3
"""
Generate PWA icons for Game Night app
Requires: PIL/Pillow
Install with: pip install pillow
"""

import os
from PIL import Image, ImageDraw, ImageFont

def create_icon(size, filename, is_maskable=False):
    """Create a PWA icon of specified size"""
    
    # Create new image with dark background
    img = Image.new('RGB', (size, size), color=(11, 8, 6))  # Dark brown
    draw = ImageDraw.Draw(img)
    
    # Draw outer circle with gold color
    gold = (200, 146, 42)
    border = 20
    draw.ellipse([border, border, size-border, size-border], fill=gold, outline=gold)
    
    # Draw inner circle with cream color
    cream = (253, 246, 236)
    inner_border = 40
    draw.ellipse([inner_border, inner_border, size-inner_border, size-inner_border], 
                 fill=cream, outline=cream)
    
    # Draw center circle with gold
    center_radius = size // 4
    center = size // 2
    draw.ellipse([center - center_radius, center - center_radius, 
                  center + center_radius, center + center_radius], 
                 fill=gold, outline=gold)
    
    # Draw "G" in center (using text)
    try:
        # Try to use a nice font if available
        font_size = int(size * 0.4)
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", font_size)
    except:
        # Fallback to default font
        font = ImageFont.load_default()
    
    # Draw G in cream color
    draw.text((size//2, size//2), "G", font=font, fill=cream, anchor="mm")
    
    # Save the image
    img.save(filename, 'PNG')
    print(f"✓ Created {filename} ({size}x{size})")
    
    # Save RGBA version if maskable
    if is_maskable:
        img_rgba = img.convert('RGBA')
        img_rgba.save(filename.replace('.png', '-maskable.png'), 'PNG')
        print(f"✓ Created {filename.replace('.png', '-maskable.png')} ({size}x{size})")

def main():
    print("🎭 Generating PWA icons for Game Night...")
    print()
    
    try:
        # Generate icons at different sizes
        sizes = [96, 192, 512]
        
        for size in sizes:
            create_icon(size, f'icon-{size}.png', is_maskable=(size in [192, 512]))
        
        print()
        print("✅ Icon generation complete!")
        print()
        print("Icons created:")
        print("  • icon-96.png")
        print("  • icon-192.png")
        print("  • icon-192-maskable.png")
        print("  • icon-512.png")
        print("  • icon-512-maskable.png")
        print()
        print("Next steps:")
        print("1. Ensure these icons are served from your web root")
        print("2. Test the PWA locally")
        print("3. On mobile: Open in browser → Menu → Install app")
        print()
        
    except ImportError:
        print("❌ Error: PIL/Pillow is not installed")
        print("Install with: pip install pillow")
        print()
        print("Alternatively, you can:")
        print("1. Use an online PNG generator")
        print("2. Use ImageMagick: apt-get install imagemagick")
        print("3. Create icons manually in your design tool")

if __name__ == '__main__':
    main()
