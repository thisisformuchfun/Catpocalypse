# ADR-003: Input System Architecture

**Status**: Proposed
**Date**: January 2026
**Deciders**: Lead Developer
**Priority**: Medium-High (Affects player experience)

## Context and Problem Statement

The input system must handle:
- Keyboard + Mouse controls (primary)
- Gamepad support (secondary)
- Rebindable controls
- Accessibility options
- Context-sensitive actions (e.g., "Interact" vs "Attack" on same button)

**Core Question**: How do we design a flexible, accessible input system that feels good on all control schemes?

## Decision Drivers

1. **Responsiveness**: Input must feel immediate and precise
2. **Flexibility**: Support multiple input devices
3. **Accessibility**: Remappable controls, alternatives for mouse look
4. **Maintainability**: Easy to add new actions
5. **Cross-Platform**: Work on Windows, macOS, Linux
6. **Engine Integration**: Work well with chosen engine (Godot)

## Considered Options

### Option 1: Direct Input Polling

**Approach**: Check `Input.is_action_pressed()` directly in gameplay code

```gdscript
func _process(delta):
    if Input.is_action_pressed("move_forward"):
        move_forward(delta)
    if Input.is_action_pressed("jump"):
        jump()
```

**Pros**:
- ✅ Simple, straightforward
- ✅ No abstraction overhead
- ✅ Easy to understand for beginners

**Cons**:
- ❌ Hard to change mappings at runtime
- ❌ Difficult to add input buffering
- ❌ No separation of concerns
- ❌ Accessibility features harder to add

---

### Option 2: Input Action System (Event-Driven)

**Approach**: Central input manager emits events that gameplay code subscribes to

```gdscript
InputManager.on_action("jump", func():
    player.jump()
)

InputManager.on_axis("move", func(direction: Vector2):
    player.move(direction)
)
```

**Pros**:
- ✅ Decoupled from implementation
- ✅ Easy to add input buffering
- ✅ Rebindable controls straightforward
- ✅ Can log/replay inputs
- ✅ Accessibility layer possible

**Cons**:
- ❌ Slightly more complex setup
- ❌ Event overhead (minimal)
- ❌ Indirection can make debugging harder

---

### Option 3: Component-Based Input

**Approach**: Each entity has InputComponent that processes input

```gdscript
class PlayerInputComponent:
    func process_input(delta):
        var move = InputMap.get_vector("left", "right", "forward", "back")
        owner.move(move)
```

**Pros**:
- ✅ ECS-friendly
- ✅ Easy to disable input (cutscenes)
- ✅ Can have multiple input sources

**Cons**:
- ❌ More boilerplate
- ❌ Overkill for single player character

---

## Decision Outcome

### Chosen Option: **Hybrid Approach**

**Approach**: Use engine's InputMap + Custom InputManager for high-level actions

```gdscript
# Input Map (defined in project settings)
Actions:
  - move_forward: W, Up, Gamepad L-Stick Up
  - move_back: S, Down, Gamepad L-Stick Down
  - move_left: A, Left, Gamepad L-Stick Left
  - move_right: D, Right, Gamepad L-Stick Right
  - jump: Space, Gamepad A
  - interact: E, Gamepad X
  - use_item: Mouse Left, Gamepad RT
  - switch_item_next: Mouse Wheel Up, Gamepad RB
  - switch_item_prev: Mouse Wheel Down, Gamepad LB
  - pause: Escape, Gamepad Start

# InputManager handles complex input logic
class InputManager:
    func get_move_direction() -> Vector2:
        return Input.get_vector("move_left", "move_right", "move_forward", "move_back")

    func get_look_delta() -> Vector2:
        return Input.get_mouse_delta() * mouse_sensitivity

    func is_interacting() -> bool:
        return Input.is_action_just_pressed("interact")
```

**Rationale**:
1. **Engine-Native**: Leverage Godot's InputMap (cross-platform, rebindable)
2. **Simple Abstraction**: InputManager wraps complex logic without overengineering
3. **Best of Both**: Direct polling performance + rebinding flexibility
4. **Proven Pattern**: Used in many Godot games successfully

## Input Design Specifications

### Control Schemes

#### Keyboard + Mouse (Primary)

```
Movement:
  W/A/S/D - Forward/Left/Back/Right
  Shift - Sprint (hold)
  Ctrl - Crouch (hold)
  Space - Jump

Interaction:
  E - Interact with objects
  F - Pick up item
  Mouse Left - Use equipped item
  Mouse Right - Aim/secondary action (future)

Inventory:
  1-9 - Quick select items
  Mouse Wheel - Cycle items
  Tab - Open inventory (future)

Camera:
  Mouse Movement - Look around
  Mouse Sensitivity - Adjustable in settings

UI:
  Escape - Pause menu
  I - Inventory (future)
```

#### Gamepad (Secondary)

```
Movement:
  Left Stick - Move
  Left Stick Click - Sprint toggle
  Right Stick - Look around
  Right Stick Sensitivity - Adjustable
  A Button (Xbox) / X (PlayStation) - Jump

Interaction:
  X Button (Xbox) / Square (PS) - Interact
  B Button (Xbox) / Circle (PS) - Pick up
  RT - Use item
  LT - Aim/secondary (future)

Inventory:
  D-Pad Up/Down - Cycle items
  RB/LB - Quick cycle
  Y/Triangle - Inventory (future)

UI:
  Start - Pause menu
  Back/Select - Map (future)
```

### Accessibility Features

1. **Rebindable Controls**
   - Every action can be remapped
   - Multiple bindings per action
   - Save/load control schemes

2. **Mouse Sensitivity**
   - Separate X/Y sensitivity
   - Range: 0.1 to 5.0
   - Invert options (X and Y independently)

3. **Toggle vs Hold**
   - Sprint: Toggle or Hold
   - Crouch: Toggle or Hold
   - Aim: Toggle or Hold

4. **Input Assistance**
   - Aim assist (gamepad only)
   - Input buffering (queue inputs)
   - Sticky keys (hold to press)

5. **Alternative Control Schemes**
   - One-handed mode
   - Eye tracking support (future)
   - Custom accessibility profiles

### Input Buffering

**Problem**: Player presses jump slightly before landing, feels unresponsive

**Solution**: Buffer inputs for short window

```gdscript
class InputBuffer:
    var buffer_duration = 0.15  # 150ms
    var buffered_actions = {}

    func buffer_action(action: String):
        buffered_actions[action] = buffer_duration

    func consume_action(action: String) -> bool:
        if buffered_actions.has(action) and buffered_actions[action] > 0:
            buffered_actions.erase(action)
            return true
        return false

    func _process(delta):
        for action in buffered_actions.keys():
            buffered_actions[action] -= delta
            if buffered_actions[action] <= 0:
                buffered_actions.erase(action)

# Usage in player controller
if Input.is_action_just_pressed("jump"):
    input_buffer.buffer_action("jump")

if is_on_ground() and input_buffer.consume_action("jump"):
    jump()
```

### Context-Sensitive Actions

**Problem**: "E" key means different things in different contexts

**Solution**: Priority system + visual feedback

```gdscript
class InteractionManager:
    var interaction_targets = []  # Sorted by priority

    func get_primary_interaction() -> Interactable:
        if interaction_targets.is_empty():
            return null
        return interaction_targets[0]

    func _process(delta):
        if Input.is_action_just_pressed("interact"):
            var target = get_primary_interaction()
            if target:
                target.interact()
                update_prompt()

# Priority examples:
# 1. Critical interactions (closing door during cat attack) - Priority 100
# 2. Item pickups - Priority 50
# 3. Generic interactions (turn on TV) - Priority 10
```

### Input States

**Problem**: Different game states need different input handling

```gdscript
enum InputMode:
    DISABLED,      # Cutscenes
    GAMEPLAY,      # Normal play
    UI,            # Menus
    DIALOGUE,      # Talking to roommate

var current_mode = InputMode.GAMEPLAY

func set_input_mode(mode: InputMode):
    current_mode = mode
    match mode:
        InputMode.DISABLED:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
        InputMode.GAMEPLAY:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
        InputMode.UI:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
```

## Implementation Plan

### Phase 1: Basic Input (Month 1)
- [x] Define InputMap actions
- [ ] Implement InputManager class
- [ ] Basic movement input (WASD + mouse look)
- [ ] Interact action (E key)
- [ ] Item use action (mouse click)

### Phase 2: Advanced Input (Month 2-3)
- [ ] Gamepad support
- [ ] Input buffering
- [ ] Item switching (1-9, mouse wheel)
- [ ] Context-sensitive interactions
- [ ] Input state management

### Phase 3: Polish (Month 4+)
- [ ] Rebindable controls UI
- [ ] Accessibility options
- [ ] Toggle vs hold settings
- [ ] Aim assist (gamepad)
- [ ] Input hints/tutorials

## Consequences

### Positive
- Flexible, maintainable input system
- Good out-of-box support for multiple devices
- Accessibility from the start
- Easy to extend with new actions

### Negative
- Slight over-engineering for single-player game
- More setup than direct polling
- Need to build rebinding UI

### Neutral
- Standard approach, not innovative
- Engine-dependent (tied to Godot InputMap)

## Testing Strategy

### Input Tests
- All actions work on keyboard + mouse
- All actions work on gamepad
- Rebinding persists across sessions
- Input buffering reduces missed inputs
- No input conflicts in any context

### Accessibility Tests
- Controls can be fully remapped
- Game playable with one hand (keyboard only)
- Game playable with gamepad only
- Toggle options work correctly

## Follow-Up Actions

- [ ] Create InputManager singleton
- [ ] Define all InputMap actions in project settings
- [ ] Implement basic movement input
- [ ] Test keyboard + mouse
- [ ] Test gamepad
- [ ] Add input buffering
- [ ] Build settings menu for rebinding (future)

## References

- [Godot Input Documentation](https://docs.godotengine.org/en/stable/tutorials/inputs/)
- [Game Accessibility Guidelines](https://gameaccessibilityguidelines.com/)
- [Game Feel by Steve Swink](http://www.game-feel.com/)

---

**Decision Status**: ✅ Finalized
**Implementation Start**: Month 1 (Phase 0-1)
**Author**: Development Team
