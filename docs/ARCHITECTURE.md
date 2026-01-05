# Architecture Overview

## Table of Contents

- [System Architecture](#system-architecture)
- [Core Systems](#core-systems)
- [Data Flow](#data-flow)
- [Module Dependencies](#module-dependencies)
- [Performance Considerations](#performance-considerations)
- [Security & Safety](#security--safety)

## System Architecture

### Layered Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                      │
│                     (UI, HUD, Menus)                         │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────┴────────────────────────────────────┐
│                      GAMEPLAY LAYER                          │
│         (Player, Cat AI, Items, Interactions)                │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────┴────────────────────────────────────┐
│                      SYSTEMS LAYER                           │
│      (Physics, Audio, Input, Animation, Cinematics)          │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────┴────────────────────────────────────┐
│                       CORE LAYER                             │
│         (Game Loop, State Manager, Event Bus)                │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────┴────────────────────────────────────┐
│                      ENGINE LAYER                            │
│         (Renderer, Physics Engine, Asset Manager)            │
└─────────────────────────────────────────────────────────────┘
```

### Component-Based Architecture

All game objects follow an Entity-Component-System (ECS) pattern for maximum flexibility and performance.

```
┌──────────────────────────────────────┐
│              ENTITY                   │
│  (GameObject: Player, Cat, Item)      │
└───────────────┬──────────────────────┘
                │
                │ Has Components ↓
                │
    ┌───────────┴───────────────────────┬─────────────────┐
    ↓                   ↓                ↓                 ↓
┌─────────┐      ┌─────────┐      ┌─────────┐      ┌─────────┐
│Transform│      │Renderer │      │Collider │      │Script   │
│Component│      │Component│      │Component│      │Component│
└─────────┘      └─────────┘      └─────────┘      └─────────┘

                    ↓ Processed by ↓

    ┌───────────────┴───────────────────────┬─────────────────┐
    ↓                   ↓                    ↓                 ↓
┌─────────┐      ┌─────────┐      ┌─────────┐      ┌─────────┐
│Movement │      │Rendering│      │Physics  │      │Behavior │
│ System  │      │ System  │      │ System  │      │ System  │
└─────────┘      └─────────┘      └─────────┘      └─────────┘
```

## Core Systems

### 1. Player System

**Responsibility**: Handle all player-related functionality

```
PlayerSystem
├── PlayerController
│   ├── FirstPersonCamera
│   ├── MovementController
│   │   ├── Walk
│   │   ├── Run
│   │   ├── Crouch
│   │   └── Jump
│   ├── LookController
│   │   ├── MouseLook
│   │   └── CameraSmoothing
│   └── InputHandler
│       ├── KeyboardInput
│       ├── MouseInput
│       └── GamepadInput
│
├── InteractionSystem
│   ├── RaycastDetection
│   ├── InteractableHighlight
│   ├── PickupHandler
│   └── UseItemHandler
│
└── InventorySystem
    ├── ItemStorage (9 slots)
    ├── QuickSlots (1-5 keys)
    ├── ItemSwitching
    └── ItemDropping
```

**Key Interfaces**:
```
interface IPlayerController {
    Move(direction: Vector3): void
    Look(delta: Vector2): void
    Interact(): void
    UseItem(): void
    SwitchItem(index: int): void
}

interface IInteractable {
    CanInteract(): boolean
    OnInteract(player: Player): void
    GetPromptText(): string
}
```

### 2. Cat AI System

**Responsibility**: Manage cat behavior, pathfinding, and state transitions

```
CatAISystem
├── BehaviorController
│   ├── StateMachine
│   │   ├── IdleState
│   │   ├── CuteState
│   │   ├── CuriousState
│   │   ├── HuntState
│   │   ├── StalkState
│   │   ├── AttackState
│   │   └── ConvertState
│   │
│   ├── SensorSystem
│   │   ├── VisionCone
│   │   ├── HearingRadius
│   │   └── SmellRadius
│   │
│   └── DecisionMaker
│       ├── ThreatAssessment
│       ├── InterestEvaluation
│       └── ActionSelection
│
├── PathfindingSystem
│   ├── NavMeshAgent
│   ├── ObstacleAvoidance
│   └── JumpPointPlanning
│
└── AnimationController
    ├── LocomotionBlendTree
    ├── EmotiveAnimations
    └── AttackAnimations
```

**State Transition Logic**:
```
StateMachine Rules:
- IDLE → CUTE (if player nearby, no threat detected)
- IDLE → CURIOUS (if interesting object/sound detected)
- CUTE → HUNT (if "awakened" by global event)
- CURIOUS → HUNT (if player makes sudden movement)
- HUNT → STALK (if player in vision range)
- STALK → ATTACK (if within pounce distance)
- ATTACK → CONVERT (if lick connects)
- ANY → IDLE (if distracted by toy/food)
```

**Key Interfaces**:
```
interface ICatBehavior {
    OnEnter(): void
    OnUpdate(deltaTime: float): void
    OnExit(): void
    EvaluateTransitions(): State
}

interface ICatSensor {
    DetectPlayer(): boolean
    DetectThreat(): boolean
    DetectDistraction(): GameObject
}
```

### 3. Item/Weapon System

**Responsibility**: Handle all cat defense items

```
ItemSystem
├── BaseItem (Abstract)
│   ├── ItemData
│   │   ├── Name
│   │   ├── Icon
│   │   ├── UseAnimation
│   │   └── Cooldown
│   │
│   └── ItemBehavior
│       ├── OnEquip()
│       ├── OnUse()
│       └── OnUnequip()
│
├── ProjectileItems
│   ├── YarnBall
│   │   └── Physics-based trajectory
│   ├── FoodCan
│   │   └── Heavy arc
│   └── FeatherToy
│       └── Floaty projectile
│
├── RaycastItems
│   ├── LaserPointer
│   │   └── Instant hit scan
│   └── SprayBottle
│       └── Short-range cone
│
└── PlaceableItems
    └── CardboardBox
        └── Trap placement
```

**Key Interfaces**:
```
interface IUsableItem {
    Use(player: Player, target: Vector3): void
    CanUse(): boolean
    GetCooldownRemaining(): float
}

interface IDistraction {
    GetDistractionScore(): float
    GetEffectRadius(): float
    OnCatDistracted(cat: Cat): void
}
```

### 4. Interaction System

**Responsibility**: Manage all interactive objects in the environment

```
InteractionSystem
├── InteractableRegistry
│   └── TrackedObjects[]
│
├── InteractableTypes
│   ├── DoorInteractable
│   ├── DrawerInteractable
│   ├── ApplianceInteractable
│   ├── FurnitureInteractable
│   └── PickupInteractable
│
└── HighlightSystem
    ├── OutlineRenderer
    └── PromptDisplay
```

**Examples**:
- Kettle: Turn on/off, steam effect, sound
- TV: Change channels, trigger news cutscene
- Fridge: Open/close, get food items
- Window: Look outside, see cat chaos
- Bed: Hide under (stealth mechanic)

### 5. Cinematic System

**Responsibility**: Handle cutscenes, camera transitions, dialogue

```
CinematicSystem
├── SequenceManager
│   ├── Timeline
│   ├── CameraShots
│   └── EventTriggers
│
├── DialogueSystem
│   ├── TextDisplay
│   ├── CharacterPortraits
│   └── ChoiceHandler (future)
│
└── CameraDirector
    ├── VirtualCameras
    ├── CameraPaths
    └── TransitionEffects
```

**Cinematic Triggers**:
1. Morning wake-up (skippable)
2. News broadcast (mandatory)
3. Cat transformation (mandatory)
4. First attack (tutorial popup)
5. Roommate dialogue (contextual)

### 6. Audio System

**Responsibility**: Dynamic audio mixing and transitions

```
AudioSystem
├── MusicManager
│   ├── LayeredTracks
│   │   ├── LoFiAmbient (Phase 1)
│   │   ├── TensionLayer (Phase 2)
│   │   └── HorrorScore (Phase 3)
│   │
│   └── TransitionEngine
│       ├── CrossFade
│       └── StingerSystem
│
├── SFXManager
│   ├── 3DSpatialSound
│   ├── FootstepSystem
│   └── CatVocalizations
│       ├── Purr (cute mode)
│       ├── Hiss (attack mode)
│       └── GlitchedMeow (transition)
│
└── AmbienceSystem
    ├── RoomTone
    ├── OutdoorAmbience
    └── EventAmbience
```

**Audio States**:
```
Phase 1 (Cozy):
- Lo-fi beats (60-80 BPM)
- Soft room ambience
- Normal cat sounds
- Kettle, TV, roommate sounds

Phase 2 (Tension):
- Music tempo increases
- Distorted purring begins
- Reversed meows
- Glitchy TV static

Phase 3 (Horror):
- Full horror score
- Surround sound cat snarls
- Flickering light buzz
- Heartbeat layer
```

### 7. UI System

**Responsibility**: All user interface elements

```
UISystem
├── HUD
│   ├── CrosshairReticle
│   ├── ItemSlots (1-9)
│   ├── HealthDisplay (future)
│   └── ObjectiveTracker
│
├── Menus
│   ├── MainMenu
│   ├── PauseMenu
│   ├── SettingsMenu
│   └── LoadingScreen
│
└── TutorialSystem
    ├── PopupPrompts
    ├── HighlightedControls
    └── ProgressionGating
```

## Data Flow

### Input → Action → Response

```
    USER INPUT
        ↓
    ┌───────────────┐
    │ Input Manager │
    └───────┬───────┘
            │
    ┌───────┴────────┬──────────────┬────────────┐
    ↓                ↓              ↓            ↓
[Movement]      [Interact]      [UseItem]   [Menu]
    ↓                ↓              ↓            ↓
PlayerController  RaycastCheck  ItemSystem   UIManager
    ↓                ↓              ↓            ↓
Transform        Interactable   CatAI        MenuState
    ↓                ↓              ↓            ↓
Animation        Response      Reaction      Display
    ↓                ↓              ↓            ↓
    └────────────────┴──────────────┴────────────┘
                     ↓
              RENDER FRAME
```

### Event-Driven Architecture

```
Event Bus (Central)
    │
    ├─→ PlayerMovedEvent → CatAI (update pursuit)
    ├─→ ItemUsedEvent → SFX (play sound)
    ├─→ CatAttackEvent → UI (show warning)
    ├─→ DoorOpenedEvent → Audio (play creak)
    ├─→ GameStateChangedEvent → Multiple systems
    └─→ CinematicStartEvent → Freeze gameplay
```

**Key Events**:
```
enum GameEvent {
    // Player events
    PLAYER_MOVED,
    PLAYER_INTERACTED,
    PLAYER_USED_ITEM,
    PLAYER_DAMAGED,
    PLAYER_CONVERTED,

    // Cat events
    CAT_SPAWNED,
    CAT_STATE_CHANGED,
    CAT_ATTACKED,
    CAT_DISTRACTED,
    CAT_DEFEATED,

    // World events
    DOOR_OPENED,
    ITEM_PICKED_UP,
    CUTSCENE_STARTED,
    CUTSCENE_ENDED,

    // Global events
    CATPOCALYPSE_BEGINS,
    LEVEL_COMPLETED,
    GAME_OVER
}
```

## Module Dependencies

### Dependency Graph

```
┌──────────┐
│   UI     │──────┐
└──────────┘      │
                  ↓
┌──────────┐  ┌──────────┐
│ Gameplay │→ │  Core    │
└──────────┘  └──────────┘
     ↓             ↓
┌──────────┐  ┌──────────┐
│ Systems  │→ │  Engine  │
└──────────┘  └──────────┘

No circular dependencies allowed!
```

### Import Rules

- **UI** can import from: Gameplay, Core
- **Gameplay** can import from: Systems, Core
- **Systems** can import from: Core, Engine
- **Core** can import from: Engine only
- **Engine** has no game-specific imports

## Performance Considerations

### Target Performance

```
Platform: PC (Mid-range)
Target FPS: 60
Resolution: 1920x1080
Memory Budget: 4GB

Breakdown:
- Engine/Framework: 500MB
- Assets (loaded): 1.5GB
- Cat AI (20 cats): 200MB
- Audio buffers: 300MB
- UI/Textures: 500MB
- Headroom: 1GB
```

### Optimization Strategies

**Cat AI**:
- Max 20 cats active at once
- Disable AI for cats outside player view
- LOD system for distant cats
- Simple behavior when not in focus

**Rendering**:
- Occlusion culling for rooms
- LOD models for cats (3 levels)
- Texture streaming
- Baked lighting where possible

**Physics**:
- Simplified colliders for furniture
- Static colliders for non-moving objects
- Ragdoll only on cat defeat
- Spatial hashing for collision detection

**Audio**:
- 3D audio only within 20m radius
- 2D audio for distant chaos
- Audio pooling (max 32 sources)
- Compressed audio formats

## Security & Safety

### Save System Integrity

```
SaveData Structure:
{
    version: string,
    timestamp: number,
    checksum: hash,
    playerData: {
        position: Vector3,
        inventory: Item[],
        progress: flags
    },
    worldState: {
        doors: state[],
        items: position[],
        cats: state[]
    }
}
```

### Modding Support (Future)

```
Safe Modding API:
- Exposed: Asset replacement, level scripting
- Protected: Core systems, save manipulation
- Sandboxed: Custom scripts run in isolated context
```

### Anti-Cheat (Single-Player)

Not critical for single-player, but:
- Validate save checksums
- Detect memory manipulation (optional)
- Log unusual behavior for debugging

## Technology Stack (TBD)

See [ADR-001: Engine Selection](architecture/adr-001-engine-selection.md) for detailed analysis.

**Options under consideration**:
1. **Unity** - Mature, asset store, C#
2. **Godot** - Free, lightweight, GDScript/C#
3. **Unreal** - AAA quality, Blueprints, C++
4. **Custom Engine** - Full control, high effort

**Current Recommendation**: Godot 4.x for indie development speed and flexibility.

---

**Last Updated**: January 2026
**Status**: Living Document - Will evolve during development
