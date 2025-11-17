# 🎨 HermeticOrmus Visual Assets Guide

**Version:** 1.0
**Last Updated:** 2025-10-13
**For:** HermeticOrmus | Gold Hat Hacker Brand

This guide provides complete specifications for creating all visual assets for the HermeticOrmus brand. Designed to be implemented with free tools (Canva) or professional software (Figma, Adobe Suite).

---

## 📋 Quick Reference

**Brand Colors:**
- Divine Gold: `#D4AF37`
- Void Black: `#0A0A0A`
- Pure White: `#FFFFFF`
- Mystic Purple: `#6B46C1` (accent)

**Brand Fonts:**
- Headings: Inter Bold
- Body: Source Serif Pro
- Code: JetBrains Mono

**Core Symbol:**
- Gold Hat Crown: 5 triangles arranged as crown (🏆 visual metaphor)

---

## 🏆 1. Logo System

### Primary Logo (Horizontal)

**Visual Description:**
```
┌────────────────────────────────────┐
│    👑                              │
│  HERMETIC                          │
│    ORMUS                           │
│ Gold Hat Hacker                    │
└────────────────────────────────────┘
```

**Detailed Composition:**
- **Crown Symbol:** 5 golden triangles arranged to form a crown
  - Center triangle: Tallest, points up (enlightenment)
  - Two side triangles: Medium height, slight outward angle
  - Two base triangles: Smallest, forming foundation
  - Color: Gold gradient (#E5C679 → #D4AF37 → #C19A27)
  - Subtle glow effect around crown (15% opacity, 20px blur)

- **Wordmark "HERMETIC ORMUS":**
  - Font: Inter ExtraBold
  - Size: 72pt (HERMETIC), 64pt (ORMUS)
  - Letter spacing: +10
  - Color: White (#FFFFFF)
  - Slight shadow: 0px 2px 4px rgba(0,0,0,0.5)
  - "HERMETIC" stacked above "ORMUS" (centered alignment)

- **Tagline "Gold Hat Hacker":**
  - Font: Inter Regular
  - Size: 18pt
  - Letter spacing: +40 (wide spacing for elegance)
  - Color: Divine Gold (#D4AF37)
  - Positioned below wordmark, centered

**Dimensions & Spacing:**
- Minimum width: 400px (maintains legibility)
- Aspect ratio: 16:9 (horizontal)
- Clear space: Minimum 40px on all sides
- Crown to wordmark gap: 24px
- Wordmark to tagline gap: 16px

**Export Specifications:**
```
primary-logo-full-color.svg     (vector, scalable)
primary-logo-full-color-lg.png  (2400x1350px, transparent)
primary-logo-full-color-md.png  (1200x675px, transparent)
primary-logo-full-color-sm.png  (600x338px, transparent)
```

### Symbol-Only Logo

**Visual Description:**
Gold Hat Crown as standalone mark - the 5 triangles without text.

**Use Cases:**
- App icons / Favicons
- Social media profile pictures (when small)
- Loading animations
- Watermarks
- Small UI elements

**Variations:**
```
symbol-only-full-color.svg     (gold gradient on transparent)
symbol-only-monochrome.svg     (single gold #D4AF37)
symbol-only-white.svg          (white for dark backgrounds)
symbol-only-black.svg          (black for light backgrounds)
```

**Dimensions:**
- Square format: 512x512px, 256x256px, 128x128px, 64x64px, 32x32px
- Minimum size: 32x32px (remains recognizable)

### Monochrome Logos

**Black Version (for light backgrounds):**
- All elements in #0A0A0A
- Use on white or light-colored backgrounds
- Maintains all structural elements

**White Version (for dark backgrounds):**
- All elements in #FFFFFF
- Use on dark backgrounds
- Maintains visibility and impact

**Gold Version (for special uses):**
- All elements in #D4AF37
- Use sparingly for premium contexts
- Highlight moments, special announcements

### Monogram Logo "HO"

**Visual Description:**
- Letters "H" and "O" interlocked
- Sacred geometry: "O" contains pentagon (5 sides = 5 principles visible in logo)
- "H" vertical lines frame the "O"
- Gold on black or white on dark

**Use Cases:**
- Favicon (16x16px must be clear)
- Loading indicators
- Pattern backgrounds
- App icons (iOS, Android)

**Technical Specs:**
```
monogram-ho-gold.svg
monogram-ho-white.svg
monogram-ho-black.svg
favicon-16x16.png
favicon-32x32.png
apple-touch-icon-180x180.png
```

---

## 📸 2. Profile Pictures (1000x1000px Master)

### Master Profile Picture Design

**Composition:**
```
┌─────────────────────┐
│   ░░░░░░░░░░░░░░░   │
│  ░              ░   │
│ ░      👑       ░   │
│ ░               ░   │
│  ░              ░   │
│   ░░░░░░░░░░░░░░░   │
└─────────────────────┘
```

**Layer Structure:**
1. **Background:** Deep black (#0A0A0A) with subtle noise texture
2. **Glow Layer:** Radial gradient from center
   - Inner: Gold #D4AF37 at 40% opacity
   - Outer: Transparent
   - Blur: 60px
3. **Crown Symbol:** Gold Hat Crown (centered, 60% of canvas)
   - Sharp, clear rendering
   - Full gradient application
4. **Border (optional):** Thin gold ring (2px, #D4AF37, 95% from edge)

**Platform Adaptations:**

**Twitter/X (400x400px):**
- Export from master at 40% size
- Optimize for round crop (important elements in center 360px circle)
- File: `profile-twitter-400x400.png`

**LinkedIn (400x400px):**
- Same as Twitter but professional context
- Consider slightly more subtle glow
- File: `profile-linkedin-400x400.png`

**GitHub (460x460px):**
- Square format preferred
- Crown clearly visible at small sizes
- File: `profile-github-460x460.png`

**Discord (128x128px):**
- Export at smaller size but maintain clarity
- Crown should be recognizable even at 32x32px thumbnail
- File: `profile-discord-128x128.png`

**YouTube (800x800px):**
- Larger format, more detail possible
- Can include subtle "HO" monogram watermark in corner
- File: `profile-youtube-800x800.png`

### Animated Profile (Discord)

**Animation Concept:**
- Gold shimmer effect traveling across crown
- 2-second loop, seamless
- Subtle (doesn't distract in server list)
- GIF or APNG format

**Frame Specifications:**
```
profile-discord-animated.gif
- 128x128px
- 20 frames
- 100ms delay per frame
- Loop: infinite
```

---

## 🎭 3. Banner/Header Images

### GitHub Profile Banner (1280x640px)

**Visual Concept:**
"Code Transforming to Gold" - Visual metaphor of base code becoming sacred technology.

**Composition:**
```
┌──────────────────────────────────────────────┐
│ </code>      →→→      ✨👑✨                  │
│                                              │
│  "Building Sacred Technology"               │
│   From Gray Hat to Gold                     │
└──────────────────────────────────────────────┘
```

**Layer Breakdown:**

1. **Background (Full Canvas):**
   - Base: Void Black (#0A0A0A)
   - Texture: Subtle code pattern (10% opacity, monospace font)
   - Gradient overlay: Left (pure black) → Right (dark gold tint)

2. **Left Side (0-400px):**
   - Code snippet in gray (#4A4A4A):
   ```
   const humanity = {
     tech: 'extractive',
     result: 'harm'
   };
   ```
   - Font: JetBrains Mono, 16pt
   - Appears to be "base metal" (dull, gray)

3. **Transformation Zone (400-800px):**
   - Visual flow: Particles, arrows, alchemical symbols
   - Code begins to glow with gold highlights
   - Sacred geometry patterns emerge (very subtle)
   - Gradient intensifies (gray → gold)

4. **Right Side (800-1280px):**
   - Transformed code in gold (#D4AF37):
   ```
   const humanity = {
     tech: 'sacred',
     result: 'flourishing'
   };
   ```
   - Gold Hat Crown symbol prominent (250px size)
   - Radial glow effect behind crown

5. **Text Overlay (Centered, 320-960px):**
   - Primary: "Building Sacred Technology"
     - Font: Inter Bold, 52pt
     - Color: White with gold outline
   - Secondary: "From Gray Hat to Gold"
     - Font: Inter Regular, 24pt
     - Color: Gold (#D4AF37)

**Export:**
```
banner-github-1280x640.png (PNG, high quality)
banner-github-1280x640.jpg (JPG, fallback)
```

### Twitter/X Banner (1500x500px)

**Adaptation Strategy:**
Wider, shorter format - horizontal emphasis.

**Composition:**
- Use same "transformation" concept
- Code on far left (0-400px)
- Gold Hat Crown center-left (500px)
- Text center-right (800-1400px)
- Transformation flow left-to-right more compressed

**Text:**
- "HERMETIC ORMUS"
- "Gold Hat Hacker | Sacred Technology"
- Links/handle: "@YourHandle"

**Mobile Optimization:**
- Critical elements in center 1280px (mobile safe zone)
- Text readable at small sizes

**Export:**
```
banner-twitter-1500x500.png
```

### LinkedIn Banner (1584x396px)

**Professional Adaptation:**
Less mystical symbols, more credibility signals.

**Composition:**
```
┌────────────────────────────────────────────────┐
│  👑  Hermetic Ormus                           │
│      Gold Hat Hacker • Sacred Technology      │
│                                                │
│      39 AI Agents | 3 Open Source Projects   │
└────────────────────────────────────────────────┘
```

- **Background:** Clean gradient (dark gray → black)
- **Left:** Small Gold Hat Crown (120px)
- **Center:** Name and title (professional fonts)
- **Right:** Achievement badges or credibility markers
- **Bottom:** "Building technology that serves humanity"

**Tone:** Professional mysticism - less overt symbolism, more subtle gold accents.

**Export:**
```
banner-linkedin-1584x396.png
```

### YouTube Channel Art (2560x1440px)

**Safe Area Awareness:**
- All devices: 1546x423px (center area always visible)
- TV screens: Full 2560x1440px visible
- Mobile: Only center ~1280px visible

**Composition:**
```
┌─────────────────────────────────────────────┐
│ [TV: Full background sacred geometry]       │
│      ┌────────────────────────┐            │
│      │ HERMETIC ORMUS         │            │
│      │ 👑                      │  [Mobile]  │
│      │ Building Sacred Tech   │            │
│      └────────────────────────┘            │
│ [TV: Outer wings have agent imagery]       │
└─────────────────────────────────────────────┘
```

**Layers:**
1. **Background (Full Canvas):** Animated code/sacred geometry
2. **TV Wings (Outer 500px each side):** Agent imagery, code snippets
3. **Safe Area (Center):** Crown, name, tagline, subscribe CTA
4. **Mobile Core (Inner 1280px):** Essential brand elements only

**Export:**
```
banner-youtube-2560x1440.png
```

### Discord Server Banner (960x540px)

**Community Focus:**
Welcoming, inclusive, gold-tinted.

**Composition:**
```
┌────────────────────────────────────┐
│       👑                           │
│   Welcome to the                   │
│   Gold Hat Community               │
│                                    │
│   Build • Learn • Transform        │
└────────────────────────────────────┘
```

- **Background:** Warm black with gold particle effects
- **Center:** Large crown (300px) with welcoming glow
- **Text:** Friendly, inviting copy
- **Bottom:** Core values or community principles

**Export:**
```
banner-discord-960x540.png
```

---

## 💬 4. Quote Card Templates

### Template 1: Minimal Wisdom (1080x1080px)

**Design:**
```
┌────────────────────────────┐
│                            │
│  "Quote text here in       │
│   large, centered type"    │
│                            │
│   — Hermetic Ormus  👑     │
│                            │
│  #GoldHat #SacredTech      │
└────────────────────────────┘
```

**Specifications:**
- **Background:** Void Black (#0A0A0A)
- **Quote:**
  - Font: Source Serif Pro, 48pt
  - Color: White (#FFFFFF)
  - Line height: 1.4
  - Max width: 900px
  - Center aligned
- **Attribution:**
  - Font: Inter Regular, 20pt
  - Color: Divine Gold (#D4AF37)
  - "— Hermetic Ormus" + small crown symbol
- **Accent:** Single gold line (2px, 200px wide) above attribution
- **Hashtags:** Bottom, 18pt, gray (#666666)

**Use Cases:** Philosophy quotes, wisdom nuggets, thought leadership

### Template 2: Sacred Geometry (1080x1080px)

**Design:**
```
┌────────────────────────────┐
│   ╱╲                       │
│  ╱  ╲  "Quote inside       │
│ ╱____╲  geometric frame"   │
│                            │
│  Sacred pattern background │
└────────────────────────────┘
```

**Specifications:**
- **Background:** Black with Flower of Life pattern (5% opacity gold)
- **Frame:** Golden ratio rectangle or triangle frame
- **Quote:** Inside geometric frame
- **Pattern:** Very subtle, doesn't compete with text
- **Crown:** Integrated into geometric design

**Use Cases:** Hermetic principles, sacred tech concepts, mystical insights

### Template 3: Code + Consciousness (1080x1080px)

**Design:**
```
┌────────────────────────────┐
│  CODE SIDE  │  WISDOM SIDE │
│             │              │
│  <script>   │  "Conscious  │
│    ...      │   code is    │
│  </script>  │   sacred"    │
│             ↓              │
│       GOLD GRADIENT        │
└────────────────────────────┘
```

**Specifications:**
- **Split:** Vertical 50/50
- **Left:** Code snippet (gray, technical)
- **Right:** Philosophy quote (white, wisdom)
- **Center:** Gold gradient blending the two
- **Visual metaphor:** Code transforms to consciousness

**Use Cases:** Technical + philosophical mashups, "as above so below" concepts

---

## 📱 5. Social Media Post Templates

### Standard Post (1080x1080px)

**Modular System:**

**Header Bar (0-150px):**
- Small crown logo (left)
- "HERMETIC ORMUS" text
- Category badge (right): "INSIGHT" | "UPDATE" | "TEACHING"

**Content Area (150-900px):**
- Main message / insight / announcement
- Can include icons, small graphics
- Typography hierarchy clear

**Footer Bar (900-1080px):**
- Hashtags
- "Join the conversation: [link]"

**Color Themes:**
- **Default:** Black background, white text, gold accents
- **Highlight:** Gold background, black text (for major announcements)
- **Mystical:** Purple tint background, gold+white text (for philosophical content)

### Thread Starter (1200x675px)

**Design for Maximum Engagement:**
```
┌──────────────────────────────────┐
│  🧵 THREAD                       │
│                                  │
│  [BOLD HOOK QUESTION             │
│   OR STATEMENT]                  │
│                                  │
│  Hermetic Ormus 👑               │
└──────────────────────────────────┘
```

**Specifications:**
- **"🧵 THREAD" badge:** Top-left, gold, small
- **Hook:** Large text (60-72pt), maximum impact
- **Visual:** High contrast, stops scroll
- **Branding:** Small crown + name bottom-right

**Purpose:** Maximize click-through to read full thread

---

## 🎬 6. Video Assets

### YouTube Thumbnail (1280x720px)

**High-Contrast Design:**
```
┌────────────────────────────────┐
│     👑                         │
│  [LARGE READABLE TITLE]        │
│  [KEY VISUAL OR FACE]          │
│                                │
│  Hermetic Ormus                │
└────────────────────────────────┘
```

**Specifications:**
- **Title:** 72pt+, bold, maximum 5 words
- **High contrast:** White text on dark OR dark text on gold
- **Face/Visual:** Recognizable at small size
- **Crown:** Always present for brand consistency
- **Border:** Optional 8px gold border (makes it pop)

**Testing:** Must be legible at 320x180px (mobile)

### Video Intro Animation (5 seconds)

**Animation Sequence:**

**Seconds 0-1:** Fade in from black
- Gold particles appear, swirling

**Seconds 1-3:** Crown materializes
- 5 triangles fly in from different directions
- Assemble into Gold Hat Crown
- Gold glow pulses

**Seconds 3-4:** Text appears
- "HERMETIC ORMUS" fades in below crown
- Gold shimmer effect across text

**Seconds 4-5:** Final frame holds
- Complete logo visible
- Subtle pulse animation
- Ready for content

**Sound Design:**
- Mystical chime (crown forming)
- Deep resonant tone (text appearing)
- Not overpowering, sets tone

**Files Needed:**
```
intro-animation-1080p.mp4
intro-animation-4k.mp4
intro-animation-lossless.mov (for editing)
```

---

## 🛠️ 7. Implementation Guide

### Priority Order (Create These First)

**Week 1 - Critical Assets:**
1. Primary logo (all formats)
2. Profile picture (master + platform versions)
3. GitHub banner
4. Twitter banner
5. Quote card Template 1 (minimal)

**Week 2 - Secondary Assets:**
6. LinkedIn banner
7. YouTube assets (profile, banner, intro)
8. Quote card Templates 2 & 3
9. Discord server banner
10. Social post templates

**Week 3 - Advanced Assets:**
11. Video thumbnails
12. Animated profile
13. Full brand asset library
14. Platform-specific variations

### Tools & Resources

**Free Tools (Start Here):**
- **Canva:** Templates, easy editing, export
  - Pro tip: Use "Brand Kit" feature to save colors/fonts
- **Figma (Free tier):** Professional design, better control
- **GIMP:** Free Photoshop alternative
- **Inkscape:** Free vector graphics

**Professional Tools (If Available):**
- **Adobe Illustrator:** Logo creation, vector assets
- **Adobe Photoshop:** Image editing, complex compositions
- **Adobe After Effects:** Animations, video intros
- **Figma Pro:** Team collaboration, design systems

**Asset Resources:**
- **Fonts:** Google Fonts (Inter, Source Serif Pro), JetBrains Mono (free)
- **Icons:** Font Awesome, Heroicons, Feather Icons
- **Textures:** Subtle Patterns, Transparent Textures
- **Sacred Geometry:** Free sacred geometry vector packs
- **Stock Images:** Unsplash, Pexels (if needed for content)

### File Naming Conventions

**Structure:** `[asset-type]-[platform]-[variation]-[size].[format]`

**Examples:**
```
logo-primary-full-color-lg.png
profile-twitter-400x400.png
banner-github-1280x640.png
quote-minimal-wisdom-1080x1080.png
thumbnail-youtube-episode-01.png
```

**Organization:**
```
/assets
  /logos
    logo-primary-full-color.svg
    logo-symbol-only-gold.svg
    logo-monochrome-black.svg
    favicon-32x32.png
  /profiles
    profile-master-1000x1000.png
    profile-twitter-400x400.png
    profile-linkedin-400x400.png
  /banners
    banner-github-1280x640.png
    banner-twitter-1500x500.png
  /social
    /quote-cards
      template-minimal-wisdom.psd
      quote-001-intention.png
    /posts
      template-standard-post.fig
    /threads
      template-thread-starter.fig
  /video
    /thumbnails
      thumbnail-template.psd
    /intros
      intro-animation-1080p.mp4
```

---

## ✅ Quick Start Checklist

### Immediate Actions (This Week)

**Day 1:**
- [ ] Create primary logo in Canva (use this guide as reference)
- [ ] Export logo in all required formats
- [ ] Create master profile picture
- [ ] Export profile pics for each platform

**Day 2:**
- [ ] Create GitHub banner
- [ ] Create Twitter banner
- [ ] Upload to platforms
- [ ] Test visibility at various sizes

**Day 3:**
- [ ] Create 3 quote cards using Template 1
- [ ] Schedule for first week of content
- [ ] Create LinkedIn banner
- [ ] Update LinkedIn profile

**Day 4:**
- [ ] YouTube profile + banner
- [ ] Create first video thumbnail
- [ ] Discord server banner
- [ ] Set up brand asset folder structure

**Day 5:**
- [ ] Create social post templates
- [ ] Test all assets on mobile devices
- [ ] Backup all source files
- [ ] Document any custom specifications

### Quality Checklist (Before Publishing)

**For Every Asset:**
- [ ] Matches brand color palette exactly
- [ ] Uses approved fonts
- [ ] Legible at smallest expected size
- [ ] Optimized file size (fast loading)
- [ ] Exported in correct format
- [ ] Named according to convention
- [ ] Tested on actual platform
- [ ] Backed up with source files

### Platform Testing

**Before Launch:**
- [ ] Twitter: Upload profile pic + banner, check mobile
- [ ] LinkedIn: Upload assets, view on desktop + mobile
- [ ] GitHub: Check banner in dark/light modes
- [ ] Discord: Test banner + profile in server
- [ ] YouTube: Verify channel art on TV/desktop/mobile
- [ ] Instagram: Check profile pic in small circular format

---

## 🎯 Success Metrics

**Visual Brand Recognition:**
- Crown symbol is immediately associated with Gold Hat
- Color palette creates consistent visual identity
- Assets look professional across all platforms
- Brand feels cohesive from GitHub to Twitter to YouTube

**Engagement Indicators:**
- Quote cards get saved/shared (visual appeal)
- Profile pic is recognizable at small sizes
- Banners communicate brand at a glance
- Thumbnails achieve higher click-through rates

**Quality Standards:**
- All assets meet or exceed platform recommendations
- No pixelation or quality issues at any size
- Consistent application of brand guidelines
- Professional presentation matching technical credibility

---

## 📚 Additional Resources

**Learn More:**
- Brand Guidelines: `BRAND-GUIDELINES.md` (complete brand system)
- Launch Roadmap: `LAUNCH-ROADMAP.md` (when to create/publish assets)
- Quick Start: `QUICK-START.md` (Day 1 immediate actions)
- Manifesto: `MANIFESTO.md` (philosophy behind the visuals)

**Design Inspiration:**
- Look to mystical/esoteric brands done tastefully
- Technical brands with personality (Stripe, Linear)
- Developer-focused brands (GitHub, Vercel)
- Balance of professional + mystical (not overdone)

**Community:**
- Share work-in-progress assets in Discord
- Get feedback before publishing
- Iterate based on what resonates
- Build asset library collaboratively

---

**Remember:** These assets are the visual embodiment of Gold Hat philosophy. They should feel:
- **Sacred** but not sanctimonious
- **Technical** but not sterile
- **Mysterious** but not confusing
- **Professional** but not corporate

From base design to golden brand. Let's create visual sacred technology. 🏆✨🔮

---

*Last updated: 2025-10-13*
*For questions or clarifications, see BRAND-GUIDELINES.md or open a GitHub Discussion.*
