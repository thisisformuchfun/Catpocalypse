# Quick Start Guide

Get up and running with Schrödinger's Catpocalypse development in 5 minutes!

## Prerequisites

- [ ] Git installed
- [ ] Engine installed (TBD - see [ADR-001](docs/architecture/adr-001-engine-selection.md))
- [ ] Basic knowledge of game development
- [ ] Love for cats (required!)

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/thisisformuchfun/Catpocalypse.git
cd Catpocalypse
```

### 2. Install Engine

**Option A: Godot 4.2+ (Recommended)**
- Download from [godotengine.org](https://godotengine.org/download)
- Extract and run Godot
- Import project: Select `project.godot` in this directory

**Option B: Unity 2022 LTS**
- Download Unity Hub
- Install Unity 2022 LTS
- Open project directory

**Option C: Unreal Engine 5.3+**
- Install Epic Games Launcher
- Install UE 5.3+
- Open `.uproject` file

### 3. First Run

**Godot**:
```bash
godot project.godot
# Press F5 to run
```

**Unity**:
- Open project in Unity Hub
- Press Play in editor

**Unreal**:
- Open project
- Click Play

## Project Structure

```
Catpocalypse/
├── assets/         # All game assets
├── scripts/        # Game logic
├── src/            # Core engine code
├── design/         # Design docs
├── docs/           # Technical docs
└── tests/          # Tests
```

## Key Documentation

Start here:
1. [README.md](README.md) - Project overview
2. [ARCHITECTURE.md](docs/ARCHITECTURE.md) - System design
3. [DESIGN_DECISIONS.md](docs/DESIGN_DECISIONS.md) - Why we made certain choices
4. [ROADMAP.md](docs/ROADMAP.md) - Development timeline
5. [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute

## Current Status

**Phase**: Pre-Production (Phase 0)
**Next Milestone**: Vertical Slice (Month 2)

**What to work on**:
- See [ROADMAP.md](docs/ROADMAP.md) for current phase tasks
- Check [Issues](https://github.com/thisisformuchfun/Catpocalypse/issues) for open tasks

## Development Workflow

1. Create feature branch:
   ```bash
   git checkout -b feature/your-feature
   ```

2. Make changes

3. Test thoroughly

4. Commit with clear message:
   ```bash
   git commit -m "feat(cat-ai): add cute state"
   ```

5. Push and open PR:
   ```bash
   git push origin feature/your-feature
   ```

## Getting Help

- Read the [docs](docs/)
- Check [closed issues](https://github.com/thisisformuchfun/Catpocalypse/issues?q=is%3Aissue+is%3Aclosed)
- Open a new issue
- Ask in discussions

## Next Steps

- [ ] Read ARCHITECTURE.md
- [ ] Explore codebase
- [ ] Run existing scenes (when available)
- [ ] Pick a task from roadmap
- [ ] Have fun! 🐱

---

**Welcome to the Catpocalypse!**
