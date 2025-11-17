# Knowledge Sharing Workflow

**Purpose**: Document and share knowledge effectively to empower others and cement your own understanding

**Hermetic Principles**: Mentalism, Correspondence, Gold Hat (Empowerment)

**Estimated Time**: 2-8 hours per knowledge artifact

**Prerequisites**:
- Knowledge worth sharing
- Understanding of audience
- Intention to teach (not just show off)

---

## Philosophy

**"To teach is to learn twice."** - Joseph Joubert

Knowledge sharing embodies:
1. **Mentalism**: Teaching forces clarity of thought
2. **Correspondence**: Good explanations connect new to known
3. **Gold Hat**: Empowering others, not gatekeeping
4. **Cause-Effect**: Sharing knowledge creates compounding returns

**Key insight**: Knowledge shared is knowledge amplified. Hoarding knowledge diminishes you; sharing it elevates everyone.

---

## Phase 1: Preparation (1-2 hours)

### Step 1: Clarify What You Know (Mentalism)

**Before teaching, understand deeply**.

**Command**: `/gnosis "What do I really understand about [topic]?"`

**Example**:
```
/gnosis "I want to share what I learned about React hooks.
Do I understand them deeply enough to teach? What gaps remain?"
```

**Log usage**:
```bash
hm cmd gnosis "knowledge-share: understanding check"
```

**Self-Test Questions**:
1. **Can I explain it simply?** (Einstein test)
2. **Can I answer "why" questions?** (Not just "how")
3. **Do I know the edge cases?** (Where it breaks)
4. **Can I connect it to what others know?** (Correspondence)
5. **Have I used it in practice?** (Experience, not just theory)

**If gaps exist**: Fill them before teaching. Nothing worse than teaching wrong information.

---

### Step 2: Understand Your Audience (Correspondence)

**Who are you teaching?** Different audiences need different approaches.

**Audience Analysis**:

**Beginner**:
- Needs: Basics, motivation, simple examples
- Avoid: Jargon, advanced concepts, assumptions of prior knowledge
- Start with: "Why this matters" + "Simple mental model"

**Intermediate**:
- Needs: Deeper understanding, best practices, real-world application
- Avoid: Treating them like beginners, skipping important nuances
- Start with: Quick basics review + "Here's what you might not know"

**Advanced**:
- Needs: Nuances, edge cases, performance, alternatives
- Avoid: Over-explanation of basics, lack of depth
- Start with: Assumptions stated + "Deep dive into..."

**Example**:
```markdown
# Audience Profile

**Who**: Junior developers learning React
**Current Level**: Know JavaScript, new to React
**What they know**: HTML, CSS, basic JS
**What they don't know**: React concepts, JSX, component lifecycle
**Learning goal**: Build their first React app
**Best format**: Step-by-step tutorial with working examples
```

---

### Step 3: Choose the Right Format (Mentalism)

**Match format to content and audience**.

**Format Options**:

**Written Content**:
- **Blog Post**: Explain concept, share experience (1-2K words)
- **Tutorial**: Step-by-step guide to build something (2-5K words)
- **Documentation**: Reference material, API docs (varies)
- **Cheat Sheet**: Quick reference, common patterns (1 page)
- **README**: Project intro, getting started (500-1K words)

**Visual Content**:
- **Slides**: Presentation, high-level overview (10-30 slides)
- **Diagrams**: Architecture, data flow, relationships
- **Infographic**: Visual summary of process/concept
- **Screenshots**: UI walkthroughs, tool usage

**Interactive Content**:
- **Video Tutorial**: Screen capture with narration (10-30 min)
- **Live Coding**: Build something in real-time (30-60 min)
- **Workshop**: Hands-on practice with audience (2-4 hours)
- **Code Examples**: Working repository to explore

**Decision Matrix**:
```
Complex concept → Blog post + diagrams
Step-by-step process → Tutorial or video
Quick reference → Cheat sheet
Tool usage → Screenshots + short text
Architecture → Diagrams + written explanation
Hands-on skill → Workshop or live coding
```

---

## Phase 2: Creation (2-6 hours)

### Step 4: Structure Your Content (Correspondence)

**Good teaching has clear structure**.

**Universal Structure**:

**1. Hook (Why should I care?)**
- Problem this solves
- Pain point this addresses
- Opportunity this enables

**2. Foundation (What do I need to know first?)**
- Prerequisites
- Core concepts
- Mental model

**3. Core Content (The actual knowledge)**
- Main explanation
- Examples
- Common patterns

**4. Practice (How do I apply this?)**
- Exercises
- Real-world examples
- Guided practice

**5. Advanced (What's next?)**
- Edge cases
- Best practices
- Further learning

**6. Summary (What should I remember?)**
- Key takeaways (3-5 points)
- Next steps
- Resources

**Agent**: `content-creator`

```
"content-creator, help me outline a tutorial on React hooks
for developers who know JavaScript but are new to React"
```

**Log usage**:
```bash
hm agent content-creator "knowledge-share: structure"
```

---

### Step 5: Write/Create with Clarity (Mentalism)

**Principles of clear teaching**:

**A: Start Simple**
- Explain core concept in simplest terms first
- Add complexity gradually
- "If you can't explain it simply, you don't understand it well enough" - Einstein

**B: Use Examples**
- Show, don't just tell
- Real-world scenarios
- Working code (test it!)

**C: Explain the "Why"**
- Not just "what" and "how"
- Why it matters
- Why this approach over alternatives

**D: Connect to Known (Correspondence)**
- "Like X you already know, but..."
- Analogies and metaphors
- Bridge from familiar to new

**E: Anticipate Questions**
- "You might be wondering..."
- Common misconceptions
- FAQ section

**F: Make It Scannable**
- Clear headings
- Short paragraphs (3-5 sentences)
- Bullet points
- Code blocks with syntax highlighting

**Example - Bad vs Good**:

**❌ Bad**:
```
React hooks are functions that let you use state and
lifecycle features in functional components. useState
returns an array with the current state and a function
to update it.
```

**✓ Good**:
```
## Why Hooks Matter

Before hooks, you needed class components to use state.
This meant more boilerplate and complexity.

Hooks let you use state in simple functions. Here's how:

```javascript
// Before (class component) - verbose
class Counter extends React.Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  render() {
    return (
      <button onClick={() => this.setState({ count: this.state.count + 1 })}>
        Count: {this.state.count}
      </button>
    );
  }
}

// After (hooks) - simple
function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

Much cleaner! The useState hook gives you:
1. Current state value (count)
2. Function to update it (setCount)

Think of it like a variable that React watches and re-renders when it changes.
```

---

### Step 6: Add Working Examples (Vibration)

**Examples must work**. Nothing breaks trust faster than broken code.

**Example Requirements**:
- **Complete**: Can copy-paste and run
- **Tested**: You've actually run it
- **Minimal**: No unnecessary complexity
- **Commented**: Explain key parts
- **Progressive**: Build from simple to complex

**Example Template**:
```markdown
### Example: [What it demonstrates]

**Goal**: [What the reader will learn]

**Code**:
```[language]
[actual working code with comments]
```

**Explanation**:
[Walk through the code, line by line if needed]

**Try it**:
[How to run this yourself]

**Expected Output**:
```
[What they should see]
```

**Common Issues**:
- [Problem 1]: [Solution]
- [Problem 2]: [Solution]
```

**Agent**: `rapid-prototyper` or domain expert

```
"rapid-prototyper, create a minimal working example
demonstrating React hooks for state management"
```

**Log usage**:
```bash
hm agent rapid-prototyper "knowledge-share: examples"
```

---

### Step 7: Visual Enhancement (Correspondence)

**A picture is worth 1,000 words** - when it's the right picture.

**Useful Visuals**:

**Diagrams** (when to use):
- Architecture / system design
- Data flow
- Relationships between concepts
- Process flows

**Screenshots** (when to use):
- UI walkthroughs
- Tool configuration
- Results to expect

**Code Annotations** (when to use):
- Highlighting specific lines
- Showing before/after
- Comparing approaches

**Infographics** (when to use):
- Summary of concepts
- Decision trees
- Comparison matrices

**Agent**: `visual-storyteller`

```
"visual-storyteller, help me create a diagram showing how
React hooks lifecycle works compared to class components"
```

**Log usage**:
```bash
hm agent visual-storyteller "knowledge-share: visuals"
```

**Tools**:
- Diagrams: Excalidraw, draw.io, Mermaid
- Screenshots: Built-in OS tools
- Code annotations: Carbon, CodeSnap
- Infographics: Canva, Figma

---

## Phase 3: Polish & Publish (1-2 hours)

### Step 8: Review for Quality (Mentalism + Cause-Effect)

**Before publishing, review rigorously**.

**Quality Checklist**:

**Content**:
- [ ] Accurate (all facts checked)
- [ ] Complete (covers what you promised)
- [ ] Clear (audience can understand)
- [ ] Useful (audience can apply it)

**Structure**:
- [ ] Logical flow (one concept builds on previous)
- [ ] Clear headings (scannable)
- [ ] Good examples (working, tested)
- [ ] Summary/takeaways (reinforcement)

**Writing**:
- [ ] Concise (no fluff)
- [ ] Active voice (not passive)
- [ ] Simple words (not needlessly complex)
- [ ] Proofread (no typos, grammar issues)

**Code**:
- [ ] Works (tested personally)
- [ ] Minimal (no unnecessary complexity)
- [ ] Commented (key parts explained)
- [ ] Formatted (consistent style)

**Visuals**:
- [ ] Clear (easy to understand)
- [ ] Necessary (not decorative)
- [ ] Accessible (alt text if web)

**Agent**: `code-reviewer` or `content-creator`

```
"code-reviewer, review this tutorial I've written about React hooks.
Check for accuracy, clarity, and completeness."
```

**Log usage**:
```bash
hm agent code-reviewer "knowledge-share: review"
```

---

### Step 9: Test with Real User (Cause-Effect)

**Before wide release, test with one person**.

**Beta Reader Process**:
1. **Choose tester**: Someone from target audience
2. **Ask them to follow**: Watch them go through it
3. **Don't help**: See where they get stuck
4. **Gather feedback**:
   - What was clear?
   - What was confusing?
   - What's missing?
   - What worked well?

5. **Revise based on feedback**

**Questions for tester**:
- Could you complete the tutorial?
- Where did you get stuck?
- What would make it clearer?
- What did you learn?
- Would you recommend this to others?

**Gold Hat principle**: If even one person gets confused, improve it. We're empowering, not gatekeeping.

---

### Step 10: Publish & Share (Vibration)

**Ship it**. Knowledge hoarded is knowledge wasted.

**Publishing Platforms**:

**Written Content**:
- Personal blog (full control)
- Medium, Dev.to, Hashnode (built-in audience)
- GitHub README (for code projects)
- Company blog (with permission)
- Documentation site (for projects)

**Video Content**:
- YouTube (largest audience)
- Vimeo (higher quality)
- Loom (quick screencasts)

**Code Examples**:
- GitHub repository
- CodeSandbox, CodePen (interactive)
- Gists (snippets)

**Presentations**:
- SlideShare, Speaker Deck (slides)
- YouTube (recorded presentation)
- Conference submissions (in-person)

**Sharing**:
- Twitter/X (tech community)
- Reddit (relevant subreddit)
- LinkedIn (professional)
- Discord/Slack communities
- Email newsletter

**Agent**: `content-creator` for publishing guidance

```
"content-creator, recommend the best platforms to share
a React hooks tutorial for junior developers"
```

---

## Phase 4: Engagement & Iteration (Ongoing)

### Step 11: Engage with Feedback (Gold Hat)

**Your audience will teach you**.

**Respond to**:
- **Questions**: Answer thoughtfully, update content if common
- **Corrections**: Thank them, fix errors quickly
- **Improvements**: Consider suggestions, credit contributors
- **Criticism**: Separate constructive from trolling

**Good response template**:
```
Thanks for reading! Great question about [topic].

[Answer to their question]

You're right that I should clarify this in the article.
I've updated the [section] to address this.

Appreciate the feedback!
```

**Log engagement**:
```bash
hm agent feedback-synthesizer "knowledge-share: engagement"
```

---

### Step 12: Update Over Time (Rhythm)

**Knowledge evolves**. Keep content current.

**Update schedule**:
- **Immediately**: Fix errors, broken links
- **Quarterly**: Check if still accurate
- **Yearly**: Refresh examples, update for new versions
- **As needed**: Major changes in technology

**Update note template**:
```markdown
> **Updated**: [Date]
> **Changes**: [What was updated and why]
```

**Retire when**:
- Technology obsolete
- Better resources exist
- You no longer can maintain accuracy

**Retirement note**:
```markdown
> **Note**: This content is archived. Technology has changed.
> **Current resource**: [Link to updated material]
```

---

## Success Metrics

**Immediate (Day 1)**:
- [ ] Content published
- [ ] Free of errors
- [ ] Examples work
- [ ] Feedback mechanisms in place

**Short-term (Week 1)**:
- [ ] Audience found it useful (positive feedback)
- [ ] No major corrections needed
- [ ] Shared in relevant communities
- [ ] At least 10 people engaged

**Long-term (Month 1+)**:
- [ ] Helping people (evidenced by thank-yous)
- [ ] Referenced by others
- [ ] Improved based on feedback
- [ ] Compounding value (continuous views/uses)

**Gold Hat Metrics**:
- [ ] Empowered others (they can now do the thing)
- [ ] No gatekeeping (accessible to beginners)
- [ ] Clear and honest (no confusion or deception)
- [ ] Free or fairly priced (not exploitative)

---

## Common Pitfalls

### ❌ Assuming Knowledge
**Symptom**: "It's obvious that..." or skipping basics
**Consequence**: Audience can't follow
**Fix**: Define all terms, assume nothing

### ❌ Tutorial Hell Creation
**Symptom**: Too many trivial tutorials, no depth
**Consequence**: Quantity over quality, no real value
**Fix**: Teach concepts, not just copy-paste steps

### ❌ Broken Examples
**Symptom**: Code doesn't work, screenshots outdated
**Consequence**: Lost trust, frustration
**Fix**: Test everything before publishing

### ❌ Writing for Yourself
**Symptom**: Content you wish existed when you started
**Consequence**: May not match actual audience needs
**Fix**: Validate with real audience member

### ❌ No Follow-Up
**Symptom**: Publish and ghost
**Consequence**: Miss valuable feedback, errors persist
**Fix**: Engage with audience, iterate

### ❌ Perfectionism
**Symptom**: Never publish because "not good enough"
**Consequence**: Knowledge never shared
**Fix**: Vibration principle - ship imperfect, improve

---

## Content Type Guides

### Blog Post Tutorial

**Structure**:
1. **Title**: "[Action] [Result] with [Technology]"
   - Example: "Build a Real-Time Chat with React Hooks"

2. **Introduction** (100-200 words):
   - What you'll build
   - What you'll learn
   - Prerequisites

3. **Setup** (200-300 words):
   - Tools needed
   - Starting code
   - Environment prep

4. **Implementation** (1000-2000 words):
   - Step-by-step with code
   - Explanation of each step
   - Why you're doing it this way

5. **Enhancement** (300-500 words):
   - Improvements to try
   - Edge cases to handle
   - Production considerations

6. **Conclusion** (100-200 words):
   - What you built
   - What you learned
   - Next steps

**Total**: 1,700-3,200 words

---

### Technical Talk/Presentation

**Structure**:
1. **Title Slide**: Compelling title + your name
2. **Who Am I**: 1 slide, brief, relevant credentials
3. **Problem**: 2-3 slides, what pain this addresses
4. **Solution Overview**: 1 slide, high-level approach
5. **Deep Dive**: 10-15 slides, core content
6. **Demo**: Live or video, the thing working
7. **Takeaways**: 1 slide, 3-5 key points
8. **Resources**: 1 slide, where to learn more
9. **Questions**: "Questions?" slide

**Timing**: 20-30 min including questions

**Tips**:
- More visuals, less text
- One concept per slide
- Tell a story, don't just present facts
- Practice 3+ times

---

### Code Repository README

**Structure**:
```markdown
# Project Name

One-line description of what it does.

## Why This Exists

What problem it solves.

## Quick Start

```bash
# Installation
[commands]

# Usage
[basic example]
```

## Features

- Feature 1
- Feature 2
- Feature 3

## Documentation

- [Link to full docs]
- [Link to API reference]
- [Link to examples]

## Contributing

How to contribute (if open source).

## License

License type.
```

---

### Cheat Sheet

**Structure**:
- **Title**: [Technology] Cheat Sheet
- **Sections**: 4-6 common tasks
- **Format**: Command/code + brief explanation
- **Length**: 1-2 pages max
- **Goal**: Quick reference, not tutorial

**Example**:
```markdown
# Git Cheat Sheet

## Common Commands

```bash
git status              # Check current status
git add <file>          # Stage file for commit
git commit -m "message" # Commit with message
git push                # Push to remote
```

## Branching

```bash
git branch <name>       # Create branch
git checkout <name>     # Switch to branch
git merge <name>        # Merge branch
```

[etc...]
```

---

## Effectiveness Tracking

**After creating content**:

```bash
# Log the activity
hm agent content-creator "knowledge-share: tutorial"

# Rate effectiveness
hm rate agent content-creator 5
hm rate workflow knowledge-share 5
```

**Track metrics**:
- Views/reads
- Positive feedback
- Questions answered
- People helped
- Content referenced elsewhere

**Review monthly**:
- What content is most useful?
- What needs updating?
- What should I create next?

---

## Integration with Other Workflows

**After learning** (learn-technology.md):
→ Share what you learned

**After skill improvement** (skill-improvement.md):
→ Teach the skill to others

**After fixing tricky bug** (bug-fixing.md):
→ Write post-mortem / "How I fixed X"

**After building feature** (feature-implementation.md):
→ Document architecture decisions

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Correspondence, Gold Hat (Empowerment)
**Effectiveness**: Track with `hm rate workflow knowledge-share <1-5>`

*"Teaching is the highest form of understanding. Share to empower, not to impress."*
