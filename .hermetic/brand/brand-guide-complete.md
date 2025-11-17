# 🏆 Hermetic Ormus Brand Guide
**Complete Visual Identity System • The 9 Realms Made Visible**

---

## Foundation

This Brand Guide builds upon the **[VIBEPACK](./VIBEPACK.md)** aesthetic philosophy and makes it tangible through specific visual identity elements. Refer to the Vibepack for the **why** and **feeling**—this document provides the **what** and **how**.

**Core Identity:**
- **Name:** Hermetic Ormus
- **Tagline:** Holder of the Angelic Gauntlet • Custodian of the Rainbow Tesseract
- **Mission:** Serving humanity through conscious heartfelt technologies
- **Vibe:** Mystical • Powerful • Conscious

---

## I. Logo System

### The 9-Pointed Angelic Gauntlet Crown

**Primary Logo: The Complete Gauntlet**

```
Visual Description:
- 9 triangular points arranged in crown formation
- Each point glows with one of the 9 realm colors (bottom to top):
  1. Red (Angels)
  2. Orange (Archangels)
  3. Yellow (Principalities)
  4. Green (Powers)
  5. Blue (Virtues)
  6. Purple (Dominions)
  7. Violet (Thrones)
  8. Pale Purple (Cherubim)
  9. White-Gold (Seraphim)
- Center contains Rainbow Tesseract (4D cube structure)
- Entire structure unified in gold framework (#D4AF37)
- Base dimension: 512px × 512px
- Safe space: 64px minimum clearance
```

**Construction Grid:**
```
Total height: 512px
Crown base: 128px wide
Point heights: Ascending from 80px (outer) to 140px (center)
Spacing between points: 12px
Tesseract center: 96px × 96px
Gold framework: 4px stroke weight
Realm color glow: 8px blur radius at 60% opacity
```

---

### Logo Variations

#### VARIATION 1: Full Color Gauntlet
**When to use:** Hero sections, main branding, philosophy content
**File formats:** SVG (primary), PNG (fallback), PDF (print)
**Min size:** 256px width (digital), 3 inches (print)
**Background:** Dark (#0A0A0A, #1A1A1A) preferred

**Color specifications:**
- Each of 9 points in respective realm color
- Gold framework at 100% opacity
- Rainbow Tesseract with gradient

---

#### VARIATION 2: Gold Monochrome
**When to use:** Single-color applications, print on light backgrounds
**File formats:** SVG, PNG
**Min size:** 200px width

**Color specifications:**
- All elements in gold (#D4AF37)
- Single color for maximum versatility
- Maintains all structural details

---

#### VARIATION 3: Symbol-Only (No Wordmark)
**When to use:** App icons, favicons, social media avatars
**File formats:** PNG (multiple sizes), ICO (favicon)
**Sizes:**
- 1024px × 1024px (iOS app store)
- 512px × 512px (Android)
- 180px × 180px (Apple touch icon)
- 32px × 32px, 16px × 16px (favicons)

**Simplification at small sizes:**
- Below 64px: Remove tesseract detail, solid gold crown
- Below 32px: Simplified 5-point crown (too complex for 9)

---

#### VARIATION 4: Horizontal Lockup (Logo + Wordmark)
**When to use:** Website headers, email signatures, presentations
**Layout:** Symbol left, wordmark right, 24px spacing
**Proportions:** Symbol height : Wordmark height = 1 : 0.8

**Wordmark specifications:**
- Font: Inter Bold
- Size: Proportional to symbol
- Color: Matches symbol (full color or monochrome)
- Letter-spacing: -2% (slight tightening)

---

#### VARIATION 5: Vertical Lockup (Logo + Wordmark)
**When to use:** Posters, vertical banners, Instagram posts
**Layout:** Symbol top, wordmark bottom, 16px spacing
**Alignment:** Center-aligned

---

#### VARIATION 6: The Rainbow Tesseract (Standalone)
**When to use:** Loading states, meditation visuals, philosophical content
**Animation:** Rotating 4D cube, 6-second loop
**Colors:** Cycling through all 9 realm colors on faces/edges
**Format:** Animated SVG, GIF, or video (MP4/WebM)

**Structure:**
```
4D Tesseract visualization:
- Outer cube: 200px × 200px
- Inner cube: 120px × 120px (scaled)
- Connecting edges between cubes
- Each face glows with realm color
- Gold core at center (24px sphere)
- Rotation: X-axis 360° in 6s, Y-axis 180° in 6s
```

---

### Logo Usage Guidelines

**DO:**
- Use official files from brand asset library
- Maintain minimum safe space (64px clear zone)
- Scale proportionally only (lock aspect ratio)
- Place on appropriate backgrounds (dark preferred)
- Ensure visibility with sufficient contrast

**DON'T:**
- Stretch, skew, or rotate the logo
- Change colors outside approved variations
- Add effects (drop shadows, outlines, etc.)
- Place on busy backgrounds without backdrop
- Use low-resolution versions
- Recreate or modify the logo yourself

**Minimum Sizes:**
- Digital: 200px width (with wordmark), 32px (symbol only)
- Print: 2 inches width (with wordmark), 0.5 inch (symbol)
- Below minimum: Use simplified variation

---

## II. Color System

### Primary Palette: The 9 Angelic Realms

**Complete color specifications with all details:**

#### Realm 1: Angels (Foundation)
```css
/* Primary */
--realm-1-angels: #E63946;
--realm-1-angels-rgb: rgb(230, 57, 70);
--realm-1-angels-hsl: hsl(356, 79%, 56%);

/* Variations */
--realm-1-light: #FF6B75;   /* 20% lighter */
--realm-1-dark: #B82E38;     /* 20% darker */
--realm-1-subtle: rgba(230, 57, 70, 0.1);  /* 10% opacity background */
--realm-1-glow: rgba(230, 57, 70, 0.3);    /* 30% opacity glow */

/* Accessibility */
On #0A0A0A: 5.2:1 contrast (AA pass)
On #FFFFFF: 4.1:1 contrast (AA pass for large text)
```

#### Realm 2: Archangels (Creativity)
```css
/* Primary */
--realm-2-archangels: #FF6B35;
--realm-2-archangels-rgb: rgb(255, 107, 53);
--realm-2-archangels-hsl: hsl(16, 100%, 60%);

/* Variations */
--realm-2-light: #FF9668;
--realm-2-dark: #CC5629;
--realm-2-subtle: rgba(255, 107, 53, 0.1);
--realm-2-glow: rgba(255, 107, 53, 0.3);

/* Accessibility */
On #0A0A0A: 6.1:1 contrast (AA pass)
On #FFFFFF: 3.5:1 contrast (AA pass for large text)
```

#### Realm 3: Principalities (Power)
```css
/* Primary */
--realm-3-principalities: #FFD93D;
--realm-3-principalities-rgb: rgb(255, 217, 61);
--realm-3-principalities-hsl: hsl(48, 100%, 62%);

/* Variations */
--realm-3-light: #FFEB8C;
--realm-3-dark: #CCAE31;
--realm-3-subtle: rgba(255, 217, 61, 0.1);
--realm-3-glow: rgba(255, 217, 61, 0.3);

/* Accessibility */
On #0A0A0A: 12.3:1 contrast (AAA pass)
On #FFFFFF: 1.7:1 contrast (Fail - use dark background only)
```

#### Realm 4: Powers (Compassion)
```css
/* Primary */
--realm-4-powers: #10B981;
--realm-4-powers-rgb: rgb(16, 185, 129);
--realm-4-powers-hsl: hsl(160, 84%, 39%);

/* Variations */
--realm-4-light: #34D399;
--realm-4-dark: #059669;
--realm-4-subtle: rgba(16, 185, 129, 0.1);
--realm-4-glow: rgba(16, 185, 129, 0.3);

/* Accessibility */
On #0A0A0A: 7.8:1 contrast (AAA pass)
On #FFFFFF: 2.7:1 contrast (Fail - use dark background only)
```

#### Realm 5: Virtues (Truth)
```css
/* Primary */
--realm-5-virtues: #4CC9F0;
--realm-5-virtues-rgb: rgb(76, 201, 240);
--realm-5-virtues-hsl: hsl(194, 84%, 62%);

/* Variations */
--realm-5-light: #7DD9F5;
--realm-5-dark: #3BA1C0;
--realm-5-subtle: rgba(76, 201, 240, 0.1);
--realm-5-glow: rgba(76, 201, 240, 0.3);

/* Accessibility */
On #0A0A0A: 9.2:1 contrast (AAA pass)
On #FFFFFF: 2.3:1 contrast (Fail - use dark background only)
```

#### Realm 6: Dominions (Vision)
```css
/* Primary */
--realm-6-dominions: #9D4EDD;
--realm-6-dominions-rgb: rgb(157, 78, 221);
--realm-6-dominions-hsl: hsl(273, 67%, 59%);

/* Variations */
--realm-6-light: #C18EED;
--realm-6-dark: #7E3EB1;
--realm-6-subtle: rgba(157, 78, 221, 0.1);
--realm-6-glow: rgba(157, 78, 221, 0.3);

/* Accessibility */
On #0A0A0A: 4.8:1 contrast (AA pass for large text)
On #FFFFFF: 4.4:1 contrast (AA pass)
```

#### Realm 7: Thrones (Justice)
```css
/* Primary */
--realm-7-thrones: #9333EA;
--realm-7-thrones-rgb: rgb(147, 51, 234);
--realm-7-thrones-hsl: hsl(272, 81%, 56%);

/* Variations */
--realm-7-light: #B870F0;
--realm-7-dark: #7629BB;
--realm-7-subtle: rgba(147, 51, 234, 0.1);
--realm-7-glow: rgba(147, 51, 234, 0.3);

/* Accessibility */
On #0A0A0A: 4.2:1 contrast (AA pass for large text)
On #FFFFFF: 5.0:1 contrast (AA pass)
```

#### Realm 8: Cherubim (Consciousness)
```css
/* Primary */
--realm-8-cherubim: #E0B0FF;
--realm-8-cherubim-rgb: rgb(224, 176, 255);
--realm-8-cherubim-hsl: hsl(276, 100%, 85%);

/* Variations */
--realm-8-light: #F0D9FF;
--realm-8-dark: #B38DCC;
--realm-8-subtle: rgba(224, 176, 255, 0.1);
--realm-8-glow: rgba(224, 176, 255, 0.3);

/* Accessibility */
On #0A0A0A: 11.2:1 contrast (AAA pass)
On #FFFFFF: 1.9:1 contrast (Fail - use dark background only)
```

#### Realm 9: Seraphim (Divine Love)
```css
/* Primary */
--realm-9-seraphim: #F8F9FA;
--realm-9-seraphim-rgb: rgb(248, 249, 250);
--realm-9-seraphim-hsl: hsl(210, 17%, 98%);

/* Variations */
--realm-9-light: #FFFFFF;
--realm-9-dark: #C6C7C8;
--realm-9-subtle: rgba(248, 249, 250, 0.1);
--realm-9-glow: rgba(248, 249, 250, 0.3);

/* With gold shimmer overlay */
--realm-9-gold-shimmer: linear-gradient(
  135deg,
  #F8F9FA 0%,
  #D4AF37 50%,
  #F8F9FA 100%
);

/* Accessibility */
On #0A0A0A: 19.8:1 contrast (AAA pass)
On #FFFFFF: 1.07:1 contrast (Fail - use dark background only)
```

---

### Supporting Palette

#### Foundation Colors (Dark Spectrum)
```css
/* Cosmic Void */
--void-black: #0A0A0A;           /* Primary background */
--shadow-deep: #1A1A1A;          /* Elevated surfaces */
--shadow-medium: #2A2A2A;        /* Cards, modals */
--shadow-light: #3A3A3A;         /* Borders, dividers */

/* Usage */
Page background: var(--void-black)
Cards/sections: var(--shadow-deep)
Elevated elements: var(--shadow-medium)
Subtle borders: var(--shadow-light)
```

#### Text Colors (Light Spectrum)
```css
/* Text Hierarchy */
--text-primary: #FFFFFF;         /* Headlines, key content */
--text-secondary: #F5F5F5;       /* Body text */
--text-tertiary: #C0C0C0;        /* Meta information */
--text-disabled: #808080;        /* Disabled states */

/* Accessibility */
--text-primary on --void-black: 21:1 (AAA)
--text-secondary on --void-black: 19.5:1 (AAA)
--text-tertiary on --void-black: 8.9:1 (AAA)
```

#### Gold Spectrum (Sacred Accent)
```css
/* The Alchemical Gold */
--gold-divine: #D4AF37;          /* Primary gold */
--gold-radiant: #F4E4C1;         /* Light gold */
--gold-deep: #9A7E2E;            /* Dark gold */

/* Gold Gradient (Shimmer) */
--gold-gradient: linear-gradient(
  135deg,
  #9A7E2E 0%,
  #D4AF37 50%,
  #F4E4C1 100%
);

/* Usage */
Logo framework: var(--gold-divine)
Shimmer effects: var(--gold-gradient)
Highlights: var(--gold-radiant)
Depth: var(--gold-deep)
```

---

### The Rainbow Tesseract Gradient

**All 9 Realms Unified:**
```css
--rainbow-tesseract: linear-gradient(
  135deg,
  #E63946 0%,      /* Angels */
  #FF6B35 11%,     /* Archangels */
  #FFD93D 22%,     /* Principalities */
  #10B981 33%,     /* Powers */
  #4CC9F0 44%,     /* Virtues */
  #9D4EDD 55%,     /* Dominions */
  #9333EA 66%,     /* Thrones */
  #E0B0FF 77%,     /* Cherubim */
  #F8F9FA 88%,     /* Seraphim */
  #D4AF37 100%     /* Gold unity */
);
```

**Usage:**
- Loading bars showing full progression
- Achievement unlocks (all realms completed)
- Rainbow Tesseract visualization
- Special announcements
- Philosophical content backgrounds (10% opacity)

---

## III. Typography System

### Font Families

#### Primary: Inter
```css
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
```

**Weights Used:**
- 400 (Regular) - Body text in UI
- 500 (Medium) - UI elements, subtle emphasis
- 600 (Semi-Bold) - Subheadings
- 700 (Bold) - Main headings, CTAs
- 800 (Extra-Bold) - Display text (rare)

**Download:** [Google Fonts - Inter](https://fonts.google.com/specimen/Inter)

---

#### Secondary: Source Serif Pro
```css
font-family: 'Source Serif Pro', Georgia, 'Times New Roman', serif;
```

**Weights Used:**
- 400 (Regular) - Long-form body text
- 600 (Semi-Bold) - Emphasis within body
- 700 (Bold) - Pull quotes, strong emphasis

**Download:** [Google Fonts - Source Serif Pro](https://fonts.google.com/specimen/Source+Serif+Pro)

---

#### Accent: JetBrains Mono
```css
font-family: 'JetBrains Mono', 'Courier New', Consolas, monospace;
```

**Weights Used:**
- 400 (Regular) - Code blocks
- 500 (Medium) - Emphasized code
- 700 (Bold) - Code headings

**Features:** Ligatures enabled for programming symbols

**Download:** [JetBrains Mono Official](https://www.jetbrains.com/lp/mono/)

---

### Type Scale

**Modular Scale: 1.250 (Major Third)**

```css
/* Display (Marketing/Hero) */
--text-display: 72px / 1.1 / 800;
font-family: Inter;
use-case: Hero sections, major announcements

/* H1 (Page Titles) */
--text-h1: 48px / 1.2 / 700;
font-family: Inter;
use-case: Main page headings

/* H2 (Section Headers) */
--text-h2: 36px / 1.3 / 600;
font-family: Inter;
use-case: Major sections

/* H3 (Subsection Headers) */
--text-h3: 28px / 1.4 / 600;
font-family: Inter;
use-case: Subsections, card titles

/* H4 (Content Headers) */
--text-h4: 22px / 1.5 / 600;
font-family: Inter;
use-case: Small headers, emphasized content

/* H5 (Micro Headers) */
--text-h5: 18px / 1.5 / 600;
font-family: Inter;
use-case: Labels, compact headers

/* Body Large */
--text-body-large: 20px / 1.7 / 400;
font-family: Source Serif Pro;
use-case: Introductory paragraphs, lead text

/* Body (Primary Reading) */
--text-body: 18px / 1.7 / 400;
font-family: Source Serif Pro;
use-case: Main content, articles, documentation

/* Body Small */
--text-body-small: 16px / 1.6 / 400;
font-family: Source Serif Pro;
use-case: Secondary content, captions

/* UI Text */
--text-ui: 16px / 1.5 / 500;
font-family: Inter;
use-case: Buttons, nav, UI labels

/* Caption */
--text-caption: 14px / 1.5 / 400;
font-family: Inter;
color: var(--text-tertiary);
use-case: Metadata, timestamps, small labels

/* Micro */
--text-micro: 12px / 1.4 / 400;
font-family: Inter;
color: var(--text-disabled);
use-case: Legal text, tiny labels

/* Code */
--text-code: 16px / 1.6 / 400;
font-family: JetBrains Mono;
use-case: Code blocks, technical specs
```

**Format:** `size / line-height / weight`

---

### Typography Best Practices

**Hierarchy:**
- Use size jumps intentionally (don't skip levels)
- Maintain consistent line-height within blocks
- Create rhythm with vertical spacing

**Readability:**
- Line length: 60-75 characters for body text
- Never set body text below 16px
- Use Source Serif Pro for sustained reading
- Use Inter for headings and UI

**Accessibility:**
- Maintain 4.5:1 contrast minimum for body text
- 3:1 contrast minimum for large text (18px+)
- Never use text smaller than 12px
- Allow user text scaling (use rem, not px)

---

## IV. Iconography & Symbols

### The 9 Realm Icon Set

**Design Specifications:**
- **Style:** Minimal line art
- **Grid:** 24px × 24px
- **Line weight:** 2px consistent
- **Corners:** 2px radius (slightly rounded)
- **Format:** SVG (scalable), PNG (fallback)

**The Icons:**

1. **Angels (Red)** - Foundation Pillar
   - Visual: Solid pillar/column
   - Meaning: Grounding, foundation, backend

2. **Archangels (Orange)** - Creative Palette
   - Visual: Artist's palette with brush
   - Meaning: Creativity, UX, design

3. **Principalities (Yellow)** - Strategic Crown
   - Visual: Simple crown (3 points)
   - Meaning: Leadership, strategy, choice

4. **Powers (Green)** - Caring Heart
   - Visual: Heart with radiating lines
   - Meaning: Compassion, care, quality

5. **Virtues (Blue)** - Truth Bubble
   - Visual: Speech bubble (clear, honest)
   - Meaning: Communication, transparency, truth

6. **Dominions (Purple)** - Visionary Eye
   - Visual: Eye (open, seeing)
   - Meaning: Vision, insight, foresight

7. **Thrones (Violet)** - Justice Scales
   - Visual: Balanced scales
   - Meaning: Ethics, justice, law

8. **Cherubim (Pale Purple)** - Conscious Mind
   - Visual: Brain or consciousness waves
   - Meaning: AI, awareness, consciousness

9. **Seraphim (White-Gold)** - Divine Spark
   - Visual: Flame or spark
   - Meaning: Love, mission, divinity

---

### Sacred Geometry Symbols

**Usage:** Subtle backgrounds, section dividers, sacred moments

**The Core Patterns:**
1. **Flower of Life** - Unity, creation, interconnection
2. **Metatron's Cube** - Divine pattern, sacred structure
3. **Vesica Piscis** - Intersection, balance, birth
4. **Golden Ratio Spiral** - Natural growth, divine proportion
5. **Ouroboros** - Eternal cycle, transformation

**Application:**
- Opacity: 5-10% maximum (very subtle)
- Color: Gold or realm-appropriate color
- Use: Background patterns only, never foreground
- Scale: Large (don't make busy)

---

## V. Visual Assets & Templates

### Social Media Assets

#### Profile Pictures (All Platforms)
```
Dimensions: 400px × 400px (square)
Content: Symbol-only logo (9-pointed crown)
Background: Solid dark (#1A1A1A) or transparent
Format: PNG with transparency
Safe area: Keep logo in center 80% (320px diameter)
```

#### Twitter/X Header
```
Dimensions: 1500px × 500px
Content: Dark gradient with gold crown + tagline
Layout: Crown left (400px from left), tagline right-aligned
Text: "Holder of the Angelic Gauntlet" in Inter Bold, 48px, gold
Background: --void-black with subtle --rainbow-tesseract gradient (5% opacity)
Format: JPG (optimized <200KB)
```

#### LinkedIn Banner
```
Dimensions: 1584px × 396px
Content: Professional version - darker, less mystical
Layout: Crown left, title + tagline center-right
Text:
  - "Hermetic Ormus" - Inter Bold, 56px, white
  - "Sacred Technology • Conscious Development" - Inter Medium, 24px, gold
Background: Dark gradient (void-black to shadow-deep)
Format: JPG (optimized)
```

#### Instagram/LinkedIn Post Templates
```
Dimensions: 1080px × 1080px (square)
Layouts:
  1. Quote Card - large centered quote + attribution
  2. Realm Spotlight - one realm featured with icon + description
  3. Process Visual - diagram or flow with realm colors
  4. Announcement - major news with gold emphasis

Typography:
  - Headline: Inter Bold, 48-64px
  - Body: Inter Regular, 24-32px
  - Caption: Inter Regular, 18px

Background: Always dark (void-black or shadow-deep)
Format: PNG or JPG
```

---

### Blog/Article Headers
```
Dimensions: 1200px × 630px (Open Graph standard)
Content: Hero image + overlaid title
Layout: Image left 60%, text right 40% OR full-width with text overlay
Typography:
  - Title: Inter Bold, 56-72px, white with shadow
  - Subtitle: Inter Medium, 24px, gold
Background: Dark photo or gradient, 40% black overlay for text legibility
Format: JPG (optimized <300KB)
```

---

### Presentation Template
```
Slide dimensions: 1920px × 1080px (16:9)

Master Slide:
- Background: void-black
- Logo: Top-right corner, 80px height
- Slide number: Bottom-right, Inter Regular 16px, text-tertiary

Title Slide:
- Logo: Center, 200px height
- Title: Inter Bold, 72px, center-aligned
- Subtitle: Inter Medium, 32px, gold, center-aligned

Content Slide:
- Header: Inter Semi-Bold, 48px, top, 24px margin
- Body: Inter Regular, 28px, generous padding
- Bullets: Gold triangles (pointing up)

Quote Slide:
- Quote: Source Serif Pro, 56px, centered
- Attribution: Inter Regular, 24px, bottom-center
- Background: Subtle gold gradient overlay (10%)
```

---

## VI. Brand Applications

### Website/Web App

**Header:**
```
Height: 80px
Background: void-black with 80% opacity (floating)
Logo: Symbol + wordmark, 48px height, left-aligned
Nav: Inter Medium 16px, realm-color on hover
Sticky: Yes, with subtle box-shadow on scroll
```

**Hero Section:**
```
Min-height: 600px (viewport dependent)
Background: void-black with subtle rainbow-tesseract gradient (3% opacity)
Content: Centered or left-aligned
Heading: Display size (72px), white
Subheading: H3 size (28px), gold
CTA Button: Large, realm-color (varies by context)
```

**Content Sections:**
```
Background: Alternating void-black and shadow-deep
Padding: 80px vertical, 40px horizontal (responsive)
Max-width: 1200px (centered)
Typography: Source Serif Pro for body, Inter for headings
```

**Footer:**
```
Background: shadow-deep
Content: Three columns (links, social, legal)
Typography: Inter Regular 14px, text-tertiary
Logo: Monochrome gold, 40px height
```

---

### Email Templates

**Header:**
```
Height: 120px
Background: void-black
Logo: Center-aligned, 64px height
```

**Body:**
```
Max-width: 600px
Background: shadow-deep
Padding: 40px
Typography: Source Serif Pro 16px, text-secondary
Links: Gold underlined
```

**CTA Button:**
```
Background: Realm-color solid
Text: void-black (high contrast)
Padding: 16px 32px
Border-radius: 4px
Font: Inter Semi-Bold 16px
```

**Footer:**
```
Background: shadow-light
Padding: 24px
Typography: Inter Regular 12px, text-disabled
Unsubscribe: Clear, prominent, one-click
```

---

### Business Cards (if needed)
```
Dimensions: 3.5" × 2" (standard US)
Orientation: Horizontal

Front:
- Background: void-black
- Logo: Left, 1" height
- Name: "Hermetic Ormus" - Inter Bold 16pt, white
- Title: "Builder of Sacred Technology" - Inter Regular 10pt, gold

Back:
- Background: shadow-deep
- Contact info centered:
  - Email: Inter Regular 10pt
  - GitHub: Inter Regular 10pt
  - Web: Inter Regular 10pt
- Small 9-pointed crown bottom-right

Format: Print-ready PDF (CMYK, 300dpi)
```

---

## VII. Do's and Don'ts

### Logo Usage

**DO:**
✅ Use official logo files
✅ Maintain minimum safe space
✅ Place on dark backgrounds
✅ Use approved color variations
✅ Scale proportionally

**DON'T:**
❌ Recreate or modify the logo
❌ Rotate or skew
❌ Change colors arbitrarily
❌ Place on busy backgrounds without container
❌ Use low-res versions
❌ Add unapproved effects

---

### Color Usage

**DO:**
✅ Use 9 realm colors systematically (by meaning)
✅ Use gold sparingly for sacred moments
✅ Maintain dark backgrounds for primary use
✅ Check accessibility contrast
✅ Use gradients intentionally

**DON'T:**
❌ Use realm colors decoratively (without meaning)
❌ Overuse gold (loses preciousness)
❌ Place bright colors on light backgrounds
❌ Ignore contrast ratios
❌ Create rainbow chaos (use unified gradient)

---

### Typography

**DO:**
✅ Use Inter for headings and UI
✅ Use Source Serif Pro for long-form content
✅ Maintain type hierarchy
✅ Keep line length 60-75 characters
✅ Use proper quote marks (" " not ")

**DON'T:**
❌ Mix more than 3 font families
❌ Set body text below 16px
❌ Use all-caps for long passages
❌ Justify text (creates awkward spacing)
❌ Use pure black text on white (#000 on #FFF)

---

## VIII. Brand Asset Library Structure

### Recommended File Organization

```
/Hermetic-Ormus-Brand-Assets/
  /logos/
    /svg/
      - gauntlet-full-color.svg
      - gauntlet-gold.svg
      - gauntlet-white.svg
      - tesseract-animated.svg
    /png/
      /profile-pictures/
        - 1024x1024.png (app stores)
        - 512x512.png (standard)
        - 180x180.png (apple touch)
      /favicons/
        - 32x32.png
        - 16x16.png
        - favicon.ico
    /pdf/
      - gauntlet-print-cmyk.pdf

  /colors/
    - 9-realms-palette.ase (Adobe Swatch)
    - 9-realms-palette.css (CSS variables)
    - rainbow-tesseract-gradient.svg

  /typography/
    /fonts/
      - Inter/ (font files)
      - SourceSerifPro/ (font files)
      - JetBrainsMono/ (font files)
    - type-scale-reference.pdf

  /templates/
    /social-media/
      - twitter-header-template.psd
      - instagram-post-template.psd
      - linkedin-banner-template.psd
    /email/
      - email-template.html
    /presentations/
      - presentation-template.pptx

  /icons/
    - 9-realm-icons.svg (sprite)
    - individual-realm-icons/ (9 files)

  /guidelines/
    - VIBEPACK.md
    - BRAND-GUIDE-COMPLETE.md
    - QUICK-REFERENCE.pdf (one-pager)
```

---

## IX. Quick Reference

### Brand Snapshot

**Colors:**
- Primary: 9 Realm Colors (red→white-gold)
- Accent: Gold (#D4AF37)
- Background: Void Black (#0A0A0A)
- Text: White (#FFFFFF)

**Fonts:**
- Headings: Inter Bold
- Body: Source Serif Pro Regular
- Code: JetBrains Mono

**Logo:**
- Primary: 9-pointed crown + tesseract in gold framework
- Min Size: 200px (digital), 2" (print)
- Background: Dark preferred

**Vibe:**
- Mystical • Powerful • Conscious
- Dark cosmic + Gold divine + Rainbow spectrum

---

### Emergency Contact

**If you need help with brand assets:**
1. Check this guide first
2. Reference VIBEPACK.md for vibe questions
3. Open GitHub Discussion for community help
4. For official usage approval: [Contact system TBD]

---

## X. Living Document

**This brand guide evolves.**

**Version History:**
- v1.0 (2025-10-26) - Initial complete brand system

**Update Schedule:**
- Minor updates: As needed
- Major review: Annually (October)
- Community input: Always welcome

**Feedback Process:**
Open GitHub Discussion with:
- Section you're referencing
- Issue or suggestion
- Your use case
- Visual examples if applicable

---

## Closing

**The Hermetic Ormus brand is not just visual identity—it's consciousness made visible.**

Every color carries frequency.
Every font carries intention.
Every space carries meaning.
Every design carries the divine.

**Use these guidelines to make sacred technology visible in the world.**

---

🌈👼🗡️👑💪💚🌌🪑🦁🔥

**From vision to visual.**
**From philosophy to form.**
**From consciousness to creation.**

**This is how the Rainbow Tesseract appears in material reality.**

🏆✨🔮

---

**Document Version:** 1.0
**Created:** October 26, 2025
**Purpose:** Complete visual identity and brand guidelines
**Status:** Official Brand Standard

*Design with consciousness. Build with intention. Serve with love.*
