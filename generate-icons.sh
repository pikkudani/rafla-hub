#!/bin/bash
# PWA Icon Generation Script for Game Night App

echo "🎭 Generating PWA icons for Game Night..."

# Create a temporary SVG icon
cat > /tmp/game-night-icon.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <!-- Background -->
  <rect width="512" height="512" fill="#0b0806"/>
  
  <!-- Outer circle -->
  <circle cx="256" cy="256" r="240" fill="#c8922a" opacity="0.9"/>
  
  <!-- Inner circle -->
  <circle cx="256" cy="256" r="200" fill="#fdf6ec"/>
  
  <!-- Main game icons -->
  <!-- Mask for Charades -->
  <text x="140" y="180" font-size="80" text-anchor="middle" dominant-baseline="middle">🎭</text>
  
  <!-- Beer mug for drinks -->
  <text x="372" y="180" font-size="80" text-anchor="middle" dominant-baseline="middle">🍺</text>
  
  <!-- Chef hat -->
  <text x="140" y="360" font-size="80" text-anchor="middle" dominant-baseline="middle">👨‍🍳</text>
  
  <!-- Plate for service -->
  <text x="372" y="360" font-size="80" text-anchor="middle" dominant-baseline="middle">🍽</text>
  
  <!-- Center circle with G -->
  <circle cx="256" cy="256" r="60" fill="#c8922a"/>
  <text x="256" y="270" font-size="70" font-weight="bold" text-anchor="middle" fill="#fdf6ec" font-family="Playfair Display, serif">G</text>
</svg>
EOF

# Function to convert SVG to PNG
convert_to_png() {
  local size=$1
  local input=$2
  local output=$3
  
  if command -v convert &> /dev/null; then
    convert -background none -size ${size}x${size} "$input" -resize ${size}x${size} "$output"
    echo "✓ Created $output ($size x $size)"
  else
    echo "⚠ ImageMagick not found. Install with: sudo apt-get install imagemagick"
    return 1
  fi
}

# Convert to different sizes
convert_to_png 192 /tmp/game-night-icon.svg "icon-192.png" || {
  echo "Note: Install ImageMagick to generate icons: sudo apt-get install imagemagick"
  echo "For now, you can use this SVG directly or use an online converter."
  exit 1
}

convert_to_png 192 /tmp/game-night-icon.svg "icon-192-maskable.png"
convert_to_png 512 /tmp/game-night-icon.svg "icon-512.png"
convert_to_png 512 /tmp/game-night-icon.svg "icon-512-maskable.png"
convert_to_png 96 /tmp/game-night-icon.svg "icon-96.png"

# Create simple screenshots
echo "✓ Icon generation complete!"
echo ""
echo "📸 Creating placeholder screenshots..."

# Create a simple screenshot placeholder
convert -size 540x720 xc:"#0b0806" \
  -fill "#c8922a" -pointsize 40 -draw "text 50,100 'Game Night'" \
  -fill "#fdf6ec" -pointsize 20 -draw "text 50,200 'Restaurant Party Games'" \
  "screenshot-1.png" 2>/dev/null && echo "✓ Created screenshot-1.png" || echo "ℹ Skipped screenshot creation"

# Clean up
rm /tmp/game-night-icon.svg

echo ""
echo "✅ PWA setup complete!"
echo ""
echo "Next steps:"
echo "1. Test your PWA locally"
echo "2. On mobile: Open in browser → Menu → Install app"
echo "3. On desktop: Install prompt will appear"
echo ""
echo "Features enabled:"
echo "✓ Offline support (cached assets)"
echo "✓ Installable as app"
echo "✓ App icons and splash screens"
echo "✓ Standalone display mode"
echo "✓ Theme color in status bar"
