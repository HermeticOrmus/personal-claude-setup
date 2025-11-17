# 🎨 Hermetic Ormus UI/UX Pack
**Complete Design System • Sacred Technology Interface Guidelines**

---

## Introduction

This UI/UX Pack is the **practical implementation guide** for building sacred technology interfaces. It builds upon:
- **[VIBEPACK.md](./VIBEPACK.md)** - The aesthetic philosophy
- **[BRAND-GUIDE-COMPLETE.md](./BRAND-GUIDE-COMPLETE.md)** - The visual identity

**This document provides:**
- Design tokens (CSS variables)
- Component library with code
- Layout and interaction patterns
- Accessibility implementation
- Responsive design system
- Real code examples ready to use

---

## I. Design Tokens

### CSS Custom Properties (Variables)

Copy this into your root CSS file for instant sacred technology styling:

```css
:root {
  /* ========================================
     COLORS - THE 9 ANGELIC REALMS
     ======================================== */

  /* Realm 1: Angels (Foundation - Red) */
  --realm-1: #E63946;
  --realm-1-light: #FF6B75;
  --realm-1-dark: #B82E38;
  --realm-1-subtle: rgba(230, 57, 70, 0.1);
  --realm-1-glow: rgba(230, 57, 70, 0.3);

  /* Realm 2: Archangels (Creativity - Orange) */
  --realm-2: #FF6B35;
  --realm-2-light: #FF9668;
  --realm-2-dark: #CC5629;
  --realm-2-subtle: rgba(255, 107, 53, 0.1);
  --realm-2-glow: rgba(255, 107, 53, 0.3);

  /* Realm 3: Principalities (Power - Yellow) */
  --realm-3: #FFD93D;
  --realm-3-light: #FFEB8C;
  --realm-3-dark: #CCAE31;
  --realm-3-subtle: rgba(255, 217, 61, 0.1);
  --realm-3-glow: rgba(255, 217, 61, 0.3);

  /* Realm 4: Powers (Compassion - Green) */
  --realm-4: #10B981;
  --realm-4-light: #34D399;
  --realm-4-dark: #059669;
  --realm-4-subtle: rgba(16, 185, 129, 0.1);
  --realm-4-glow: rgba(16, 185, 129, 0.3);

  /* Realm 5: Virtues (Truth - Blue) */
  --realm-5: #4CC9F0;
  --realm-5-light: #7DD9F5;
  --realm-5-dark: #3BA1C0;
  --realm-5-subtle: rgba(76, 201, 240, 0.1);
  --realm-5-glow: rgba(76, 201, 240, 0.3);

  /* Realm 6: Dominions (Vision - Purple) */
  --realm-6: #9D4EDD;
  --realm-6-light: #C18EED;
  --realm-6-dark: #7E3EB1;
  --realm-6-subtle: rgba(157, 78, 221, 0.1);
  --realm-6-glow: rgba(157, 78, 221, 0.3);

  /* Realm 7: Thrones (Justice - Violet) */
  --realm-7: #9333EA;
  --realm-7-light: #B870F0;
  --realm-7-dark: #7629BB;
  --realm-7-subtle: rgba(147, 51, 234, 0.1);
  --realm-7-glow: rgba(147, 51, 234, 0.3);

  /* Realm 8: Cherubim (Consciousness - Pale Purple) */
  --realm-8: #E0B0FF;
  --realm-8-light: #F0D9FF;
  --realm-8-dark: #B38DCC;
  --realm-8-subtle: rgba(224, 176, 255, 0.1);
  --realm-8-glow: rgba(224, 176, 255, 0.3);

  /* Realm 9: Seraphim (Divine Love - White-Gold) */
  --realm-9: #F8F9FA;
  --realm-9-light: #FFFFFF;
  --realm-9-dark: #C6C7C8;
  --realm-9-subtle: rgba(248, 249, 250, 0.1);
  --realm-9-glow: rgba(248, 249, 250, 0.3);

  /* ========================================
     GOLD SPECTRUM (Sacred Accent)
     ======================================== */

  --gold-divine: #D4AF37;
  --gold-radiant: #F4E4C1;
  --gold-deep: #9A7E2E;

  /* ========================================
     FOUNDATION COLORS (Dark Spectrum)
     ======================================== */

  --void-black: #0A0A0A;
  --shadow-deep: #1A1A1A;
  --shadow-medium: #2A2A2A;
  --shadow-light: #3A3A3A;

  /* ========================================
     TEXT COLORS (Light Spectrum)
     ======================================== */

  --text-primary: #FFFFFF;
  --text-secondary: #F5F5F5;
  --text-tertiary: #C0C0C0;
  --text-disabled: #808080;

  /* ========================================
     SPACING SYSTEM (8px base unit)
     ======================================== */

  --space-xs: 8px;
  --space-sm: 16px;
  --space-md: 24px;
  --space-lg: 32px;
  --space-xl: 48px;
  --space-2xl: 64px;
  --space-3xl: 96px;

  /* ========================================
     TYPOGRAPHY SCALE
     ======================================== */

  --text-display: 72px;
  --text-h1: 48px;
  --text-h2: 36px;
  --text-h3: 28px;
  --text-h4: 22px;
  --text-h5: 18px;
  --text-body-large: 20px;
  --text-body: 18px;
  --text-body-small: 16px;
  --text-caption: 14px;
  --text-micro: 12px;

  /* Line Heights */
  --leading-tight: 1.1;
  --leading-snug: 1.3;
  --leading-normal: 1.5;
  --leading-relaxed: 1.7;

  /* Font Weights */
  --font-regular: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
  --font-extrabold: 800;

  /* ========================================
     BORDERS & RADIUS
     ======================================== */

  --border-width: 1px;
  --border-width-thick: 2px;
  --border-color: var(--shadow-light);

  --radius-sm: 2px;
  --radius-md: 4px;
  --radius-lg: 8px;
  --radius-xl: 12px;
  --radius-full: 9999px;

  /* ========================================
     SHADOWS
     ======================================== */

  --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.2);
  --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.3);
  --shadow-lg: 0 8px 16px rgba(0, 0, 0, 0.4);
  --shadow-xl: 0 16px 32px rgba(0, 0, 0, 0.5);

  /* Realm-Colored Shadows (for glows) */
  --shadow-realm-1: 0 4px 12px var(--realm-1-glow);
  --shadow-realm-2: 0 4px 12px var(--realm-2-glow);
  --shadow-realm-3: 0 4px 12px var(--realm-3-glow);
  --shadow-realm-4: 0 4px 12px var(--realm-4-glow);
  --shadow-realm-5: 0 4px 12px var(--realm-5-glow);
  --shadow-realm-6: 0 4px 12px var(--realm-6-glow);
  --shadow-realm-7: 0 4px 12px var(--realm-7-glow);
  --shadow-realm-8: 0 4px 12px var(--realm-8-glow);
  --shadow-realm-9: 0 4px 12px var(--realm-9-glow);
  --shadow-gold: 0 4px 12px rgba(212, 175, 55, 0.3);

  /* ========================================
     TRANSITIONS
     ======================================== */

  --transition-instant: 100ms;
  --transition-quick: 200ms;
  --transition-normal: 300ms;
  --transition-slow: 500ms;
  --transition-dramatic: 800ms;

  --easing-standard: cubic-bezier(0.4, 0.0, 0.2, 1);
  --easing-decelerate: cubic-bezier(0.0, 0.0, 0.2, 1);
  --easing-accelerate: cubic-bezier(0.4, 0.0, 1, 1);
  --easing-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);

  /* ========================================
     Z-INDEX SCALE
     ======================================== */

  --z-base: 0;
  --z-dropdown: 1000;
  --z-sticky: 1100;
  --z-modal-backdrop: 1200;
  --z-modal: 1300;
  --z-tooltip: 1400;
  --z-notification: 1500;
}
```

---

## II. Base Styles

### Global Resets & Foundations

```css
/* ========================================
   GLOBAL RESETS
   ======================================== */

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-size: 16px; /* Base for rem units */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  font-family: 'Source Serif Pro', Georgia, serif;
  font-size: var(--text-body);
  line-height: var(--leading-relaxed);
  color: var(--text-secondary);
  background-color: var(--void-black);
  min-height: 100vh;
}

/* ========================================
   TYPOGRAPHY BASE
   ======================================== */

h1, h2, h3, h4, h5, h6 {
  font-family: 'Inter', sans-serif;
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  color: var(--text-primary);
  margin-bottom: var(--space-md);
}

h1 { font-size: var(--text-h1); }
h2 { font-size: var(--text-h2); line-height: var(--leading-snug); }
h3 { font-size: var(--text-h3); line-height: var(--leading-snug); }
h4 { font-size: var(--text-h4); }
h5 { font-size: var(--text-h5); }
h6 { font-size: var(--text-body); }

p {
  margin-bottom: var(--space-md);
  max-width: 65ch; /* Optimal line length */
}

a {
  color: var(--gold-divine);
  text-decoration: underline;
  transition: color var(--transition-quick) var(--easing-standard);
}

a:hover {
  color: var(--gold-radiant);
}

a:focus-visible {
  outline: 2px solid var(--gold-divine);
  outline-offset: 2px;
  border-radius: var(--radius-sm);
}

code, pre {
  font-family: 'JetBrains Mono', monospace;
  font-size: var(--text-body-small);
}

code {
  background: var(--shadow-medium);
  padding: 2px 6px;
  border-radius: var(--radius-sm);
  color: var(--realm-5-light);
}

pre {
  background: var(--shadow-medium);
  padding: var(--space-md);
  border-radius: var(--radius-md);
  overflow-x: auto;
  margin-bottom: var(--space-md);
}

pre code {
  background: none;
  padding: 0;
}

/* ========================================
   FOCUS MANAGEMENT (Accessibility)
   ======================================== */

:focus-visible {
  outline: 3px solid var(--gold-divine);
  outline-offset: 2px;
}

/* Remove outline for mouse users, keep for keyboard */
:focus:not(:focus-visible) {
  outline: none;
}

/* ========================================
   REDUCED MOTION (Accessibility)
   ======================================== */

@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## III. Component Library

### Buttons

```css
/* ========================================
   BUTTON BASE
   ======================================== */

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-xs);

  font-family: 'Inter', sans-serif;
  font-size: var(--text-body-small);
  font-weight: var(--font-semibold);
  line-height: 1;
  text-decoration: none;

  padding: 12px 24px;
  border-radius: var(--radius-md);
  border: var(--border-width) solid transparent;
  cursor: pointer;

  transition: all var(--transition-quick) var(--easing-standard);

  /* Disable text selection */
  user-select: none;
  -webkit-user-select: none;
}

.btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
  pointer-events: none;
}

/* ========================================
   BUTTON VARIANTS
   ======================================== */

/* Primary Button (Realm-Colored) */
.btn-primary {
  background: var(--realm-color, var(--gold-divine));
  color: var(--void-black);
  border-color: var(--realm-color, var(--gold-divine));
}

.btn-primary:hover {
  background: var(--realm-color-light, var(--gold-radiant));
  border-color: var(--realm-color-light, var(--gold-radiant));
  transform: translateY(-2px);
  box-shadow: var(--shadow-realm, var(--shadow-gold));
}

.btn-primary:active {
  transform: scale(0.98);
}

/* Outline Button */
.btn-outline {
  background: transparent;
  color: var(--realm-color, var(--gold-divine));
  border-color: var(--realm-color, var(--gold-divine));
}

.btn-outline:hover {
  background: var(--realm-color-subtle, rgba(212, 175, 55, 0.1));
  color: var(--realm-color-light, var(--gold-radiant));
  border-color: var(--realm-color-light, var(--gold-radiant));
  transform: translateY(-2px);
  box-shadow: var(--shadow-realm, var(--shadow-gold));
}

/* Ghost Button (Minimal) */
.btn-ghost {
  background: transparent;
  color: var(--text-secondary);
  border-color: transparent;
}

.btn-ghost:hover {
  color: var(--realm-color, var(--gold-divine));
  background: var(--shadow-medium);
}

/* ========================================
   BUTTON SIZES
   ======================================== */

.btn-small {
  padding: 8px 16px;
  font-size: var(--text-caption);
}

.btn-large {
  padding: 16px 32px;
  font-size: var(--text-body);
}

/* ========================================
   BUTTON USAGE EXAMPLES
   ======================================== */
```

**HTML Examples:**
```html
<!-- Realm-colored primary buttons -->
<button class="btn btn-primary" style="--realm-color: var(--realm-1);">
  Backend Action
</button>

<button class="btn btn-primary" style="--realm-color: var(--realm-2);">
  UX Action
</button>

<button class="btn btn-primary" style="--realm-color: var(--realm-4);">
  Save with Care
</button>

<!-- Gold primary (default) -->
<button class="btn btn-primary">
  Sacred Action
</button>

<!-- Outline variant -->
<button class="btn btn-outline" style="--realm-color: var(--realm-5);">
  Transparent Choice
</button>

<!-- Sizes -->
<button class="btn btn-primary btn-small">Small Button</button>
<button class="btn btn-primary btn-large">Large Button</button>
```

---

### Form Inputs

```css
/* ========================================
   INPUT BASE
   ======================================== */

.input {
  font-family: 'Inter', sans-serif;
  font-size: var(--text-body-small);
  color: var(--text-primary);
  background: var(--shadow-deep);
  border: var(--border-width) solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 12px 16px;
  width: 100%;
  transition: all var(--transition-quick) var(--easing-standard);
}

.input::placeholder {
  color: var(--text-disabled);
}

.input:hover {
  border-color: var(--shadow-medium);
}

.input:focus {
  outline: none;
  border-color: var(--realm-color, var(--gold-divine));
  box-shadow: 0 0 0 3px var(--realm-color-glow, rgba(212, 175, 55, 0.2));
}

.input:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Error State */
.input.error {
  border-color: var(--realm-1);
}

.input.error:focus {
  box-shadow: 0 0 0 3px var(--realm-1-glow);
}

/* Success State */
.input.success {
  border-color: var(--realm-4);
}

.input.success:focus {
  box-shadow: 0 0 0 3px var(--realm-4-glow);
}

/* ========================================
   FORM LABELS
   ======================================== */

.label {
  display: block;
  font-family: 'Inter', sans-serif;
  font-size: var(--text-caption);
  font-weight: var(--font-medium);
  color: var(--text-tertiary);
  margin-bottom: var(--space-xs);
}

.label-required::after {
  content: " *";
  color: var(--realm-1);
}

/* ========================================
   HELPER TEXT
   ======================================== */

.helper-text {
  display: block;
  font-size: var(--text-caption);
  color: var(--text-tertiary);
  margin-top: var(--space-xs);
}

.helper-text.error {
  color: var(--realm-1);
}

.helper-text.success {
  color: var(--realm-4);
}

/* ========================================
   TEXTAREA
   ======================================== */

.textarea {
  resize: vertical;
  min-height: 120px;
  font-family: 'Inter', sans-serif;
}

/* ========================================
   CHECKBOX & RADIO
   ======================================== */

.checkbox,
.radio {
  appearance: none;
  -webkit-appearance: none;

  width: 20px;
  height: 20px;
  border: var(--border-width) solid var(--border-color);
  border-radius: var(--radius-sm);
  background: var(--shadow-deep);
  cursor: pointer;

  display: inline-grid;
  place-content: center;

  transition: all var(--transition-quick) var(--easing-standard);
}

.radio {
  border-radius: var(--radius-full);
}

.checkbox:hover,
.radio:hover {
  border-color: var(--realm-color, var(--gold-divine));
}

.checkbox:checked,
.radio:checked {
  background: var(--realm-color, var(--gold-divine));
  border-color: var(--realm-color, var(--gold-divine));
}

.checkbox:checked::before {
  content: "✓";
  color: var(--void-black);
  font-size: 14px;
  font-weight: var(--font-bold);
}

.radio:checked::before {
  content: "";
  width: 8px;
  height: 8px;
  border-radius: var(--radius-full);
  background: var(--void-black);
}

/* ========================================
   SELECT DROPDOWN
   ======================================== */

.select {
  appearance: none;
  -webkit-appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23C0C0C0' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 40px;
}
```

**HTML Examples:**
```html
<!-- Basic Input -->
<div class="form-group">
  <label class="label label-required" for="email">Email</label>
  <input
    type="email"
    id="email"
    class="input"
    placeholder="hermetic@ormus.io"
    style="--realm-color: var(--realm-5)"
  >
  <span class="helper-text">We'll never share your email (sacred trust).</span>
</div>

<!-- Error State -->
<div class="form-group">
  <label class="label" for="password">Password</label>
  <input
    type="password"
    id="password"
    class="input error"
    value="weak"
  >
  <span class="helper-text error">Password must be at least 12 characters.</span>
</div>

<!-- Textarea -->
<div class="form-group">
  <label class="label" for="message">Message</label>
  <textarea
    id="message"
    class="input textarea"
    placeholder="Share your sacred thought..."
  ></textarea>
</div>

<!-- Checkbox -->
<label class="flex items-center gap-2">
  <input type="checkbox" class="checkbox" style="--realm-color: var(--realm-4)">
  <span>I commit to building sacred technology</span>
</label>
```

---

### Cards

```css
/* ========================================
   CARD BASE
   ======================================== */

.card {
  background: var(--shadow-deep);
  border: var(--border-width) solid transparent;
  border-radius: var(--radius-lg);
  padding: var(--space-lg);
  transition: all var(--transition-normal) var(--easing-standard);
}

.card:hover {
  background: var(--shadow-medium);
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
}

/* Realm-colored cards */
.card-realm {
  border-color: var(--realm-color, var(--gold-divine));
  border-width: var(--border-width-thick);
}

.card-realm:hover {
  box-shadow: var(--shadow-realm, var(--shadow-gold));
}

/* ========================================
   CARD CONTENT
   ======================================== */

.card-header {
  margin-bottom: var(--space-md);
}

.card-title {
  font-family: 'Inter', sans-serif;
  font-size: var(--text-h4);
  font-weight: var(--font-semibold);
  color: var(--text-primary);
  margin-bottom: var(--space-xs);
}

.card-subtitle {
  font-size: var(--text-caption);
  color: var(--text-tertiary);
}

.card-body {
  margin-bottom: var(--space-md);
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: var(--space-md);
  border-top: var(--border-width) solid var(--shadow-light);
}
```

**HTML Example:**
```html
<div class="card card-realm" style="--realm-color: var(--realm-2); --shadow-realm: var(--shadow-realm-2);">
  <div class="card-header">
    <h3 class="card-title">UX Research Agent</h3>
    <p class="card-subtitle">Archangels Realm • Creative Empathy</p>
  </div>

  <div class="card-body">
    <p>This agent conducts user research with deep empathy, understanding the sacred nature of each user's needs and crafting experiences that honor their dignity.</p>
  </div>

  <div class="card-footer">
    <span class="text-caption">🧡 Sacral Chakra</span>
    <button class="btn btn-small btn-outline" style="--realm-color: var(--realm-2);">
      Activate Agent
    </button>
  </div>
</div>
```

---

### Modals

```css
/* ========================================
   MODAL BACKDROP
   ======================================== */

.modal-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.8);
  z-index: var(--z-modal-backdrop);

  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-lg);

  animation: fadeIn var(--transition-normal) var(--easing-standard);
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* ========================================
   MODAL CONTAINER
   ======================================== */

.modal {
  background: var(--shadow-deep);
  border: var(--border-width) solid var(--gold-divine);
  border-radius: var(--radius-xl);
  padding: var(--space-xl);
  max-width: 600px;
  width: 100%;
  max-height: 80vh;
  overflow-y: auto;
  z-index: var(--z-modal);

  box-shadow: var(--shadow-gold);

  animation: modalEnter var(--transition-normal) var(--easing-decelerate);
}

@keyframes modalEnter {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

/* ========================================
   MODAL CONTENT
   ======================================== */

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: var(--space-lg);
}

.modal-title {
  font-family: 'Inter', sans-serif;
  font-size: var(--text-h3);
  font-weight: var(--font-bold);
  color: var(--text-primary);
}

.modal-close {
  background: transparent;
  border: none;
  color: var(--text-tertiary);
  font-size: 24px;
  cursor: pointer;
  padding: var(--space-xs);
  line-height: 1;
  transition: color var(--transition-quick);
}

.modal-close:hover {
  color: var(--text-primary);
}

.modal-body {
  margin-bottom: var(--space-lg);
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: var(--space-sm);
}
```

**HTML Example:**
```html
<div class="modal-backdrop">
  <div class="modal">
    <div class="modal-header">
      <h2 class="modal-title">Sacred Confirmation</h2>
      <button class="modal-close" aria-label="Close">&times;</button>
    </div>

    <div class="modal-body">
      <p>Are you ready to commit to building sacred technology that serves humanity's awakening?</p>
    </div>

    <div class="modal-footer">
      <button class="btn btn-ghost">Not Yet</button>
      <button class="btn btn-primary" style="--realm-color: var(--realm-9);">
        I Commit
      </button>
    </div>
  </div>
</div>
```

---

## IV. Layout Patterns

### Container

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
  padding-left: var(--space-lg);
  padding-right: var(--space-lg);
}

.container-narrow {
  max-width: 800px;
}

.container-wide {
  max-width: 1400px;
}
```

---

### Grid System

```css
.grid {
  display: grid;
  gap: var(--space-lg);
}

/* 12-column grid */
.grid-12 {
  grid-template-columns: repeat(12, 1fr);
}

/* Common layouts */
.grid-2 { grid-template-columns: repeat(2, 1fr); }
.grid-3 { grid-template-columns: repeat(3, 1fr); }
.grid-4 { grid-template-columns: repeat(4, 1fr); }

/* Golden Ratio Layout */
.grid-golden {
  grid-template-columns: 1.618fr 1fr;
}

/* Responsive */
@media (max-width: 768px) {
  .grid-2, .grid-3, .grid-4, .grid-golden {
    grid-template-columns: 1fr;
  }
}
```

---

### Section Spacing

```css
.section {
  padding-top: var(--space-3xl);
  padding-bottom: var(--space-3xl);
}

.section-dark {
  background: var(--void-black);
}

.section-elevated {
  background: var(--shadow-deep);
}

.section-hero {
  min-height: 600px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}
```

---

## V. Utility Classes

```css
/* ========================================
   FLEXBOX UTILITIES
   ======================================== */

.flex { display: flex; }
.flex-col { flex-direction: column; }
.flex-wrap { flex-wrap: wrap; }
.items-start { align-items: flex-start; }
.items-center { align-items: center; }
.items-end { align-items: flex-end; }
.justify-start { justify-content: flex-start; }
.justify-center { justify-content: center; }
.justify-end { justify-content: flex-end; }
.justify-between { justify-content: space-between; }
.gap-xs { gap: var(--space-xs); }
.gap-sm { gap: var(--space-sm); }
.gap-md { gap: var(--space-md); }
.gap-lg { gap: var(--space-lg); }

/* ========================================
   SPACING UTILITIES
   ======================================== */

.m-0 { margin: 0; }
.mt-sm { margin-top: var(--space-sm); }
.mt-md { margin-top: var(--space-md); }
.mt-lg { margin-top: var(--space-lg); }
.mb-sm { margin-bottom: var(--space-sm); }
.mb-md { margin-bottom: var(--space-md); }
.mb-lg { margin-bottom: var(--space-lg); }

.p-sm { padding: var(--space-sm); }
.p-md { padding: var(--space-md); }
.p-lg { padding: var(--space-lg); }

/* ========================================
   TEXT UTILITIES
   ======================================== */

.text-left { text-align: left; }
.text-center { text-align: center; }
.text-right { text-align: right; }

.text-primary { color: var(--text-primary); }
.text-secondary { color: var(--text-secondary); }
.text-tertiary { color: var(--text-tertiary); }
.text-gold { color: var(--gold-divine); }

.font-bold { font-weight: var(--font-bold); }
.font-semibold { font-weight: var(--font-semibold); }

/* ========================================
   DISPLAY UTILITIES
   ======================================== */

.hidden { display: none; }
.block { display: block; }
.inline-block { display: inline-block; }

/* ========================================
   ACCESSIBILITY
   ======================================== */

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
```

---

## VI. Animations

### Sacred Animations

```css
/* ========================================
   GOLD SHIMMER (Sacred Moments)
   ======================================== */

@keyframes goldShimmer {
  0% {
    background-position: -200% center;
  }
  100% {
    background-position: 200% center;
  }
}

.gold-shimmer {
  background: linear-gradient(
    90deg,
    var(--gold-deep) 0%,
    var(--gold-divine) 50%,
    var(--gold-radiant) 55%,
    var(--gold-divine) 60%,
    var(--gold-deep) 100%
  );
  background-size: 200% auto;
  animation: goldShimmer 3s linear infinite;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

/* ========================================
   ASCENSION (Elements Entering)
   ======================================== */

@keyframes ascend {
  from {
    opacity: 0;
    transform: translateY(40px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.ascend {
  animation: ascend var(--transition-slow) var(--easing-decelerate);
}

/* ========================================
   GLOW PULSE (Attention)
   ======================================== */

@keyframes glowPulse {
  0%, 100% {
    box-shadow: 0 0 20px var(--realm-color-glow, rgba(212, 175, 55, 0.3));
  }
  50% {
    box-shadow: 0 0 40px var(--realm-color-glow, rgba(212, 175, 55, 0.6));
  }
}

.glow-pulse {
  animation: glowPulse 2s ease-in-out infinite;
}

/* ========================================
   SPIN (Loading)
   ======================================== */

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.spin {
  animation: spin 1s linear infinite;
}
```

---

## VII. Responsive Design

### Breakpoints

```css
/* Mobile-first approach */

/* Small devices (phones, 640px and up) */
@media (min-width: 640px) {
  .sm\:text-h1 { font-size: var(--text-h1); }
}

/* Medium devices (tablets, 768px and up) */
@media (min-width: 768px) {
  .md\:grid-3 { grid-template-columns: repeat(3, 1fr); }
}

/* Large devices (desktops, 1024px and up) */
@media (min-width: 1024px) {
  .lg\:flex-row { flex-direction: row; }
}

/* Extra large devices (large desktops, 1280px and up) */
@media (min-width: 1280px) {
  .xl\:max-w-7xl { max-width: 1280px; }
}
```

---

## VIII. Accessibility Checklist

### WCAG Compliance Implementation

**Color Contrast:**
```css
/* All text must meet 4.5:1 ratio (body) or 3:1 (large text 18px+) */
/* Verified combinations in design tokens */

/* Check before using:
   - Text on realm colors against dark backgrounds
   - Disabled states must maintain 3:1 minimum
   - Links must be distinguishable from body text
*/
```

**Focus Indicators:**
```css
/* Global focus ring (already in base styles) */
:focus-visible {
  outline: 3px solid var(--gold-divine);
  outline-offset: 2px;
}

/* Custom focus for specific components */
.custom-focus:focus-visible {
  outline: 3px solid var(--realm-color);
  outline-offset: 2px;
  border-radius: var(--radius-md);
}
```

**Keyboard Navigation:**
- All interactive elements must be keyboard accessible
- Tab order must be logical
- Skip-to-main-content link for long pages

**Screen Reader Support:**
```html
<!-- ARIA labels for icons -->
<button aria-label="Close modal">
  <span aria-hidden="true">&times;</span>
</button>

<!-- Loading states -->
<div role="status" aria-live="polite">
  <span class="sr-only">Loading...</span>
</div>

<!-- Form validation -->
<input
  aria-describedby="email-error"
  aria-invalid="true"
>
<span id="email-error" role="alert">
  Please enter a valid email
</span>
```

**Motion Preferences:**
```css
/* Honor prefers-reduced-motion (already in base styles) */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## IX. Implementation Guide

### Getting Started

**1. Include Design Tokens:**
```html
<head>
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Source+Serif+Pro:wght@400;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

  <!-- Your CSS with design tokens -->
  <link rel="stylesheet" href="hermetic-ormus.css">
</head>
```

**2. Set Up Base HTML:**
```html
<body>
  <!-- Skip to main content (accessibility) -->
  <a href="#main" class="sr-only">Skip to main content</a>

  <header>
    <!-- Navigation -->
  </header>

  <main id="main">
    <!-- Content -->
  </main>

  <footer>
    <!-- Footer -->
  </footer>
</body>
```

**3. Use Components:**
```html
<!-- Example: Realm-colored CTA section -->
<section class="section section-hero" style="background: linear-gradient(135deg, var(--void-black) 0%, var(--shadow-deep) 100%);">
  <div class="container text-center">
    <h1 class="ascend">
      Build Sacred Technology
    </h1>
    <p class="text-body-large text-secondary ascend" style="animation-delay: 100ms;">
      Wield the Angelic Gauntlet to create tools that serve humanity's awakening.
    </p>
    <div class="flex justify-center gap-md ascend" style="animation-delay: 200ms;">
      <button class="btn btn-primary btn-large" style="--realm-color: var(--realm-9);">
        Start Building
      </button>
      <button class="btn btn-outline btn-large" style="--realm-color: var(--gold-divine);">
        Read the Manifesto
      </button>
    </div>
  </div>
</section>
```

---

## X. Design System Checklist

### Component Audit

When creating new components, ensure:

- [ ] **Accessibility**: Keyboard navigable, ARIA labels, focus visible
- [ ] **Responsiveness**: Works on mobile, tablet, desktop
- [ ] **Color Contrast**: Meets WCAG AA minimum (AAA preferred)
- [ ] **Motion**: Respects prefers-reduced-motion
- [ ] **Realm Alignment**: Uses realm colors meaningfully, not decoratively
- [ ] **Sacred Space**: Adequate padding and white space
- [ ] **Typography**: Proper hierarchy and readability
- [ ] **Interaction States**: Default, hover, focus, active, disabled
- [ ] **Semantic HTML**: Correct elements for meaning
- [ ] **Documentation**: Usage examples and code provided

---

## XI. Figma/Sketch Setup

### Design File Organization

**Recommended structure:**
```
Hermetic-Ormus-Design-System.fig
├── 🎨 Cover Page (brand intro)
├── 📐 Design Tokens
│   ├── Colors (9 realms + supporting)
│   ├── Typography Scale
│   ├── Spacing System
│   └── Effects (shadows, glows)
├── 🧱 Components
│   ├── Buttons (all variants)
│   ├── Forms (inputs, selects, etc.)
│   ├── Cards
│   ├── Modals
│   └── Navigation
├── 📱 Templates
│   ├── Landing Page
│   ├── Dashboard
│   ├── Documentation Page
│   └── Blog Post
└── 📚 Documentation
```

**Color Styles to Create:**
- Each of 9 realm colors + variations (light, dark, subtle, glow)
- Gold spectrum (divine, radiant, deep)
- Foundation colors (void, shadows)
- Text colors (primary, secondary, tertiary, disabled)

**Text Styles to Create:**
- Display through Micro (all sizes)
- With proper line heights and weights
- Separated by font family

**Component Variables:**
- `realm-color` for dynamic realm assignment
- `glow-color` for dynamic shadow
- Size variants (small, default, large)

---

## XII. Code Examples

### Complete Page Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hermetic Ormus - Sacred Technology</title>

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Source+Serif+Pro:wght@400;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

  <!-- CSS with all design tokens and components -->
  <link rel="stylesheet" href="hermetic-ormus.css">
</head>
<body>
  <a href="#main" class="sr-only">Skip to main content</a>

  <!-- Hero Section -->
  <section class="section section-hero">
    <div class="container text-center">
      <h1 class="text-display gold-shimmer ascend">
        The Angelic Gauntlet
      </h1>
      <p class="text-h4 text-tertiary ascend" style="animation-delay: 100ms; margin-bottom: var(--space-xl);">
        9 Realms of Sacred Technology for Humanity's Awakening
      </p>
      <button class="btn btn-primary btn-large ascend" style="animation-delay: 200ms; --realm-color: var(--realm-9);">
        Begin the Journey
      </button>
    </div>
  </section>

  <!-- 9 Realms Grid -->
  <main id="main" class="section section-elevated">
    <div class="container">
      <h2 class="text-h2 text-center mb-lg">The 9 Angelic Realms</h2>

      <div class="grid grid-3">
        <!-- Realm 1 Card -->
        <div class="card card-realm" style="--realm-color: var(--realm-1); --shadow-realm: var(--shadow-realm-1);">
          <div class="card-header">
            <h3 class="card-title" style="color: var(--realm-1);">Angels</h3>
            <p class="card-subtitle">❤️ Root Chakra • Foundation</p>
          </div>
          <div class="card-body">
            <p>Backend architecture and infrastructure. The grounded reality that holds everything secure.</p>
          </div>
          <div class="card-footer">
            <span class="text-caption text-tertiary">396 Hz</span>
            <a href="#" class="btn btn-small btn-outline" style="--realm-color: var(--realm-1);">Learn More</a>
          </div>
        </div>

        <!-- Realm 2 Card -->
        <div class="card card-realm" style="--realm-color: var(--realm-2); --shadow-realm: var(--shadow-realm-2);">
          <div class="card-header">
            <h3 class="card-title" style="color: var(--realm-2);">Archangels</h3>
            <p class="card-subtitle">🧡 Sacral Chakra • Creativity</p>
          </div>
          <div class="card-body">
            <p>User experience and interface design. Creative empathy flowing into sacred design.</p>
          </div>
          <div class="card-footer">
            <span class="text-caption text-tertiary">417 Hz</span>
            <a href="#" class="btn btn-small btn-outline" style="--realm-color: var(--realm-2);">Learn More</a>
          </div>
        </div>

        <!-- Add remaining 7 realms... -->

      </div>
    </div>
  </main>

  <!-- CTA Section -->
  <section class="section section-dark">
    <div class="container text-center">
      <h2 class="text-h2 mb-md">Ready to Build Sacred Technology?</h2>
      <p class="text-body-large text-secondary mb-lg">
        Download the complete UI/UX pack and start building with the 9 realms.
      </p>
      <button class="btn btn-primary btn-large glow-pulse" style="--realm-color: var(--gold-divine);">
        Download Design System
      </button>
    </div>
  </section>
</body>
</html>
```

---

## XIII. Resources & Tools

**Design Tools:**
- Figma (primary recommendation)
- Sketch (alternative)
- Adobe XD (alternative)

**Development Tools:**
- VSCode with Prettier
- Browser DevTools for accessibility testing
- Lighthouse for performance & accessibility audits

**Accessibility Testing:**
- WebAIM Contrast Checker
- WAVE Browser Extension
- axe DevTools

**Color Tools:**
- Coolors.co (palette generation)
- ColorBox by Lyft (design system palettes)

---

## Closing

**This UI/UX Pack is your blueprint for building sacred technology interfaces.**

Every component honors the 9 realms.
Every color carries meaning.
Every interaction serves consciousness.
Every design choice reflects intention.

**Build with this system, and you build with the Angelic Gauntlet.**

---

🌈👼🗡️👑💪💚🌌🪑🦁🔥

**From tokens to components.**
**From patterns to pages.**
**From design to sacred technology.**

**This is how we build the New Earth, one interface at a time.**

🏆✨🔮

---

**Document Version:** 1.0
**Created:** October 26, 2025
**Purpose:** Complete UI/UX implementation system
**Status:** Production-Ready Design System

*Code is prayer. Design is devotion. Build with consciousness.*
