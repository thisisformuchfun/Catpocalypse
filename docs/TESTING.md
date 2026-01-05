# Testing Guide - 3D Scene Setup

This document outlines the testing procedures for the foundational 3D scenes in Schrödinger's Catpocalypse.

## Test Level Overview

The `test_level.tscn` scene has been created as a sandbox for testing all core gameplay mechanics before vertical slice development.

### Scene Components

1. **Player** (`scenes/player.tscn`)
   - CharacterBody3D with capsule collision
   - First-person camera at eye level (1.6m)
   - Interaction raycast (2.5m range)
   - Script: `scripts/player/player_controller.gd`

2. **Cat** (`scenes/cat.tscn`)
   - CharacterBody3D with capsule collision (rotated horizontally)
   - NavigationAgent3D for pathfinding
   - AI state machine with states: IDLE, CUTE, CURIOUS, HUNT, STALK, ATTACK, CONVERT
   - Script: `scripts/cats/cat_ai.gd`

3. **Test Level** (`scenes/test_level.tscn`)
   - 20x20m floor with collision
   - 4 walls (3m high) forming an enclosed arena
   - NavigationRegion3D with baked NavMesh
   - 3 prop boxes for obstacle testing
   - 4 spawn points at corners
   - 1 test cat spawned at (5, 0.5, 5)
   - 1 interactable test box at (0, 0.5, -3)
   - Debug HUD overlay

## Testing Checklist

### ✓ Player Movement (End-to-End)

**Controls:**
- `W/A/S/D` - Move forward/left/backward/right
- `Space` - Jump
- `Left Shift` - Sprint
- `Mouse` - Look around
- `E` - Interact
- `Esc` - Toggle mouse capture

**Test Cases:**
1. Launch the game (should load test_level.tscn automatically)
2. Verify mouse is captured on start
3. Test WASD movement in all directions
4. Verify walk speed (5.0 m/s) vs sprint speed (8.0 m/s)
5. Test jumping (should reach ~4.5m/s vertical velocity)
6. Verify gravity pulls player back down
7. Test collision with walls and props
8. Press Esc to release mouse, press again to recapture

**Expected Results:**
- Smooth first-person movement
- No clipping through walls or floor
- Responsive controls with no input lag
- Camera rotation clamped to ±90° vertical

### ✓ Cat AI Spawning and Basic States

**Test Cases:**
1. Observe the test cat spawned in the level
2. Cat should start in IDLE state (check debug HUD)
3. After 1 second, cat should detect player
4. Cat should transition to HUNT state when player is within 10m
5. Move close to cat - should transition to STALK state at ~3m
6. Allow cat to reach you - should transition to ATTACK state at 1.5m

**Expected Results:**
- Cat visible with orange capsule mesh
- Cat rotates to face player when hunting
- Cat uses NavMesh for pathfinding (no wall clipping)
- State transitions display correctly in debug HUD
- Cat AI states shown: IDLE → HUNT → STALK → ATTACK

**Known Limitations:**
- No animations yet (placeholder mesh)
- CONVERT state not fully implemented
- Cat speed: Walk 2.0 m/s, Run 5.0 m/s

### ✓ Navigation System

**Test Cases:**
1. Observe cat pathfinding around obstacles
2. Cat should navigate around the prop boxes
3. Cat should not walk through walls
4. Cat should maintain proper ground following

**Expected Results:**
- Cat follows NavMesh paths
- Smooth navigation around obstacles
- No teleporting or erratic movement
- Cat stays on floor level

**Debugging:**
- If cat walks through walls, check NavigationRegion3D baking
- NavMesh vertices should cover the entire floor
- Obstacles should be excluded from NavMesh

### ✓ Interaction System

**Test Cases:**
1. Walk to the interactable box (directly in front of spawn, 3m away)
2. Aim camera at the box (within 2.5m range)
3. Press `E` to interact
4. Check console output for interaction message
5. Box should pulse (scale animation)

**Expected Results:**
- Interaction triggers when looking at box within range
- Console shows: "Test box interacted! Count: X"
- Visual feedback (scale pulse) occurs
- Interaction raycast properly detects Area3D objects

**Debugging:**
- InteractableBox collision_layer = 2
- Player interaction raycast collision_mask = 2
- Raycast length = 2.5m (check Camera3D → InteractionRaycast)

### ✓ Debug HUD

**Information Displayed:**
- FPS (color-coded: Green ≥60, Yellow ≥30, Red <30)
- Player position (X, Y, Z)
- Cat count
- Cat state (first cat's current state)
- Control help text

**Test Cases:**
1. Verify FPS displays and updates
2. Move player and confirm position updates
3. Verify cat state changes reflect in HUD
4. FPS should be green (60+) with 1 cat

**Expected Results:**
- All labels visible and readable
- Real-time updates
- No performance impact from HUD

### ✓ Performance Baseline (60 FPS with 1 Cat)

**Test Cases:**
1. Check debug HUD FPS counter
2. Move around the level while observing FPS
3. Approach cat and trigger AI states
4. Jump, sprint, and interact while monitoring FPS

**Expected Results:**
- Consistent 60 FPS (green)
- No frame drops during normal gameplay
- Smooth camera movement
- No stuttering or hitches

**Performance Targets:**
- **Minimum:** 60 FPS with 1 cat
- **Target:** 60 FPS with 5-10 cats
- **Stretch:** 60 FPS with 20+ cats

**If FPS < 60:**
- Check shadow settings (DirectionalLight3D)
- Verify MSAA level (currently set to 2x)
- Check for unnecessary physics calculations
- Profile with Godot's built-in profiler

## Additional Notes

### NavMesh Setup
The NavigationRegion3D is pre-configured with:
- Coverage: 20x20m floor
- Height: 0.1m above floor
- 2 polygons forming the walkable area
- Automatically includes obstacles

### Collision Layers
- Layer 1: Player, World geometry
- Layer 2: Interactables, Cats

### Scene Organization
```
test_level.tscn
├── Environment
│   ├── DirectionalLight3D
│   └── WorldEnvironment
├── NavigationRegion3D
│   └── Floor
├── Walls
│   ├── WallNorth
│   ├── WallSouth
│   ├── WallEast
│   └── WallWest
├── Props
│   ├── InteractableBox
│   ├── Box1
│   ├── Box2
│   └── Box3
├── Entities
│   └── Player
├── SpawnPoints
│   ├── SpawnPoint1 (8, 0.5, 8)
│   ├── SpawnPoint2 (-8, 0.5, 8)
│   ├── SpawnPoint3 (8, 0.5, -8)
│   └── SpawnPoint4 (-8, 0.5, -8)
├── TestCat (5, 0.5, 5)
└── CanvasLayer
    └── DebugHUD
```

### Known Issues
- [ ] Cats don't use NavigationAgent3D avoidance yet
- [ ] No animations for player or cats
- [ ] No sound effects
- [ ] No particle effects
- [ ] CONVERT state incomplete
- [ ] No cat spawner implemented yet (CatSpawner script exists but not in scene)

### Recent Fixes (2026-01-05)
- ✓ Fixed wall and prop meshes not rendering (proper SubResource structure)
- ✓ Increased gravity from 9.8 to 20.0 for better jump feel
- ✓ Changed prop boxes to CSGBox3D for instant collision
- ✓ Added golden material to interactable test box for visibility

### Next Steps After Testing
Once all tests pass:
1. Add cat spawner to test level for multi-cat testing
2. Implement proper animations
3. Add audio system
4. Create vertical slice level layout
5. Implement quantum mechanics system
6. Add item pickup system

## Running Tests

### Manual Testing
1. Open project in Godot 4.x
2. Press `F5` or click Play button
3. Test level should load automatically
4. Follow test cases above

### Automated Testing
Not implemented yet. Future work:
- GDScript unit tests for AI state machine
- Integration tests for player-cat interactions
- Performance benchmarking scripts

## Reporting Issues

If tests fail:
1. Note which test case failed
2. Check console output for errors
3. Verify scene structure in Godot editor
4. Check script paths and resource UIDs
5. Report issues with:
   - Expected behavior
   - Actual behavior
   - Steps to reproduce
   - Console errors (if any)

---

**Last Updated:** 2026-01-05
**Test Level Version:** 1.0
**Godot Version:** 4.2
