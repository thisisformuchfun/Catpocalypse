# Godot 4.x Setup Guide

This guide will help you set up the development environment for **Schrödinger's Catpocalypse** using Godot 4.x.

## Prerequisites

### Required Software

1. **Godot Engine 4.2+**
   - Download from: https://godotengine.org/download
   - We recommend using the standard version (not .NET/Mono unless you plan to use C#)
   - Minimum version: 4.2
   - Recommended: Latest stable 4.x release

2. **Git**
   - For version control
   - Download from: https://git-scm.com/

3. **Text Editor / IDE** (Optional but recommended)
   - VS Code with Godot extension
   - Or use Godot's built-in editor

### System Requirements

**Minimum:**
- OS: Windows 10, macOS 10.14, or Linux (Ubuntu 20.04+)
- Processor: x64 architecture, SSE2 support
- Memory: 4 GB RAM
- Graphics: OpenGL 3.3 / Vulkan 1.0 compatible

**Recommended:**
- OS: Windows 11, macOS 12+, or Linux (Ubuntu 22.04+)
- Processor: Multi-core x64, 2.5 GHz+
- Memory: 8 GB RAM
- Graphics: Dedicated GPU with Vulkan 1.2+ support

## Installation Steps

### 1. Install Godot Engine

**Windows:**
```bash
# Download the .exe from godotengine.org
# No installation needed - just extract and run
```

**macOS:**
```bash
# Download the .dmg from godotengine.org
# Drag Godot.app to Applications folder
```

**Linux:**
```bash
# Download the .x86_64 binary
# Make it executable:
chmod +x Godot_v4.x_linux.x86_64
# Optional: Move to /usr/local/bin for system-wide access
sudo mv Godot_v4.x_linux.x86_64 /usr/local/bin/godot
```

### 2. Clone the Repository

```bash
git clone https://github.com/thisisformuchfun/Catpocalypse.git
cd Catpocalypse
```

### 3. Open Project in Godot

1. Launch Godot Engine
2. Click "Import"
3. Navigate to the cloned repository folder
4. Select `project.godot` file
5. Click "Import & Edit"

The project will open and Godot will import all assets (first time may take a few minutes).

## Project Structure

```
Catpocalypse/
├── project.godot          # Main project file
├── icon.svg               # Project icon
├── scenes/                # Game scenes
│   └── main_menu.tscn    # Main menu scene
├── scripts/               # GDScript files
│   ├── player/           # Player-related scripts
│   ├── cats/             # Cat AI scripts
│   ├── environment/      # Environment interaction scripts
│   ├── ui/               # UI scripts
│   └── managers/         # Game management scripts
└── assets/               # Game assets
    ├── models/           # 3D models
    ├── textures/         # Textures
    ├── audio/            # Sound effects and music
    └── animations/       # Animation files
```

## Running the Game

### From Godot Editor

1. Open the project in Godot
2. Press `F5` or click the "Play" button (▶) in the top-right
3. Or press `F6` to run the current scene

### Keyboard Controls (Development)

| Action | Key(s) |
|--------|--------|
| Move Forward | W |
| Move Backward | S |
| Move Left | A |
| Move Right | D |
| Jump | Space |
| Sprint | Left Shift |
| Interact | E |
| Use Item | Left Mouse Button |
| Pause | Escape |

## Development Workflow

### 1. Creating New Scenes

1. In Godot Editor: Scene → New Scene
2. Add nodes as needed
3. Save to `scenes/` directory with `.tscn` extension

### 2. Writing Scripts

1. Create new `.gd` file in appropriate `scripts/` subdirectory
2. Attach script to node in scene
3. Use GDScript (Python-like syntax)

Example:
```gdscript
extends Node

func _ready():
    print("Hello, Catpocalypse!")
```

### 3. Version Control

```bash
# Create a new branch for your feature
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "feat: add your feature description"

# Push to remote
git push origin feature/your-feature-name
```

## Common Tasks

### Adding 3D Models

1. Place model files (.obj, .gltf, .fbx) in `assets/models/`
2. Godot will automatically import them
3. Drag into scene or create MeshInstance3D node

### Setting Up Audio

1. Place audio files (.ogg, .wav, .mp3) in `assets/audio/`
2. Create AudioStreamPlayer, AudioStreamPlayer2D, or AudioStreamPlayer3D node
3. Assign audio file to the Stream property

### Testing Physics

1. Add CollisionShape3D to nodes that need collision
2. Set physics layers and masks appropriately
3. Use CharacterBody3D for player/NPCs
4. Use RigidBody3D for physics objects

## Debugging

### Godot Debugger

- Press `F7` to step through code
- Use `print()` statements for console output
- View console output in "Output" panel at bottom of editor

### Performance Profiling

- Debug → Profiler
- Monitor FPS, memory usage, physics
- Target: 60 FPS on mid-range hardware

## Exporting Builds

### Export Templates

1. Download export templates: Editor → Manage Export Templates
2. Download templates for your target platforms

### Creating Exports

1. Project → Export
2. Add export preset for your platform
3. Configure settings
4. Export project

**Supported Platforms:**
- Windows (Desktop)
- macOS (Desktop)
- Linux (Desktop)

## Useful Resources

### Official Documentation
- [Godot 4.x Docs](https://docs.godotengine.org/en/stable/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html)
- [3D Tutorial](https://docs.godotengine.org/en/stable/tutorials/3d/index.html)

### Community
- [Godot Forums](https://forum.godotengine.org/)
- [Godot Discord](https://discord.gg/godotengine)
- [r/godot](https://www.reddit.com/r/godot/)

### Tutorials
- [Official First Person Controller Tutorial](https://docs.godotengine.org/en/stable/tutorials/3d/your_first_3d_game.html)
- [GDQuest](https://www.gdquest.com/)
- [Brackeys Godot Tutorials](https://www.youtube.com/@Brackeys)

## Troubleshooting

### Project won't open
- Ensure you're using Godot 4.2+
- Check that `project.godot` exists in the root directory
- Try "Scan" in Godot project manager

### Import errors
- Delete `.godot/` folder and reimport
- Check file formats are supported
- Ensure no corrupted asset files

### Performance issues
- Check Performance Monitor (Debug → Performance Monitor)
- Reduce visual effects, polygon count
- Use LOD (Level of Detail) for distant objects
- Enable MSAA carefully (impacts performance)

### Script errors
- Check Output panel for error messages
- Use debugger (F7) to step through code
- Verify node paths are correct (`$NodeName`)

## Next Steps

After setup, refer to:
- [Architecture Documentation](ARCHITECTURE.md)
- [ADR-001: Engine Selection](architecture/adr-001-engine-selection.md)
- [Contributing Guide](../CONTRIBUTING.md)
- [Development Roadmap](ROADMAP.md)

Start with:
1. Exploring the main menu scene (`scenes/main_menu.tscn`)
2. Reading the player controller script (`scripts/player/player_controller.gd`)
3. Understanding the Cat AI state machine (`scripts/cats/cat_ai.gd`)

Happy developing! 🐱
