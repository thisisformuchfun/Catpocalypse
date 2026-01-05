# ADR-002: Cat AI Architecture

**Status**: Proposed
**Date**: January 2026
**Deciders**: Lead Developer, Gameplay Designer
**Priority**: High (Core gameplay mechanic)

## Context and Problem Statement

The cat AI is the centerpiece of Schrödinger's Catpocalypse. Cats must be:
- **Believable**: Move and behave like real cats
- **Threatening**: Create genuine tension and danger
- **Adorable**: Maintain cuteness factor even when hostile
- **Readable**: Players can predict behavior through clear tells
- **Performant**: Support 10-20 cats simultaneously

**Key Challenge**: Balance cute and deadly while maintaining predictable, fair gameplay.

## Decision Drivers

1. **Behavior Complexity**: Must feel intelligent but not omniscient
2. **Performance**: Multiple cats active at once
3. **Predictability**: Players must learn patterns
4. **Emotional Impact**: Cats should evoke both affection and fear
5. **Maintainability**: Easy to tune and debug
6. **Extensibility**: Support different cat types/personalities

## Considered Options

### Option 1: Finite State Machine (FSM)

**Approach**: Traditional state machine with clear states and transitions

```
States: Idle, Cute, Curious, Hunt, Stalk, Attack, Convert, Distracted
Transitions: Event-driven (e.g., see player → Hunt)
```

**Pros**:
- ✅ Simple to understand and debug
- ✅ Easy to visualize (state diagrams)
- ✅ Predictable behavior
- ✅ Low performance overhead
- ✅ Easy to tune individual states
- ✅ Well-documented pattern

**Cons**:
- ❌ Can become complex with many states
- ❌ Transitions can be hard to manage at scale
- ❌ Less flexible than other approaches
- ❌ Behavior can feel "robotic" if not carefully designed

**Example Implementation**:
```gdscript
class CatAI:
    var current_state: State

    func _process(delta):
        current_state = current_state.update(delta)
        current_state.execute(delta)
```

---

### Option 2: Behavior Trees

**Approach**: Hierarchical tree of behaviors with selectors, sequences, decorators

```
Root
├─ Selector (priority)
│  ├─ Sequence: Is distracted?
│  │  └─ Action: Play with toy
│  ├─ Sequence: Player in attack range?
│  │  └─ Action: Attack
│  ├─ Sequence: Player in vision?
│  │  └─ Action: Stalk
│  └─ Action: Idle
```

**Pros**:
- ✅ Very flexible and composable
- ✅ Reusable subtrees
- ✅ Good for complex decision-making
- ✅ Industry standard for AAA games
- ✅ Easy to add new behaviors

**Cons**:
- ❌ More complex to implement
- ❌ Harder to debug (tree traversal)
- ❌ Overkill for relatively simple cat AI
- ❌ Performance overhead (tree traversal)
- ❌ Steeper learning curve

---

### Option 3: Utility AI

**Approach**: Score-based decision making (each action has a utility score)

```
Actions scored per frame:
- Play with toy: 90 (if toy visible)
- Attack player: 80 (if in range)
- Stalk player: 60 (if visible)
- Groom self: 20 (idle)

Execute highest-scoring action
```

**Pros**:
- ✅ Emergent, realistic behavior
- ✅ Easy to add new considerations
- ✅ Smooth priority changes
- ✅ Handles complex scenarios well
- ✅ Good for variety (cats feel unique)

**Cons**:
- ❌ Less predictable (harder for players to learn)
- ❌ Debugging is difficult (why did cat choose X?)
- ❌ Tuning is finicky (score balancing)
- ❌ Performance cost (evaluating many utilities)
- ❌ Can feel "floaty" without hysteresis

---

### Option 4: GOAP (Goal-Oriented Action Planning)

**Approach**: AI creates plans to achieve goals

```
Goal: Convert player
Available actions: Stalk, Pounce, Lick
AI plans sequence: Stalk → Get in range → Pounce → Lick
```

**Pros**:
- ✅ Intelligent, adaptive behavior
- ✅ Handles obstacles dynamically
- ✅ Impressive when it works

**Cons**:
- ❌ Very complex to implement
- ❌ Expensive (planning algorithms)
- ❌ Overkill for cat behavior
- ❌ Unpredictable (hard for players to counter)
- ❌ Debugging nightmare

---

## Decision Matrix

| Criterion              | FSM   | BT    | Utility AI | GOAP  |
|------------------------|-------|-------|------------|-------|
| Simplicity             | 9/10  | 6/10  | 5/10       | 3/10  |
| Predictability         | 9/10  | 7/10  | 5/10       | 4/10  |
| Performance            | 10/10 | 7/10  | 6/10       | 4/10  |
| Debuggability          | 9/10  | 6/10  | 5/10       | 3/10  |
| Flexibility            | 5/10  | 9/10  | 8/10       | 10/10 |
| Ease of Tuning         | 8/10  | 7/10  | 4/10       | 3/10  |
| **Total**              | **50**| **42**| **33**     | **27**|

## Decision Outcome

### Chosen Option: **Finite State Machine (FSM)** with extensions

**Rationale**:

1. **Simplicity First**: For a single-developer/small team project, simplicity wins
2. **Predictable Gameplay**: Players need to learn cat patterns; FSM provides this
3. **Easy Debugging**: Can visualize state, log transitions, inspect current state
4. **Performance**: Zero overhead, perfect for 10-20 cats
5. **Proven Pattern**: Used in countless games successfully
6. **Tunable**: Each state is independently tweakable

**Extensions to Basic FSM**:
- **Hierarchical States**: Sub-states within states (e.g., Hunt has substates: Search, Chase)
- **State Blending**: Smooth animation transitions between states
- **Condition Checks**: Re-evaluate transitions every frame (reactive AI)

### State Design

```
┌─────────────────────────────────────────────────────┐
│                    CAT STATE MACHINE                 │
├─────────────────────────────────────────────────────┤
│                                                      │
│  IDLE (Default)                                      │
│  ↓                                                   │
│  ├─→ CUTE (player nearby, not awakened)             │
│  │   └─→ AFFECTIONATE (purr, rub against player)    │
│  │                                                   │
│  ├─→ CURIOUS (heard sound, saw movement)            │
│  │   └─→ INVESTIGATE (walk toward stimulus)         │
│  │                                                   │
│  ├─→ HUNT (awakened OR player startled cat)         │
│  │   ├─→ SEARCH (lost sight of player)              │
│  │   ├─→ STALK (player visible, approaching)        │
│  │   └─→ ATTACK (in range, pounce)                  │
│  │       └─→ CONVERT (lick successful)              │
│  │                                                   │
│  └─→ DISTRACTED (toy/food detected)                 │
│      └─→ PLAY (interact with distraction)           │
│                                                      │
│  Global transitions:                                 │
│  - ANY → DISTRACTED (high-value distraction)        │
│  - ANY → IDLE (distraction ends, lost interest)     │
│                                                      │
└─────────────────────────────────────────────────────┘
```

### State Transition Rules

```gdscript
# Simplified pseudo-code

func update_state():
    # Global checks (highest priority)
    if high_value_distraction_nearby():
        return DISTRACTED

    # State-specific transitions
    match current_state:
        IDLE:
            if player_very_close() and not awakened:
                return CUTE
            if interesting_stimulus():
                return CURIOUS
            if awakened and can_see_player():
                return HUNT

        CUTE:
            if global_awakening_event():
                return HUNT
            if player_sudden_movement():
                return HUNT
            if player_left_area():
                return IDLE

        HUNT:
            if lost_player():
                return SEARCH
            if player_in_vision():
                return STALK

        STALK:
            if in_attack_range():
                return ATTACK
            if lost_player():
                return HUNT

        ATTACK:
            if lick_connected():
                return CONVERT
            if attack_failed():
                return STALK

        DISTRACTED:
            if distraction_timer_expired():
                return IDLE

    return current_state  # No transition
```

## Implementation Details

### State Interface

```gdscript
class State:
    var cat: CatAI
    var state_timer: float

    func enter():
        # Called when entering state
        pass

    func update(delta: float) -> State:
        # Check for transitions, return new state or self
        state_timer += delta
        return self

    func execute(delta: float):
        # Perform state behavior
        pass

    func exit():
        # Clean up when leaving state
        pass
```

### Example: Hunt State

```gdscript
class HuntState extends State:
    var target: Player

    func enter():
        # Play tense music layer
        AudioManager.add_tension_layer()
        # Eyes glow red
        cat.set_eye_glow(true)
        # Aggressive posture
        cat.play_animation("hunt_stance")

    func update(delta: float) -> State:
        if not target:
            target = get_nearest_player()

        # Transition checks
        if cat.can_see(target) and cat.distance_to(target) < attack_range:
            return StalkState.new()

        if not cat.can_see(target) and state_timer > 2.0:
            return SearchState.new()

        if cat.detect_high_value_distraction():
            return DistractedState.new()

        return self  # Stay in Hunt

    func execute(delta: float):
        # Move toward last known player position
        if target:
            cat.navigate_to(target.position)

        # Emit threatening sounds
        if state_timer % 3.0 < delta:
            cat.play_sound("hiss")

    func exit():
        cat.set_eye_glow(false)
```

### Sensor System

Cats need to perceive the world:

```gdscript
class CatSensors:
    # Vision
    var vision_range: float = 15.0
    var vision_angle: float = 120.0  # degrees

    # Hearing
    var hearing_range: float = 20.0

    # Smell (for food detection)
    var smell_range: float = 10.0

    func can_see_player() -> bool:
        # Raycast check + angle check
        pass

    func heard_sound(position: Vector3, volume: float) -> bool:
        # Distance-based hearing
        pass

    func detect_food() -> FoodItem:
        # Find food in smell range
        pass
```

## Consequences

### Positive
- Clear, debuggable cat behavior
- Performant (can handle many cats)
- Easy to tune difficulty (adjust transition thresholds)
- Predictable for players (learn patterns)
- Extensible (add new states easily)

### Negative
- Behavior might feel less "intelligent" than BT/Utility AI
- State explosion risk (mitigated by hierarchical states)
- Requires careful balancing to avoid robotic feel

### Neutral
- Standard approach (not innovative)
- Behavior variety comes from state variety, not emergent complexity

## Risks and Mitigations

### Risk 1: Cats Feel Robotic
- **Mitigation**: Add randomness to timers, animation variations, idle behaviors
- **Mitigation**: Use animation blending for smooth transitions

### Risk 2: State Explosion (Too Many States)
- **Mitigation**: Use hierarchical states (substates)
- **Mitigation**: Keep states coarse-grained (details in animation/sound)

### Risk 3: Unfair AI (Omniscient Behavior)
- **Mitigation**: Respect sensor limitations (vision cones, hearing range)
- **Mitigation**: Add reaction time delays (cat doesn't instantly notice player)

## Performance Considerations

### Optimizations
- Update cats at different frequencies (stagger updates)
- Disable AI for cats outside player view frustum
- Use simple distance checks before expensive raycasts
- Cache player position (don't query every frame)

```gdscript
# Staggered updates
func _process(delta):
    # Only update 1/3 of cats per frame
    if Engine.get_frames_drawn() % 3 == cat_id % 3:
        ai_update(delta * 3)  # Compensate for update frequency
```

## Testing Strategy

### Unit Tests
- State transition logic
- Sensor detection ranges
- Priority evaluation

### Integration Tests
- Multi-cat behavior (don't all attack at once)
- Distraction effectiveness
- Player can escape when properly skilled

### Playtesting Metrics
- Time to first cat attack (should be predictable)
- Player death rate (should feel fair, not cheap)
- Distraction usage rate (are items effective?)

## Follow-Up Actions

- [ ] Implement base State class
- [ ] Implement FSM controller
- [ ] Create Idle, Cute, Hunt, Attack states (MVP)
- [ ] Build sensor system (vision, hearing)
- [ ] Add debug visualization (draw state name, vision cone)
- [ ] Prototype with single cat
- [ ] Tune transition thresholds
- [ ] Add sound/animation triggers per state

## References

- [State Pattern (Game Programming Patterns)](https://gameprogrammingpatterns.com/state.html)
- [AI for Games (Millington & Funge)](https://www.gameaipro.com/)
- [Godot AI Tutorials](https://docs.godotengine.org/en/stable/tutorials/navigation/)

---

**Decision Status**: ✅ Finalized
**Implementation Start**: Month 2 (Phase 1)
**Author**: Development Team
