# Architecture Design Workflow

**Purpose**: Design software systems that are scalable, maintainable, and aligned with values through conscious architectural decisions

**Hermetic Principles**: Mentalism, Correspondence, Cause-Effect, Polarity

**Estimated Time**: 4-12 hours (varies by system complexity)

**Prerequisites**:
- Clear understanding of requirements
- Knowledge of constraints (performance, budget, time)
- Familiarity with available technologies

---

## Philosophy

**Architecture is frozen decisions**. Bad architecture creates years of pain; good architecture enables years of growth.

This workflow uses:
1. **Mentalism**: Clear mental models before implementation
2. **Correspondence**: Architecture mirrors domain at all scales
3. **Cause-Effect**: Trace consequences before building
4. **Polarity**: Balance competing forces (speed vs quality, flexibility vs simplicity)

**"Architecture is about the important stuff - whatever that is."** - Ralph Johnson

---

## Phase 1: Understanding (2-4 hours)

### Step 1: Clarify the Problem (Mentalism)

**Before designing anything**, understand deeply what you're solving.

**Command**: `/gnosis "What problem does this system need to solve, and what are the core requirements?"`

**Example**:
```
/gnosis "We need a content management system for bloggers.
Requirements include: easy writing, media uploads, SEO, analytics,
and social sharing. 10K users initially, 100K in 2 years. Budget: modest.
What architectural considerations should guide my design?"
```

**Log usage**:
```bash
hm cmd gnosis "architecture: problem understanding"
```

**Questions to answer**:

**Functional Requirements**:
- What must the system do? (core features)
- Who are the users? (roles, permissions)
- What's the primary use case? (80% of usage)
- What's out of scope? (explicitly)

**Non-Functional Requirements**:
- **Scale**: How many users? How much data?
- **Performance**: What response times are acceptable?
- **Availability**: How much downtime is tolerable?
- **Security**: What data needs protection?
- **Cost**: What's the budget constraint?
- **Time**: When does this need to ship?

**Deliverable**: Requirements document (can be simple)

**Template**:
```markdown
# System Requirements

## Purpose
[One paragraph - what problem this solves]

## Users
- [User type 1]: [What they need]
- [User type 2]: [What they need]

## Core Features (Must Have)
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

## Nice to Have (Future)
- [Feature X]
- [Feature Y]

## Constraints
- Scale: [users, data, requests/sec]
- Performance: [response time requirements]
- Availability: [uptime requirement]
- Budget: [cost constraints]
- Time: [launch deadline]
- Security: [compliance, data sensitivity]

## Explicitly Out of Scope
- [Thing we're NOT building]
```

---

### Step 2: Understand the Domain (Mentalism + Correspondence)

**Map the problem domain conceptually**.

**Domain modeling**:
1. **Identify entities**: What are the "things" in this system?
2. **Identify relationships**: How do things relate?
3. **Identify behaviors**: What can things do?
4. **Identify rules**: What constraints exist?

**Example for blog CMS**:
```markdown
## Domain Model

### Entities
- **User**: Person using the system (blogger, reader, admin)
- **Post**: Blog article
- **Media**: Images, videos
- **Comment**: Reader feedback
- **Category**: Content organization
- **Analytics**: Usage data

### Relationships
- User (author) → writes → many Posts
- Post → has many → Media
- Post → belongs to → many Categories
- Post → has many → Comments
- User (reader) → writes → many Comments

### Behaviors
- User can create/edit/delete posts
- System generates SEO metadata automatically
- Analytics track views, shares
- Comments can be moderated

### Rules
- Posts can be draft, scheduled, or published
- Only author can edit their posts
- Media files limited to 10MB
- Free users: 10 posts/month; paid: unlimited
```

**Agent**: `backend-architect` or relevant domain expert

```
"backend-architect, help me model the domain for a blogging
CMS platform with these requirements: [requirements]"
```

**Log usage**:
```bash
hm agent backend-architect "architecture: domain modeling"
```

**Deliverable**: Domain model diagram (can be hand-drawn or digital)

---

### Step 3: Identify Architectural Drivers (Cause-Effect)

**What forces shape the architecture?**

**Quality attributes** (pick top 3-5):
- **Performance**: Sub-second page loads
- **Scalability**: Handle 100K users
- **Maintainability**: Solo developer can maintain
- **Security**: Protect user data
- **Cost**: Stay under $100/month
- **Time-to-market**: Ship in 6 weeks
- **Reliability**: 99% uptime
- **Usability**: Non-technical users
- **Flexibility**: Easy to add features

**Rank by priority**:
```markdown
## Architectural Drivers

### Critical (Top 3)
1. **Time-to-market**: Must launch in 6 weeks
   - Impact: Favors proven technologies, simple architecture

2. **Cost**: Must stay under $100/month
   - Impact: Serverless or cheap hosting, efficient design

3. **Maintainability**: Solo developer
   - Impact: Simple architecture, good documentation

### Important (Next 2)
4. **Scalability**: Handle 10x growth
   - Impact: Stateless design, database scaling strategy

5. **Performance**: Fast page loads
   - Impact: Caching strategy, CDN for media

### Nice to Have
- Security (important but standard practices sufficient)
- Flexibility (will refactor as needed)
```

**Principle of Polarity**: You cannot optimize for everything. Choose your battles.

---

## Phase 2: Design (3-6 hours)

### Step 4: Choose Architectural Style (Correspondence)

**Match architecture to problem characteristics**.

**Common styles**:

**Monolith** (all in one application):
- **Good for**: Simple systems, small teams, fast iteration
- **Bad for**: Large teams, independent scaling needs
- **Example**: Single Rails/Django/Laravel app

**Layered** (separation by technical function):
- **Good for**: Clear separation of concerns
- **Bad for**: Can become over-engineered
- **Example**: Presentation → Business Logic → Data Access

**Microservices** (separated by business capability):
- **Good for**: Large teams, independent deployment, scaling
- **Bad for**: Complexity, solo developers, tight deadlines
- **Example**: User Service + Post Service + Media Service

**Event-Driven** (communication via events):
- **Good for**: Async workflows, loose coupling
- **Bad for**: Debugging complexity, eventual consistency
- **Example**: User creates post → triggers SEO event → triggers notification event

**Serverless** (functions as a service):
- **Good for**: Low cost, automatic scaling, pay-per-use
- **Bad for**: Vendor lock-in, cold starts, debugging
- **Example**: API Gateway + Lambda functions + DynamoDB

**For our blog CMS example** (Time-to-market + Cost + Maintainability):
```markdown
## Chosen Style: Monolith with Serverless Functions

**Primary**: Monolithic web application
- Faster to build
- Easier to maintain solo
- Sufficient for initial scale

**Secondary**: Serverless for media processing
- Keep costs low
- Handle burst workloads (image uploads)
- Pay only when used

**Rationale**:
- Monolith gets us to market fast
- Serverless handles expensive operations cheaply
- Can split into microservices later if needed (YAGNI)
```

**Agent**: `backend-architect`

```
"backend-architect, recommend an architectural style for a blogging
CMS with these drivers: fast time-to-market, low cost, solo developer,
must scale to 100K users eventually"
```

---

### Step 5: Design System Components (Mentalism + Correspondence)

**Break system into logical components**.

**Component identification**:
- What are the major parts of the system?
- What does each part do?
- How do parts communicate?

**Blog CMS example**:
```markdown
## System Components

### Frontend
**Responsibility**: User interface
**Technology**: React (or similar)
**Interfaces**:
- Calls API for data
- Handles user input
- Renders pages

### API Layer
**Responsibility**: Business logic, data access
**Technology**: Node.js + Express (or similar)
**Interfaces**:
- REST endpoints for Frontend
- Calls Database for persistence
- Calls Media Service for uploads

### Database
**Responsibility**: Data persistence
**Technology**: PostgreSQL
**Stores**:
- Users, Posts, Comments, Categories
**Accessed by**: API Layer only

### Media Service
**Responsibility**: Image/video processing
**Technology**: AWS Lambda + S3
**Interfaces**:
- Upload endpoint
- Processing pipeline
- CDN for delivery

### Cache
**Responsibility**: Performance optimization
**Technology**: Redis
**Caches**:
- Rendered posts
- User sessions
- API responses

### Analytics
**Responsibility**: Usage tracking
**Technology**: Simple event logging → Processing
**Collects**:
- Page views
- User actions
- Performance metrics
```

**Create component diagram** (boxes and arrows):
```
┌─────────┐
│ Browser │
└────┬────┘
     │
     v
┌─────────┐     ┌───────┐     ┌──────────┐
│   CDN   │ ←── │ Media │ ←── │   API    │
└─────────┘     │ Service│     │  Layer   │
                └───────┘     └────┬─────┘
                                   │
                        ┌──────────┼───────────┐
                        │          │           │
                        v          v           v
                    ┌───────┐  ┌──────┐  ┌──────────┐
                    │ Cache │  │  DB  │  │Analytics │
                    └───────┘  └──────┘  └──────────┘
```

---

### Step 6: Design Data Model (Correspondence)

**Structure data to match domain**.

**Entity-Relationship Design**:

**Example**:
```sql
-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    role TEXT NOT NULL, -- 'free', 'paid', 'admin'
    created_at TIMESTAMP NOT NULL
);

-- Posts table
CREATE TABLE posts (
    id UUID PRIMARY KEY,
    author_id UUID REFERENCES users(id),
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    status TEXT NOT NULL, -- 'draft', 'scheduled', 'published'
    published_at TIMESTAMP,
    slug TEXT UNIQUE,
    seo_title TEXT,
    seo_description TEXT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Media table
CREATE TABLE media (
    id UUID PRIMARY KEY,
    post_id UUID REFERENCES posts(id),
    url TEXT NOT NULL,
    type TEXT NOT NULL, -- 'image', 'video'
    size INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Comments table (simplified)
CREATE TABLE comments (
    id UUID PRIMARY KEY,
    post_id UUID REFERENCES posts(id),
    author_id UUID REFERENCES users(id),
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);
```

**Indexes** (performance):
```sql
CREATE INDEX idx_posts_author ON posts(author_id);
CREATE INDEX idx_posts_published ON posts(published_at) WHERE status = 'published';
CREATE INDEX idx_comments_post ON comments(post_id);
```

**Agent**: `database-architect`

```
"database-architect, design a database schema for a blogging CMS
with users, posts, media, comments. Consider query patterns and scale."
```

**Log usage**:
```bash
hm agent database-architect "architecture: data model"
```

---

### Step 7: Design APIs / Interfaces (Correspondence)

**Define how components communicate**.

**API design principles**:
- **RESTful** (unless good reason not to be)
- **Consistent** (similar endpoints work similarly)
- **Versioned** (plan for changes)
- **Documented** (OpenAPI/Swagger)

**Example endpoints**:
```markdown
## API Design

### Authentication
POST   /api/v1/auth/register    - Create account
POST   /api/v1/auth/login       - Get JWT token
POST   /api/v1/auth/logout      - Invalidate token

### Posts
GET    /api/v1/posts            - List posts (paginated, filtered)
GET    /api/v1/posts/:id        - Get single post
POST   /api/v1/posts            - Create post (auth required)
PUT    /api/v1/posts/:id        - Update post (auth required)
DELETE /api/v1/posts/:id        - Delete post (auth required)

### Media
POST   /api/v1/media/upload     - Upload file (auth required)
GET    /api/v1/media/:id        - Get media info
DELETE /api/v1/media/:id        - Delete media (auth required)

### Comments
GET    /api/v1/posts/:id/comments    - List comments for post
POST   /api/v1/posts/:id/comments    - Create comment (auth required)
DELETE /api/v1/comments/:id          - Delete comment (auth required)
```

**Request/Response examples**:
```javascript
// POST /api/v1/posts
{
  "title": "My First Post",
  "content": "...",
  "status": "draft"
}

// Response
{
  "id": "uuid",
  "title": "My First Post",
  "content": "...",
  "status": "draft",
  "slug": "my-first-post",
  "createdAt": "2025-10-29T12:00:00Z"
}
```

---

### Step 8: Address Cross-Cutting Concerns (Cause-Effect)

**System-wide considerations**.

**Security**:
- Authentication: JWT tokens
- Authorization: Role-based (free/paid/admin)
- Data protection: HTTPS everywhere, encrypted passwords
- Input validation: All user input sanitized
- Rate limiting: Prevent abuse

**Performance**:
- Caching: Redis for rendered posts, user sessions
- CDN: Static assets and media
- Database: Proper indexes, query optimization
- Async: Media processing in background

**Reliability**:
- Error handling: Graceful degradation
- Logging: Structured logs for debugging
- Monitoring: Uptime, error rates, performance
- Backups: Daily database backups

**Scalability**:
- Stateless API: Can add more servers
- Database: Read replicas if needed
- Media: S3 + CloudFront scales automatically
- Caching: Reduces database load

**Agent**: `security-engineer`

```
"security-engineer, review this architecture for a blogging CMS.
What security considerations am I missing?"
```

**Log usage**:
```bash
hm agent security-engineer "architecture: security review"
```

---

## Phase 3: Validation & Documentation (1-2 hours)

### Step 9: Validate Against Requirements (Cause-Effect)

**Does this architecture actually solve the problem?**

**Validation checklist**:

**Functional**:
- [ ] Supports all core features
- [ ] Handles identified user roles
- [ ] Scales to required user count
- [ ] Meets performance requirements

**Non-Functional**:
- [ ] Can be built in time constraint
- [ ] Stays within budget
- [ ] Maintainable by available team
- [ ] Secure enough for data sensitivity
- [ ] Reliable enough for use case

**Trade-offs documented**:
- What did we sacrifice?
- Why was it acceptable?
- When might we revisit?

**Example**:
```markdown
## Validation

### Requirements Met
✓ Fast time-to-market: Simple monolith is fastest path
✓ Low cost: Serverless media + cheap hosting = <$100/month
✓ Solo maintainable: Standard stack, good docs
✓ Scales to 100K: Stateless API, database can scale
✓ Good performance: Caching + CDN = fast loads

### Trade-offs Made
- **Chose monolith over microservices**
  - Sacrifice: Can't scale components independently
  - Gain: Faster development, easier maintenance
  - Revisit when: Team grows or distinct scaling needs emerge

- **Chose relational DB over NoSQL**
  - Sacrifice: Slightly slower for some read patterns
  - Gain: ACID guarantees, easier to query
  - Revisit when: Query patterns clearly favor document model
```

**Command**: `/verify "Architecture meets all critical requirements"`

---

### Step 10: Document the Architecture (Mentalism)

**Future you will thank current you**.

**Architecture Decision Records (ADRs)**:

**Template**:
```markdown
# ADR: [Decision Title]

**Date**: [When decided]
**Status**: [Proposed | Accepted | Deprecated | Superseded]

## Context
[What circumstances led to this decision?]

## Decision
[What did we decide to do?]

## Consequences
**Positive**:
- [Good outcome 1]
- [Good outcome 2]

**Negative**:
- [Trade-off 1]
- [Trade-off 2]

## Alternatives Considered
- **[Alternative 1]**: [Why we didn't choose this]
- **[Alternative 2]**: [Why we didn't choose this]
```

**Example**:
```markdown
# ADR-001: Use Monolithic Architecture

**Date**: 2025-10-29
**Status**: Accepted

## Context
Building a blogging CMS with constraints: 6-week timeline, $100/month budget, solo developer, need to scale to 100K users eventually.

## Decision
Use a monolithic web application with serverless functions for media processing.

## Consequences
**Positive**:
- Faster development (can iterate quickly)
- Simpler deployment (one application)
- Lower operational complexity (easier to debug)
- Cheaper initially (single server)

**Negative**:
- Cannot scale components independently
- Larger codebase to understand
- Deployment is all-or-nothing

## Alternatives Considered
- **Microservices**: Too complex for solo developer, slower to build
- **Fully serverless**: Cold start issues, harder to debug
```

**Create architecture documentation**:
```markdown
# [System Name] Architecture

## Overview
[2-3 paragraphs explaining the system]

## Architectural Drivers
[Top 3-5 quality attributes and why]

## System Components
[Component diagram + descriptions]

## Data Model
[ER diagram + key entities]

## API Design
[Key endpoints and contracts]

## Cross-Cutting Concerns
[Security, performance, reliability strategies]

## Deployment
[How the system is deployed and hosted]

## Architecture Decision Records
- [ADR-001: Major Decision 1]
- [ADR-002: Major Decision 2]

## Future Considerations
[Known limitations and when to revisit]
```

---

## Phase 4: Review & Iteration (Optional)

### Step 11: Get Expert Review (Gold Hat)

**Humble architecture review**.

**Who to ask**:
- Senior engineers on your team
- Domain experts
- Security specialists (for sensitive systems)
- Operations/DevOps (for deployment complexity)

**Agent**: Multiple domain experts

```
"backend-architect, review this architecture and identify
potential issues or improvements"

"security-engineer, review for security considerations"

"devops-automator, review for deployment and operational concerns"
```

**Log usage**:
```bash
hm agent backend-architect "architecture: review"
hm agent security-engineer "architecture: review"
```

**Questions for reviewers**:
- What am I missing?
- What will break first?
- What would you do differently?
- What's the biggest risk?

**Integrate feedback thoughtfully** (not blindly).

---

### Step 12: Prototype / Spike (Vibration)

**Before committing, validate risky assumptions**.

**When to spike**:
- Unfamiliar technology
- Performance unknowns
- Integration complexity
- Significant risk

**Spike scope**:
- Time-boxed (2-4 hours max)
- Focused (one question)
- Disposable (throwaway code)
- Learning goal (de-risk decision)

**Example**:
```
Spike: "Can serverless image processing handle our expected load?"

Time: 2 hours
Build: Simple Lambda that processes images
Test: Upload 100 images, measure time and cost
Learn: Yes, costs ~$5 for 10K images, latency acceptable
Decision: Proceed with serverless for media
```

**Agent**: `rapid-prototyper`

```
"rapid-prototyper, create a quick spike to test if serverless
image processing can handle our load requirements"
```

---

## Success Metrics

**Good Architecture Indicators**:
- [ ] Team understands it (can explain to others)
- [ ] Meets functional requirements
- [ ] Meets non-functional requirements
- [ ] Trade-offs are conscious and documented
- [ ] Can be built in available time/budget
- [ ] Flexible enough for known future needs
- [ ] Not over-engineered (YAGNI - You Aren't Gonna Need It)

**Red Flags** (warning signs):
- No one fully understands it
- Requires 10x the time/budget
- Optimized for hypothetical future
- Copies "big tech" without their scale
- No documented trade-offs
- Reviewer finds obvious flaws

---

## Common Pitfalls

### ❌ Premature Optimization
**Symptom**: Designing for Netflix scale when you have 100 users
**Consequence**: Over-engineered, slow to build, expensive
**Fix**: Design for 10x current scale, not 1000x

### ❌ Resume-Driven Development
**Symptom**: Choosing tech because it's trendy, not because it fits
**Consequence**: Complexity without benefit
**Fix**: Choose boring technology that solves the problem

### ❌ Architecture Astronaut
**Symptom**: Abstract, perfect, theoretical architecture
**Consequence**: Never ships, impractical
**Fix**: Validate with prototypes, focus on solving actual problem

### ❌ Not Documenting Decisions
**Symptom**: No record of why choices were made
**Consequence**: Future team repeats mistakes, questions decisions
**Fix**: ADRs for all major decisions

### ❌ Ignoring Non-Functional Requirements
**Symptom**: Only designing for features
**Consequence**: Doesn't scale, insecure, slow
**Fix**: Explicitly address performance, security, etc.

### ❌ No Review
**Symptom**: Design in isolation, ship without feedback
**Consequence**: Miss obvious issues
**Fix**: Get architecture reviewed by experts

---

## Architecture Patterns Library

**Quick reference for common patterns**:

**Caching**:
- Cache-aside (lazy loading)
- Write-through (cache updated with DB)
- Write-behind (async cache updates)

**Database**:
- Read replicas (scale reads)
- Sharding (partition data)
- CQRS (separate read/write models)

**Communication**:
- REST (synchronous HTTP)
- Message queues (async communication)
- Event streaming (real-time data)

**Scaling**:
- Vertical (bigger servers)
- Horizontal (more servers)
- Auto-scaling (dynamic)

**Reliability**:
- Circuit breaker (fail fast)
- Retry with exponential backoff
- Bulkhead (isolate failures)

---

## Effectiveness Tracking

**After architecture design**:

```bash
hm rate workflow architecture-design 5
hm rate agent backend-architect 5
hm rate agent database-architect 4
hm rate agent security-engineer 5
```

**Track over time**:
- How often do architectural decisions need to change?
- Are we consistently over/under-engineering?
- Do new features fit the architecture?
- What's the operational complexity?

---

**Workflow Version**: 1.0.0
**Hermetic Principles**: Mentalism, Correspondence, Cause-Effect, Polarity
**Effectiveness**: Track with `hm rate workflow architecture-design <1-5>`

*"Good architecture is pragmatic, not perfect. Design for reality, not résumés."*
