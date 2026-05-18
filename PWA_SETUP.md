# Game Night - PWA Setup Guide

Your Game Night app has been converted to a Progressive Web App (PWA)! Here's what's included and how to set it up.

## ✅ What's Been Added

### 1. **PWA Configuration Files**
- `manifest.json` - Web app manifest with app metadata, icons, and shortcuts
- `service-worker.js` - Service worker for offline support and caching

### 2. **HTML Updates**
- Added manifest link
- Added theme-color meta tag
- Added Apple mobile web app meta tags (for iOS support)
- Added service worker registration script

### 3. **Features Enabled**
- ✓ **Installable** - Users can install as native app on home screen
- ✓ **Offline Support** - Works offline with cached content
- ✓ **Standalone Mode** - Runs without browser chrome
- ✓ **Theme Color** - Gold (#c8922a) in status bar
- ✓ **App Shortcuts** - Quick access to specific games
- ✓ **iOS Support** - Works on iPhone/iPad

## 🚀 Setup Instructions

### Step 1: Generate App Icons

You need to create app icons in different sizes. Choose one method:

#### Option A: Python (Recommended)
```bash
# Install Pillow if needed
pip install Pillow

# Generate icons
cd /workspaces/rafla-hub
python3 generate-icons.py
```

This creates:
- `icon-96.png`
- `icon-192.png` + `icon-192-maskable.png`
- `icon-512.png` + `icon-512-maskable.png`

#### Option B: Use ImageMagick
```bash
# Install ImageMagick
sudo apt-get update
sudo apt-get install imagemagick

# Generate icons
cd /workspaces/rafla-hub
bash generate-icons.sh
```

#### Option C: Online Icon Generator
1. Go to https://www.pngmaker.com/ or similar
2. Create a 512×512 PNG with your app design
3. Download and save as `icon-512.png`
4. Create a 192×192 version and save as `icon-192.png`
5. Create a 96×96 version and save as `icon-96.png`

#### Option D: Manual - Create SVG Icons
If you have design tools, create SVG icons and convert them:
- Design your app icon (512×512 recommended)
- Export as PNG at: 96×96, 192×192, 512×512
- Save as: `icon-96.png`, `icon-192.png`, `icon-512.png`

### Step 2: Deploy to HTTPS

PWAs **require HTTPS** (except localhost for testing). If deploying:
- Use a hosting service with HTTPS (Vercel, Netlify, GitHub Pages, etc.)
- Or set up HTTPS on your server
- For local testing: `localhost` or `127.0.0.1` work without HTTPS

### Step 3: Test Locally

```bash
# Start a local HTTP server
python3 -m http.server 8000

# Or use Node.js
npx http-server
```

Then open `http://localhost:8000`

## 📱 Installation Methods

### Mobile (Android)
1. Open your Game Night app in Chrome or Firefox
2. Tap the **menu button** (⋮)
3. Tap **Install app** or **Add to Home Screen**
4. Tap **Install**
5. App appears on your home screen

### Mobile (iOS/iPad)
1. Open your Game Night app in Safari
2. Tap the **Share button** (↗)
3. Scroll and tap **Add to Home Screen**
4. Tap **Add**
5. App appears on your home screen

### Desktop (Chrome/Edge)
1. Open your Game Night app
2. Click the **install icon** in the address bar (or menu → Install)
3. Click **Install**
4. App opens in standalone window

## 🛠️ Customization

### Change App Name/Description
Edit `manifest.json`:
```json
{
  "name": "Your Custom Name",
  "short_name": "Short Name",
  "description": "Your app description"
}
```

### Change Theme Color
Edit `manifest.json` and `index.html`:
```json
// In manifest.json
"theme_color": "#c8922a",
"background_color": "#0b0806"
```

```html
<!-- In index.html head -->
<meta name="theme-color" content="#c8922a">
```

### Add Custom Shortcuts
Edit `manifest.json` shortcuts array:
```json
"shortcuts": [
  {
    "name": "Quick Start Alias",
    "url": "/?game=alias",
    "icons": [{"src": "/icon-96.png", "sizes": "96x96"}]
  }
]
```

### Cache Strategy
Modify `service-worker.js` to change caching behavior:
- Currently: Network-first strategy (checks network, falls back to cache)
- Available: Cache-first, Stale-while-revalidate, etc.

## 🔍 Verify PWA Setup

### Browser DevTools
1. Open DevTools (F12 / Cmd+Option+I)
2. Go to **Application** tab
3. Check **Manifest** - should show your app details
4. Check **Service Workers** - should show registered worker
5. Check **Cache Storage** - should list cached files

### Lighthouse Audit
1. Open DevTools
2. Go to **Lighthouse** tab
3. Run PWA audit
4. Should score high on PWA capabilities

## 📦 What's Cached

The service worker caches:
- `index.html` - Your app shell
- `manifest.json` - App manifest
- Google Fonts - Already cached by browser

## 🔐 Security Notes

- Service worker only serves HTTPS (except localhost)
- All cached content is from your domain only
- No external data is cached by default
- Add `Content-Security-Policy` headers for added security

## 🐛 Troubleshooting

### App not installing?
- Ensure HTTPS is enabled (or testing on localhost)
- Check manifest is valid: http://manifest-validator.appspot.com
- Clear browser cache and service worker: DevTools → Application → Clear

### Service worker not updating?
```javascript
// In browser console:
navigator.serviceWorker.getRegistrations().then(regs => {
  regs.forEach(reg => reg.unregister());
});
```

### Icons not showing?
- Verify icon files are in web root directory
- Check manifest.json paths are correct
- Confirm icons are valid PNG/WebP files
- Clear cache and reinstall

### Offline not working?
- Check Service Workers in DevTools
- Verify cache in DevTools → Application → Cache Storage
- Check browser console for errors
- Ensure service-worker.js is valid

## 📚 Resources

- [MDN PWA Guide](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps)
- [Web.dev PWA Checklist](https://web.dev/pwa-checklist/)
- [Google Workbox](https://developers.google.com/web/tools/workbox) - Advanced caching
- [PWA Builder](https://www.pwabuilder.com) - Generate PWA packages

## 🎉 You're Ready!

Your Game Night app is now a full-featured PWA! Users can:
- Install it like a native app
- Use it offline
- Get it from app store (with packaging)
- Share shortcuts
- Enjoy native app-like experience

---

**Questions?** Check the resources above or test your setup on https://web.dev
