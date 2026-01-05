# Design Decisions

This document tracks major design decisions made during the development of Schrödinger's Catpocalypse, including the rationale behind each choice and alternative options considered.

## Table of Contents

- [Game Design](#game-design)
- [Technical Design](#technical-design)
- [Content Design](#content-design)
- [Future Decisions](#future-decisions)

---

## Game Design

### ✅ DD-001: Non-Lethal Combat System

**Decision**: All cat interactions are non-lethal. Cats are distracted, not destroyed.

**Date**: January 2026

**Rationale**:
- Maintains the comedy-horror tone without crossing into cruelty
- Cats are adorable antagonists, not monsters to eliminate
- Creates unique gameplay: "defeat" through distraction/avoidance
- Aligns with the theme that cats are victims of the phenomenon

**Alternatives Considered**:
1. ❌ Lethal combat → Too dark, conflicts with "cute" theme
2. ❌ Capture system → Too complex for intro sequence
3. ✅ Distraction/deterrent system → Perfect balance

**Implications**:
- Weapons renamed to "tools" or "items"
- Victory conditions based on escape/survival, not elimination
- Cat behavior: temporarily distracted, not permanently removed
- Enables cats to return to normal state post-game

---

### ✅ DD-002: First-Person Perspective

**Decision**: Game uses first-person view throughout.

**Date**: January 2026

**Rationale**:
- Maximizes immersion in the horror-comedy experience
- Better emotional connection to cozy apartment atmosphere
- Enhances tension when cats attack (can't see behind you)
- Standard for modern horror and immersive sims
- Easier to implement interaction raycast system

**Alternatives Considered**:
1. ❌ Third-person → Less immersive, harder to convey intimacy
2. ❌ Hybrid system → Complexity without clear benefit
3. ✅ First-person only → Clear winner

**Implications**:
- Need robust camera controller with head bob, smoothing
- UI must be diegetic or minimalist HUD
- Cat attacks are more startling (can't see them approach from sides)
- Animation system focused on first-person hands/items

---

### ✅ DD-003: Conversion Mechanic (One Lick = Loss)

**Decision**: Single successful cat lick converts player into a cat (game over/transformation).

**Date**: January 2026

**Rationale**:
- High stakes create immediate tension
- Aligns with "Schrödinger's" quantum theme (binary state change)
- Simple, clear failure condition
- Encourages cautious, thoughtful play
- Makes every encounter meaningful

**Alternatives Considered**:
1. ❌ Health system → Less unique, reduces tension to numbers
2. ❌ Infection buildup → Too complex for opening sequence
3. ❌ Three-strike system → Reduces stakes, harder to balance
4. ✅ One-lick conversion → Highest tension, clearest mechanic

**Implications**:
- Game must have frequent checkpoints/respawns
- Cat attacks need clear telegraphing (fair play)
- Encourages avoidance over confrontation
- Tutorial must clearly communicate this rule

**Open Questions**:
- Post-conversion: respawn? Continue as cat? New player character?
- Does conversion animation show transformation?
- Can roommate save you with a spray bottle?

---

### ✅ DD-004: Dual-State Cat Behavior

**Decision**: Cats alternate between "cute" and "deadly" modes with visual/audio tells.

**Date**: January 2026

**Rationale**:
- Core theme: cats are simultaneously adorable and dangerous
- Creates psychological tension (player WANTS to pet them)
- Differentiates from typical horror enemies
- Enables comedic moments amid horror
- Makes player question reality ("Is my cat actually attacking me?")

**Alternatives Considered**:
1. ❌ Always hostile → Loses comedy and charm
2. ❌ Random switching → Frustrating, feels unfair
3. ✅ Predictable behavioral cues → Gameplay depth

**Behavioral States**:
```
Cute Mode:
- Slow movements
- Purring sounds
- Approach player for pets
- Can be temporarily interacted with
- Vulnerable to distractions

Deadly Mode:
- Rapid movements
- Glitchy vocalizations
- Hunt/stalk behavior
- Will attempt to lick/convert
- Harder to distract
```

**Implications**:
- Need clear visual indicators (eye glow, posture, particle effects)
- Audio cues must be distinct and recognizable
- AI state machine must support smooth transitions
- Tutorial must teach players to recognize the difference

---

### ✅ DD-005: Opening Sequence Structure (3 Acts)

**Decision**: Opening follows three-act structure: Cozy → Uncanny → Chaos.

**Date**: January 2026

**Rationale**:
- Emotional journey: comfort → confusion → panic
- Establishes world before breaking it
- Gives players time to learn controls in safe environment
- Makes the "shift" more impactful through contrast
- Mirrors classic horror structure (calm before storm)

**Act Breakdown**:
```
Act 1: Morning Routine (5-10 min)
- Free exploration
- Learn interaction controls
- Bond with cat
- Establish normalcy

Act 2: The Shift (2-3 min)
- News broadcasts (exposition)
- Cat behavioral change
- Growing unease
- Environmental tells (lights flicker)

Act 3: Survival (Tutorial)
- First cat attack
- Item system introduction
- Escape objective
- Roommate dialogue
```

**Alternatives Considered**:
1. ❌ Start with action → No emotional baseline
2. ❌ Extended cozy section → Player impatience
3. ✅ Three-act structure → Proven storytelling

**Implications**:
- Act 1 must be engaging despite low action
- Pacing must prevent boredom in Act 1
- Act 2 transition needs strong audiovisual signals
- Act 3 must teach mechanics without breaking immersion

---

## Technical Design

### 🔄 DD-006: Component-Based Architecture (ECS)

**Decision**: Use Entity-Component-System pattern for game objects.

**Date**: January 2026

**Status**: Tentative (engine-dependent)

**Rationale**:
- Flexibility: Easy to add/remove behaviors
- Performance: Data-oriented design
- Maintainability: Clear separation of concerns
- Scalability: Can optimize systems independently

**Alternatives Considered**:
1. ❌ Object-oriented hierarchy → Inheritance complexity
2. ❌ Pure procedural → Harder to maintain
3. ✅ ECS → Modern game dev standard

**Implications**:
- Requires engine with good ECS support (Godot 4.x, Unity DOTS, Bevy)
- Steeper learning curve for contributors
- Better performance for many cats on screen
- Easier to implement modding system later

**Notes**: Final decision depends on engine selection (see ADR-001).

---

### ✅ DD-007: Event-Driven Communication

**Decision**: Systems communicate via event bus rather than direct coupling.

**Date**: January 2026

**Rationale**:
- Decoupling: Systems don't need to know about each other
- Flexibility: Easy to add new event listeners
- Debugging: Can log all events centrally
- Testability: Can mock event producers/consumers

**Example**:
```
❌ Direct coupling:
catAI.OnAttack() → player.TakeDamage() → ui.UpdateHealth()

✅ Event-driven:
catAI.OnAttack() → EventBus.Emit(CAT_ATTACK_EVENT)
                 ↳ Player listens → takes damage
                 ↳ UI listens → updates display
                 ↳ Audio listens → plays sound
                 ↳ Analytics listens → logs event
```

**Implications**:
- Need robust event bus implementation
- Must prevent event spaghetti (document all events)
- Slight performance overhead (negligible for this game)
- Easier to implement replay/demo system later

---

### 🔄 DD-008: Save System Approach

**Decision**: Checkpoint-based saves with optional manual saves.

**Date**: January 2026

**Status**: To be finalized

**Rationale**:
- Automatic checkpoints prevent frustration (one-lick death)
- Manual saves give player control
- Simpler than continuous autosave
- Fits linear narrative structure

**Checkpoint Locations**:
- After each major story beat
- Before each cat encounter
- After acquiring new items
- Room transitions

**Alternatives Considered**:
1. ❌ Save anywhere → Can break cinematic pacing
2. ❌ Autosave only → Less player agency
3. ✅ Hybrid checkpoint + manual → Best of both

**Open Questions**:
- Save format: JSON? Binary? Cloud sync?
- How many save slots?
- Quick save/load hotkeys?
- Iron man mode (no saves)?

---

### ✅ DD-009: Audio Mixing Strategy

**Decision**: Layered, dynamic audio that responds to game state.

**Date**: January 2026

**Rationale**:
- Supports tonal shift from cozy → horror
- Creates seamless transitions without jarring cuts
- Allows precise emotional control
- Industry standard for immersive games

**Layer Example**:
```
Cozy State (All layers at full volume):
- Lo-fi beat (constant)
- Soft synth pad (constant)
- Room ambience (3D spatial)

Tension Building (Gradual mix shift):
- Lo-fi beat (fade to 50%)
- Soft synth (add distortion)
- Tension strings (fade in)
- Cat purring (glitchy, 3D)

Full Horror (Complete transition):
- Lo-fi beat (muted)
- Horror score (full)
- Surround cat sounds
- Heartbeat layer
```

**Implications**:
- Need audio middleware (FMOD, Wwise) or custom system
- Requires careful audio mixing and mastering
- More complex than simple playlist approach
- Enables dynamic emotional storytelling

---

## Content Design

### ✅ DD-010: Apartment Setting for Intro

**Decision**: Entire opening sequence takes place in small apartment.

**Date**: January 2026

**Rationale**:
- Scope management: One location easier to polish
- Intimacy: Small space = claustrophobic horror
- Familiar: Everyone knows apartments
- Tutorial space: Controlled environment for teaching

**Apartment Layout**:
```
┌─────────────────────────────────────┐
│  Bathroom  │  Bedroom (Roommate)    │
│            │                        │
├────────────┼────────────┬───────────┤
│            │            │           │
│  Kitchen   │  Living    │  Bedroom  │
│            │  Room      │  (Player) │
│            │            │           │
└────────────┴────────────┴───────────┘
     │
  Front Door (Locked during intro)
```

**Key Locations**:
- Living Room: TV (news trigger), couch (cat cuddles)
- Kitchen: Fridge (food items), drawers (items)
- Bedroom: Safe zone, barricade location
- Bathroom: Mirror (visual gags), tight space

**Implications**:
- High asset quality needed (player will inspect closely)
- Many interactive objects for immersion
- Lighting crucial for mood transitions
- Sound design: different reverb per room

---

### ✅ DD-011: Cat Toy Arsenal

**Decision**: 6 primary items, all cat-themed, non-lethal.

**Date**: January 2026

**Rationale**:
- Manageable scope for intro
- Each item has distinct use case
- Reinforces theme (defending with cat toys)
- Variety without overwhelming new players

**Item Roster**:

1. **Yarn Ball** (Starter item)
   - Projectile, rolls on ground
   - Long distraction time
   - Limited quantity

2. **Laser Pointer** (Tutorial item)
   - Instant aim, no projectile
   - Short distraction, can redirect
   - Infinite uses, cooldown

3. **Spray Bottle** (Close range)
   - Cone spray
   - Instant deterrent
   - Limited water, refillable

4. **Food Can** (Heavy projectile)
   - Long-range throw
   - Large distraction radius
   - Limited quantity

5. **Feather Toy** (Area denial)
   - Place on ground
   - Cats can't resist
   - Single use per feather

6. **Cardboard Box** (Environmental)
   - Cats jump inside
   - Can trap or hide in
   - Limited boxes

**Alternatives Considered**:
- ❌ Cat-specific weapons (tranq darts) → Too violent
- ❌ 10+ items → Scope creep
- ✅ 6 thematic items → Just right

**Balance Goals**:
- No "best" item (situational advantages)
- Resource scarcity creates tension
- Combo potential (feather + box = trap)

---

### ✅ DD-012: Roommate Character Role

**Decision**: Roommate is present but not playable; serves as narrative anchor.

**Date**: January 2026

**Rationale**:
- Human connection grounds emotional stakes
- Dialogue exposition without breaking immersion
- Objective: protect roommate (vs pure survival)
- Comedy potential (reactions to absurdity)

**Roommate Characteristics**:
- Name: TBD (player-defined or preset?)
- Personality: Skeptical gamer, comic relief
- Role: Supports player, reacts to chaos
- Fate: Open (survives? Converted? Player choice?)

**Key Moments**:
1. Morning: Gaming on couch, casual banter
2. News: "Put on the news for me"
3. Shift: "Is this really happening?"
4. Attack: Runs to bedroom with player
5. Tutorial: Guides player, suggests items

**Alternatives Considered**:
1. ❌ No roommate → Lonely, less emotional stakes
2. ❌ Playable co-op → Scope explosion
3. ❌ Roommate dies early → Too dark
4. ✅ Present NPC companion → Just right

**Open Questions**:
- Can roommate be converted?
- Do they help fight cats?
- Multiple roommate character options?
- Romance subplot? (probably not)

---

## Future Decisions

These decisions have been identified but not yet made. They will be resolved during development.

### 🔮 FD-001: Engine Selection

**Status**: Critical decision pending
**Timeline**: Before prototyping begins
**See**: [ADR-001](architecture/adr-001-engine-selection.md)

**Options**:
- Unity (familiar, asset store)
- Godot (free, lightweight)
- Unreal (AAA quality, visual scripting)
- Custom engine (full control, high effort)

**Factors to Consider**:
- Team size and experience
- Budget (free vs licensed)
- Target platforms
- Performance requirements
- Community and asset availability

---

### 🔮 FD-002: Art Style (Realistic vs Stylized)

**Status**: To be decided after concept art
**Timeline**: Pre-production

**Options**:
1. **Photorealistic**
   - Pros: Immersion, horror impact
   - Cons: Expensive, uncanny valley risk

2. **Semi-realistic** (e.g., Resident Evil remakes)
   - Pros: Balance of immersion and performance
   - Cons: Still asset-heavy

3. **Stylized** (e.g., Firewatch, What Remains of Edith Finch)
   - Pros: Unique aesthetic, easier to produce
   - Cons: May reduce horror impact

4. **Low-poly/PS1 Horror**
   - Pros: Trendy, nostalgia, artistic
   - Cons: May feel gimmicky

**Current Lean**: Semi-realistic or stylized with warm color palette.

---

### 🔮 FD-003: Voice Acting vs Text-Only Dialogue

**Status**: Budget-dependent
**Timeline**: Mid-development

**Options**:
1. Full voice acting (player, roommate, news anchors)
2. Partial (roommate only)
3. Text-only with vocal sounds (Animal Crossing style)
4. Silent protagonist

**Considerations**:
- Budget: Voice acting is expensive
- Localization: Text easier to translate
- Immersion: Voice adds emotional weight
- Flexibility: Text easier to iterate

**Current Lean**: Text-only with expressive text animations and sound design.

---

### 🔮 FD-004: Post-Intro Game Structure

**Status**: Deferred until intro is complete
**Timeline**: Post-alpha

**Questions**:
- Does the game continue beyond the apartment?
- Is it a single continuous level or episodic?
- What's the endgame? (Cure cats? Escape city? Accept cat overlords?)
- Branching narrative or linear path?

**Possible Structures**:
1. Linear narrative (Half-Life style)
2. Hub-based levels (Resident Evil)
3. Open-world exploration (Gone Home expanded)
4. Roguelike runs (Hades structure)

**Current Lean**: Focus on perfecting the intro, then decide based on scope and resources.

---

### 🔮 FD-005: Difficulty Modes

**Status**: Playtesting will inform
**Timeline**: Beta phase

**Questions**:
- Easy/Normal/Hard modes?
- Adjustable cat aggression?
- More/fewer items on easier difficulties?
- Optional "cute mode" (cats never attack)?

**Current Lean**: Single balanced difficulty, with accessibility options (e.g., reaction time assistance).

---

### 🔮 FD-006: Multiplayer/Co-op

**Status**: Not planned, but often requested
**Timeline**: Post-1.0 (if at all)

**Considerations**:
- Horror games less scary with friends
- Comedy games more fun with friends
- Massive scope increase
- Network complexity

**Current Stance**: Single-player only for 1.0. Co-op could be post-launch DLC if successful.

---

## Decision Log Format

For future decisions, use this template:

```markdown
### ✅/🔄/❌ DD-XXX: [Decision Title]

**Decision**: [What was decided]

**Date**: [When decided]

**Status**: [Finalized ✅ / Tentative 🔄 / Rejected ❌]

**Rationale**:
- [Why this decision was made]
- [Key factors]

**Alternatives Considered**:
1. ❌ [Option 1] → [Why rejected]
2. ❌ [Option 2] → [Why rejected]
3. ✅ [Chosen option] → [Why chosen]

**Implications**:
- [How this affects development]
- [What work this creates/eliminates]

**Open Questions**:
- [Unresolved aspects]

**Revisit Date**: [When to reconsider, if applicable]
```

---

**Document Status**: Living Document
**Last Updated**: January 2026
**Next Review**: After engine selection
