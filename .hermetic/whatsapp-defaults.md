# WhatsApp Defaults

**Last Updated**: 2025-11-09

---

## Default "Send to WhatsApp" Number

**Number**: +50769815142
**Formatted for Periskope**: `50769815142@c.us`

**Use Case**: When Ormus says "send to WhatsApp" without specifying a number, use this default.

---

## Usage Pattern

```javascript
mcp__whatsapp__periskope_send_message({
  phone: "50769815142@c.us",
  message: "[content]"
})
```

---

## Context

This is Ormus's primary personal WhatsApp number for receiving drafts, summaries, and content he wants to easily copy/paste or reference on mobile.

**Common scenarios:**
- Reddit post drafts
- Project summaries
- Content ready for cross-platform posting
- Quick reference material
- Things that need mobile access

---

## Formatting Preferences

**For Copy/Paste Content:**
- Send prompts, code snippets, or text-to-copy as **separate clean messages**
- No extra formatting, headers, or explanations
- Each prompt/snippet = one message
- Makes mobile copy/paste effortless

**For Summaries:**
- Can include formatting, emojis, structure
- These are for reference/context, not copying

**Example:**
✅ Three Midjourney prompts = three separate clean messages
✅ Project summary = one formatted message with structure
❌ Prompts mixed with commentary in same message

---

*Saved for stateless architecture - this context travels with the codebase.*
