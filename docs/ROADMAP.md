# Development Roadmap

## Vision Statement

Create a memorable, emotionally impactful 30-60 minute gaming experience that subverts expectations, blending cozy slice-of-life with horror-comedy in a way that's never been done before. The opening sequence should be so compelling that players immediately want to share it.

---

## Release Targets

### Target Platforms
- **Primary**: PC (Windows, macOS, Linux)
- **Future**: Nintendo Switch, Steam Deck
- **Maybe**: PlayStation, Xbox (dependent on success)

### Minimum Viable Product (MVP)
**Scope**: Complete apartment intro sequence (15-20 minutes of gameplay)

**Success Criteria**:
- ✅ Emotionally resonant opening (cozy to horror transition)
- ✅ Tight first-person controls
- ✅ At least 2 cats with full AI
- ✅ 4-6 usable items
- ✅ Complete audio implementation
- ✅ Polished tutorial integration
- ✅ Satisfying conclusion to apartment sequence

---

## Development Phases

```
Timeline (Estimated):

Phase 0: Pre-Production ████░░░░░░░░░░░░░░░░ (2 months)
Phase 1: Foundation    ░░░░████░░░░░░░░░░░░ (2 months)
Phase 2: Core Gameplay ░░░░░░░░████░░░░░░░░ (3 months)
Phase 3: Polish        ░░░░░░░░░░░░████░░░░ (2 months)
Phase 4: Launch Prep   ░░░░░░░░░░░░░░░░████ (1 month)
                       ├────┴────┴────┴────┤
                       0    3    6    9   10 months

Current Phase: █ Phase 0: Pre-Production
```

---

## Phase 0: Pre-Production (Months 0-2)

**Status**: 🟢 IN PROGRESS

**Goal**: Establish technical foundation and core design pillars.

### Month 0-1: Planning & Prototyping

#### Week 1-2: Technical Foundation ✅
- [x] Repository setup
- [x] Architecture documentation
- [x] Design decisions documented
- [ ] **Engine selection** (CRITICAL PATH)
- [ ] Development environment setup
- [ ] Version control workflow established

#### Week 3-4: Concept Development
- [ ] Concept art (apartment layout, cat designs)
- [ ] Audio palette testing (lo-fi → horror transition)
- [ ] UI/UX wireframes
- [ ] Script first draft (dialogue, narrative beats)
- [ ] Reference gathering (inspiration games, art)

### Month 1-2: Vertical Slice

**Deliverable**: 2-minute playable prototype

**Scope**:
- [ ] Basic first-person controller (movement, look, jump)
- [ ] Single room (living room)
- [ ] One interactive object (TV with news trigger)
- [ ] One cat with basic AI (idle, curious, attack states)
- [ ] One item (yarn ball)
- [ ] Placeholder audio
- [ ] Proof of concept: tone shift

**Success Metrics**:
- Controls feel responsive
- Cat behavior is readable
- Tone shift is effective
- Technical foundation is solid

---

## Phase 1: Foundation (Months 2-4)

**Goal**: Build all core systems without polish.

### Month 2-3: Core Systems

#### Player Systems
- [ ] First-person controller (full movement set)
  - [ ] Walk, run, crouch
  - [ ] Head bob and camera shake
  - [ ] Footstep sounds
- [ ] Camera system
  - [ ] Mouse/gamepad look
  - [ ] Sensitivity settings
  - [ ] FOV adjustment
- [ ] Interaction system
  - [ ] Raycast detection
  - [ ] Object highlighting
  - [ ] Interaction prompts
- [ ] Inventory system
  - [ ] 9-slot inventory
  - [ ] Item switching (1-9 keys)
  - [ ] Pick up/drop items

#### Cat AI Foundation
- [ ] Navigation and pathfinding
  - [ ] NavMesh setup
  - [ ] Obstacle avoidance
- [ ] State machine implementation
  - [ ] Idle, Cute, Curious, Hunt, Stalk, Attack
  - [ ] State transition logic
- [ ] Sensor system
  - [ ] Vision cone
  - [ ] Hearing range
- [ ] Basic animations
  - [ ] Locomotion (walk, run, sit, pounce)
  - [ ] Idle behaviors (grooming, stretching)

#### Environment
- [ ] Apartment blockout (all rooms)
- [ ] Door system (open/close)
- [ ] Interactive objects (basic)
  - [ ] TV (channels, power)
  - [ ] Fridge (open, items)
  - [ ] Drawers (open, items)
  - [ ] Kettle (on/off)
- [ ] Lighting foundation
  - [ ] Day/night cycle (time-based)
  - [ ] Light switches
  - [ ] Flickering lights system

### Month 3-4: Items & Interactions

#### Item Implementations
- [ ] Yarn ball (projectile physics)
- [ ] Laser pointer (raycast)
- [ ] Spray bottle (cone detection)
- [ ] Food can (heavy projectile)
- [ ] Feather toy (placeable)
- [ ] Cardboard box (trap/hide)

#### Cat Reactions
- [ ] Distraction system
  - [ ] Item detection
  - [ ] Priority evaluation
  - [ ] Distraction timer
- [ ] Attack system
  - [ ] Pounce animation
  - [ ] Lick detection
  - [ ] Conversion trigger

#### World Interactions
- [ ] All apartment interactions functional
- [ ] Physics-based objects (books, mugs, etc.)
- [ ] Roommate NPC (basic idle behavior)

---

## Phase 2: Core Gameplay (Months 4-7)

**Goal**: Complete gameplay loop with full feature set.

### Month 4-5: Cinematic & Narrative

#### Cutscene System
- [ ] Timeline/sequencer implementation
- [ ] Camera path tools
- [ ] Dialogue display system
- [ ] Character animations for cutscenes

#### Narrative Content
- [ ] Full script implementation
- [ ] Morning sequence (skippable)
- [ ] News broadcast sequence
  - [ ] FauxNews channel
  - [ ] SEENN channel
  - [ ] White House chaos footage
- [ ] Cat transformation sequence
- [ ] Roommate dialogue (all beats)

#### Tutorial Integration
- [ ] Non-intrusive prompts
- [ ] Progressive unlocking
- [ ] Control hints
- [ ] Objective markers

### Month 5-6: Cat AI Polish

#### Advanced Behaviors
- [ ] Multiple cats coordination
- [ ] Pack behavior (surround player)
- [ ] Dynamic difficulty adjustment
- [ ] Personality variations (timid cat, aggressive cat)

#### Animation Polish
- [ ] Full animation set
- [ ] IK system (feet placement)
- [ ] Facial animations
- [ ] Tail physics

#### Balance & Tuning
- [ ] Cat spawn timing
- [ ] Aggression curves
- [ ] Item effectiveness balance
- [ ] Distraction duration tuning

### Month 6-7: Audio Implementation

#### Music System
- [ ] Layered music implementation
- [ ] Dynamic mixing based on game state
- [ ] Transition system (crossfade, stingers)
- [ ] Music for all phases:
  - [ ] Lo-fi morning beats
  - [ ] Tension layer
  - [ ] Horror score

#### Sound Effects
- [ ] Player sounds (footsteps, breathing, item use)
- [ ] Cat sounds (purr, meow, hiss, glitch effects)
- [ ] Environment (doors, appliances, ambience)
- [ ] UI sounds (menu, notifications)

#### 3D Audio
- [ ] Spatial audio for cats
- [ ] Room reverb system
- [ ] Audio occlusion
- [ ] Surround sound mix

---

## Phase 3: Polish & Content (Months 7-9)

**Goal**: Make every moment shine.

### Month 7: Visual Polish

#### Art Pass
- [ ] Replace all placeholder art
- [ ] High-quality apartment assets
- [ ] Cat models and textures
- [ ] Item models
- [ ] UI art

#### Lighting & Atmosphere
- [ ] Baked lighting
- [ ] Dynamic lights (lamps, TV glow)
- [ ] Volumetric effects
- [ ] Color grading per mood
- [ ] Post-processing (bloom, vignette, film grain)

#### VFX
- [ ] Particle effects (dust, steam, sparks)
- [ ] Cat transformation effects
- [ ] Item effects (spray mist, laser glow)
- [ ] Environmental effects (flickering lights)

### Month 8: UX/UI Polish

#### UI Implementation
- [ ] Main menu (animated, atmospheric)
- [ ] Pause menu
- [ ] Settings menu (graphics, audio, controls)
- [ ] HUD (minimalist, diegetic)
- [ ] Loading screens
- [ ] Credits sequence

#### Accessibility
- [ ] Subtitle system
- [ ] Colorblind modes
- [ ] Control remapping
- [ ] Difficulty assist options
- [ ] FOV slider
- [ ] Motion sickness options

#### Quality of Life
- [ ] Save/load system
- [ ] Quick save/load
- [ ] Chapter select (post-completion)
- [ ] Performance settings
- [ ] Achievements/milestones

### Month 9: Playtesting & Iteration

#### Internal Testing
- [ ] Full playthrough testing (10+ runs)
- [ ] Bug fixing sprint
- [ ] Performance optimization
- [ ] Balance adjustments based on data

#### External Testing
- [ ] Friends & family alpha
- [ ] Feedback collection
- [ ] Iterate based on feedback
- [ ] Closed beta (20-50 testers)

#### Bug Bash
- [ ] Critical bugs (blockers, crashes)
- [ ] Major bugs (game-breaking, progression)
- [ ] Minor bugs (visual, audio glitches)
- [ ] Polish bugs (typos, minor issues)

---

## Phase 4: Launch Preparation (Months 9-10)

**Goal**: Ship a polished, stable product.

### Month 9-10: Release Readiness

#### Marketing Materials
- [ ] Trailer (2-3 minutes)
- [ ] Screenshots (press kit)
- [ ] Store page copy
- [ ] Social media assets
- [ ] Press kit

#### Platform Preparation
- [ ] Steam page setup
- [ ] Itch.io page
- [ ] GOG submission (optional)
- [ ] Age ratings (ESRB, PEGI)

#### Technical Readiness
- [ ] Final QA pass
- [ ] Performance profiling
- [ ] Build pipeline
- [ ] Installer creation
- [ ] Crash reporting integration
- [ ] Analytics implementation

#### Launch Support
- [ ] Day-one patch readiness
- [ ] Support documentation
- [ ] FAQ creation
- [ ] Community moderation plan

---

## Post-Launch Roadmap (Months 10+)

### Immediate Post-Launch (Month 10-11)

**Focus**: Stability and community response

- [ ] Monitor crash reports
- [ ] Fix critical bugs (patches)
- [ ] Community management
- [ ] Review feedback trends
- [ ] Analytics review

### Short-Term Updates (Months 11-12)

**Potential Content**:
- [ ] New cat breeds/types
- [ ] Additional items
- [ ] Alternate apartment layout
- [ ] Challenge modes
- [ ] Speedrun mode

### Long-Term Vision (Year 2+)

**Expansion Ideas** (Pending success of MVP):

1. **Story Continuation**
   - Leave apartment, explore building
   - City streets (cat-occupied)
   - Find other survivors
   - Search for cure/solution

2. **New Gameplay Modes**
   - Endless survival mode
   - Cat perspective mode (play as a cat?)
   - Puzzle-focused levels
   - Time attack challenges

3. **Multiplayer** (Ambitious)
   - 2-player co-op
   - Versus mode (cat vs human)
   - Shared world survival

4. **Modding Support**
   - Level editor
   - Custom cat types
   - Community workshop

**Decision Point**: Expand game OR create sequel/spiritual successor?

---

## Key Milestones

### Milestone 1: Vertical Slice ✅ (Month 2)
- Proves concept works
- Shows tone transition
- Validates core loop

### Milestone 2: Alpha (Month 4)
- All systems implemented
- Playable start-to-finish
- Placeholder content acceptable

### Milestone 3: Beta (Month 7)
- Feature complete
- Asset pass complete
- Playtesting begins

### Milestone 4: Release Candidate (Month 9)
- Zero critical bugs
- Performance targets met
- Marketing materials ready

### Milestone 5: Launch (Month 10)
- Public release
- Support infrastructure live
- Community engagement begins

---

## Success Metrics

### Technical Targets
- **Performance**: 60 FPS on mid-range PC (GTX 1060 / RX 580)
- **Load Times**: < 10 seconds from menu to gameplay
- **Bugs**: < 5 known non-critical bugs at launch
- **Crash Rate**: < 0.1% of sessions

### Player Experience Targets
- **Completion Rate**: > 70% of players finish intro
- **Average Session**: 25-30 minutes (full playthrough)
- **Player Sentiment**: > 80% positive reviews
- **Shareability**: > 30% of players recommend to friend

### Business Goals (If commercial)
- **Units Sold**: 10,000 copies in first year (modest indie target)
- **Revenue**: Cover development costs + fund next project
- **Community**: 1,000+ Discord members, active subreddit

---

## Risk Management

### High-Risk Items (Mitigation Plans)

1. **Engine Selection Paralysis**
   - Risk: Can't decide, delays start
   - Mitigation: Set deadline (end of Month 1), pick Godot as default

2. **Scope Creep**
   - Risk: Keep adding features, never finish
   - Mitigation: Strict feature freeze after Alpha, document ideas for post-launch

3. **Cat AI Complexity**
   - Risk: AI too hard to implement well
   - Mitigation: Start simple, iterate, reduce cat count if needed

4. **Tone Doesn't Land**
   - Risk: Not funny or scary, just awkward
   - Mitigation: Early playtesting, iterate on pacing and audiovisual cues

5. **Solo/Small Team Burnout**
   - Risk: Lose motivation, project stalls
   - Mitigation: Set realistic timeline, build community, celebrate milestones

6. **Technical Debt**
   - Risk: Code becomes unmaintainable
   - Mitigation: Code reviews, refactoring sprints, architecture adherence

---

## Flexibility & Pivots

**This roadmap is a living document.** We will:

- ✅ Review progress monthly
- ✅ Adjust timeline based on reality
- ✅ Cut features if needed (scope vs quality)
- ✅ Add features if ahead of schedule
- ✅ Pivot if playtesting reveals issues

**Core Principle**: Ship a polished, short experience > Ship a janky, long experience.

**Minimum Success**: Players remember the game fondly and tell their friends.

---

## Beyond Schrödinger's Catpocalypse

**Long-term Vision**: Establish a unique voice in indie horror-comedy, creating memorable, emotionally resonant experiences that subvert expectations.

**Potential Future Projects**:
- Schrödinger's Catpocalypse: Full Game (if MVP succeeds)
- Other "mundane becomes horror" concepts
- Different perspectives on the catpocalypse (news anchor, cat scientist, etc.)

---

**Last Updated**: January 2026
**Current Phase**: Phase 0 (Pre-Production)
**Next Milestone**: Vertical Slice (Month 2)
**Status**: On track
