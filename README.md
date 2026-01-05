# 🐱 Schrödinger's Catpocalypse

> A first-person adventure-horror-comedy game where adorable cats become humanity's greatest threat

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Development Status](https://img.shields.io/badge/status-pre--alpha-orange.svg)]()

## 🎮 Game Overview

**Schrödinger's Catpocalypse** is a unique blend of cozy slice-of-life simulation and survival horror-comedy. The game begins in your comfortable apartment with your beloved cat, but quickly spirals into chaos as cats worldwide begin their adorable yet terrifying takeover of humanity.

### Core Concept

- **Genre**: First-Person Adventure-Horror-Comedy
- **Tone**: Warm indie → Uncanny → Surreal
- **Gameplay**: Environmental interaction → Cat toy-based combat → Survival
- **Theme**: The duality of cats - cute and deadly, comforting and threatening

## 🎯 Quick Start

```bash
# Clone the repository
git clone https://github.com/thisisformuchfun/Catpocalypse.git

# Navigate to project
cd Catpocalypse

# Install Godot 4.2+ from https://godotengine.org/download
# Open project.godot in Godot Editor

# See GODOT_SETUP.md for detailed setup instructions
```

For detailed setup instructions, see [Godot Setup Guide](docs/GODOT_SETUP.md).

## 📋 Table of Contents

- [Game Design](#game-design)
- [Architecture](#architecture)
- [Features](#features)
- [Development Roadmap](#development-roadmap)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [Documentation](#documentation)

## 🎨 Game Design

### Opening Sequence

**Phase 1: Slice of Life** (5-10 minutes)
- Wake up to your cat's morning routine
- Explore cozy apartment
- Interact with roommate
- Perform daily activities: breakfast, coffee, TV

**Phase 2: The Shift** (2-3 minutes)
- News broadcasts show global cat chaos
- Your cat begins strange behavior
- Tension builds with audiovisual cues

**Phase 3: The Attack** (Tutorial)
- First-person shooter mechanics activate
- Cat toy weapons introduced
- Psychological horror: proximity to cuteness = danger

### Core Mechanics

```
Player Interaction Loop:
┌─────────────────────────────────────────────────┐
│  Explore → Interact → React → Defend → Survive  │
└─────────────────────────────────────────────────┘
           ↓
    ┌──────────────┐
    │  Cat AI      │
    │  Behaviors   │
    ├──────────────┤
    │ • Cute Mode  │ ← Purring, rubbing, meowing
    │ • Hunt Mode  │ ← Stalking, pouncing
    │ • Attack     │ ← One lick = conversion
    └──────────────┘
```

### Arsenal (Non-lethal Defense)

- 🧶 **Yarn Balls** - Distraction tool
- 🎯 **Laser Pointer** - Misdirection device
- 💦 **Spray Bottle** - Deterrent (short range)
- 🥫 **Food Cans** - Bait and distract
- 🪶 **Feather Toys** - Area control
- 📦 **Cardboard Boxes** - Traps and barricades

## 🏗️ Architecture

### High-Level System Design

```
┌─────────────────────────────────────────────────────────────┐
│                     CATPOCALYPSE ENGINE                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   PLAYER     │  │   CAT AI     │  │  ENVIRONMENT │      │
│  │   SYSTEM     │  │   SYSTEM     │  │    SYSTEM    │      │
│  ├──────────────┤  ├──────────────┤  ├──────────────┤      │
│  │ • Movement   │  │ • Behavior   │  │ • Interaction│      │
│  │ • Camera     │  │ • Pathfinding│  │ • Physics    │      │
│  │ • Inventory  │  │ • State Mgmt │  │ • Spawning   │      │
│  │ • Interaction│  │ • Attack AI  │  │ • Triggers   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  CINEMATIC   │  │    AUDIO     │  │      UI      │      │
│  │   SYSTEM     │  │   SYSTEM     │  │    SYSTEM    │      │
│  ├──────────────┤  ├──────────────┤  ├──────────────┤      │
│  │ • Cutscenes  │  │ • Music      │  │ • HUD        │      │
│  │ • Camera     │  │ • SFX        │  │ • Menus      │      │
│  │ • Dialogue   │  │ • Ambience   │  │ • Objectives │      │
│  │ • Triggers   │  │ • Transitions│  │ • Tutorial   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
│  ┌──────────────────────────────────────────────────┐      │
│  │           CORE GAME MANAGER                       │      │
│  │  • State Management  • Save/Load  • Events       │      │
│  └──────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Cat AI State Machine

```
                    ┌─────────┐
                    │  IDLE   │
                    └────┬────┘
                         │
        ┌────────────────┼────────────────┐
        ↓                ↓                ↓
   ┌─────────┐     ┌─────────┐     ┌─────────┐
   │  CUTE   │ ←→  │ CURIOUS │ ←→  │  HUNT   │
   └─────────┘     └─────────┘     └─────────┘
        ↓                               ↓
   ┌─────────┐                    ┌─────────┐
   │ AFFECTION│                    │ STALK   │
   └─────────┘                    └────┬────┘
                                       ↓
                                  ┌─────────┐
                                  │ ATTACK  │
                                  └─────────┘
                                       ↓
                                  ┌─────────┐
                                  │ CONVERT │
                                  └─────────┘
```

### Game State Flow

```
     START
       ↓
┌──────────────┐
│  MAIN MENU   │
└──────┬───────┘
       ↓
┌──────────────┐
│ NEW GAME/    │
│ LOAD GAME    │
└──────┬───────┘
       ↓
┌──────────────┐      ┌─────────────┐
│   MORNING    │  ←→  │  CUTSCENE   │
│  SEQUENCE    │      └─────────────┘
└──────┬───────┘
       ↓
┌──────────────┐
│   THE NEWS   │
│   MOMENT     │
└──────┬───────┘
       ↓
┌──────────────┐
│     THE      │
│   SHIFT      │
└──────┬───────┘
       ↓
┌──────────────┐      ┌─────────────┐
│   GAMEPLAY   │  ←→  │   PAUSE     │
│   (COMBAT)   │      └─────────────┘
└──────┬───────┘
       ↓
┌──────────────┐
│  GAME OVER   │
│      OR      │
│  LEVEL END   │
└──────────────┘
```

## ✨ Features

### Implemented
- ✅ Repository structure
- ✅ Documentation framework
- ✅ Architecture planning
- ✅ Engine selection (Godot 4.x)
- ✅ Basic project setup

### In Progress
- 🚧 Core gameplay systems design
- 🚧 First-person player controller
- 🚧 Cat AI implementation

### Planned

#### Phase 1: Foundation (Months 1-2)
- Player controller (first-person)
- Basic interaction system
- Apartment environment (prototype)
- Cat AI (basic behaviors)

#### Phase 2: Core Gameplay (Months 3-4)
- Weapon/tool system
- Cat AI (full state machine)
- Combat mechanics
- Tutorial system

#### Phase 3: Narrative & Polish (Months 5-6)
- Cinematic system
- Full opening sequence
- Audio implementation
- UI/UX polish

#### Phase 4: Content & Expansion (Months 7+)
- Additional levels
- More cat varieties
- Story expansion
- Playtesting & balancing

## 📁 Project Structure

```
Catpocalypse/
├── assets/                 # Game assets
│   ├── models/            # 3D models (cats, environment, items)
│   ├── textures/          # Textures and materials
│   ├── audio/             # Music, SFX, ambience
│   ├── animations/        # Animation files
│   ├── prefabs/           # Reusable game objects
│   └── scenes/            # Game scenes/levels
│
├── scripts/               # Game logic scripts
│   ├── player/           # Player controller, camera, inventory
│   ├── cats/             # Cat AI, behaviors, animations
│   ├── environment/      # Interactive objects, triggers
│   ├── items/            # Weapon/tool implementations
│   └── managers/         # Game manager, audio manager, etc.
│
├── src/                   # Core engine code
│   ├── core/             # Core game systems
│   ├── gameplay/         # Gameplay systems
│   ├── ui/               # User interface
│   ├── audio/            # Audio engine
│   ├── ai/               # AI systems
│   └── cinematics/       # Cutscene system
│
├── design/                # Game design documents
│   ├── levels/           # Level designs and layouts
│   ├── narrative/        # Story, dialogue, characters
│   └── mechanics/        # Detailed mechanics documentation
│
├── docs/                  # Technical documentation
│   ├── architecture/     # Architecture decision records
│   ├── design-decisions/ # Design decision logs
│   ├── diagrams/         # System diagrams
│   └── api/              # API documentation
│
├── tests/                 # Testing suite
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── e2e/              # End-to-end tests
│
└── tools/                 # Development tools and utilities
```

## 🎯 Development Roadmap

See [ROADMAP.md](docs/ROADMAP.md) for detailed development timeline and milestones.

### Current Phase: **Pre-Alpha - Foundation**

**Immediate Priorities:**
1. ✅ Engine selection (Godot 4.x) - **COMPLETED**
2. ⚡ Prototype player controller (in progress)
3. ⚡ Basic apartment environment
4. ⚡ Single cat AI prototype (in progress)

## 🎨 Art Direction

### Visual Style
- **Early Game**: Warm, pastel colors, soft lighting, cozy indie aesthetic
- **Transition**: Gradual shift to cooler tones, flickering lights, uncanny valley
- **Late Game**: Dim orange lighting, glitchy visuals, surreal atmosphere

### Audio Direction
- **Early Game**: Lo-fi, chill beats, soft synth
- **Transition**: Glitchy purrs, reversed meows, distorted ambient
- **Late Game**: Tense horror soundtrack with comedic stings

## 📖 Documentation

- [Architecture Overview](docs/ARCHITECTURE.md) - Detailed system architecture
- [Design Decisions](docs/DESIGN_DECISIONS.md) - Key design choices and rationale
- [Roadmap](docs/ROADMAP.md) - Development timeline and goals
- [Contributing Guide](CONTRIBUTING.md) - How to contribute
- [API Documentation](docs/api/) - Code API reference

### Architecture Decision Records (ADRs)

- [ADR-001: Engine Selection](docs/architecture/adr-001-engine-selection.md)
- [ADR-002: Cat AI Architecture](docs/architecture/adr-002-cat-ai-architecture.md)
- [ADR-003: Input System](docs/architecture/adr-003-input-system.md)
- [ADR-004: Audio Architecture](docs/architecture/adr-004-audio-architecture.md)

## 🤝 Contributing

This is currently a personal project, but contributions, ideas, and feedback are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

## 🎮 Inspiration

This game draws inspiration from:
- **Goat Simulator** - Absurd physics and humor
- **Resident Evil** - Survival horror tension
- **Untitled Goose Game** - Charming antagonist gameplay
- **Gone Home** - Environmental storytelling
- **The Stanley Parable** - Narrative subversion

## 🐾 Tagline

*"They're cute. They're deadly. They're quantum superpositions of both."*

---

**Status**: 🚧 Pre-Alpha Development
**Started**: January 2026
**Engine**: Godot 4.x
**Target Platform**: PC (Windows/Mac/Linux)
**Developer**: [@thisisformuchfun](https://github.com/thisisformuchfun)
