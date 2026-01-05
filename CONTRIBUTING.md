# Contributing to Schrödinger's Catpocalypse

First off, thank you for considering contributing to Schrödinger's Catpocalypse! 🐱

This document provides guidelines for contributing to the project. Following these guidelines helps communicate that you respect the time of the developers managing and developing this open source project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive experience for everyone. We expect all contributors to:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

### Unacceptable Behavior

- Harassment, trolling, or discriminatory comments
- Publishing others' private information without permission
- Any conduct that would be inappropriate in a professional setting

## How Can I Contribute?

### Reporting Bugs

Before submitting a bug report:
- Check the [issue tracker](https://github.com/thisisformuchfun/Catpocalypse/issues) to see if it's already reported
- Try to reproduce the issue on the latest version
- Gather relevant information (OS, engine version, steps to reproduce)

**Bug Report Template**:
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g., Windows 10]
- Engine Version: [e.g., Godot 4.2]
- Game Version: [e.g., v0.1.0]

**Additional context**
Any other relevant information.
```

### Suggesting Features

Feature suggestions are welcome! Please:
- Check existing feature requests first
- Explain the problem your feature solves
- Describe your proposed solution
- Consider how it fits with the game's vision (see [DESIGN_DECISIONS.md](docs/DESIGN_DECISIONS.md))

**Feature Request Template**:
```markdown
**Problem/Need**
What problem does this feature solve?

**Proposed Solution**
How would this feature work?

**Alternatives**
What alternatives have you considered?

**Fits Game Vision**
How does this align with the game's tone and goals?
```

### Contributing Code

We welcome code contributions! Areas where help is appreciated:

- **Bug Fixes**: Fix issues from the issue tracker
- **Features**: Implement planned features (check roadmap)
- **Optimization**: Improve performance
- **Documentation**: Improve code comments, docs
- **Tests**: Add unit or integration tests

**Please don't**:
- Submit massive PRs without prior discussion
- Add features not aligned with game vision (discuss first!)
- Refactor large sections without consensus

### Contributing Assets

We also need:
- 3D models (cats, furniture, items)
- Textures and materials
- Sound effects
- Music tracks
- UI designs

**Asset Guidelines**:
- Must be original work or properly licensed (CC0, CC-BY preferred)
- Follow technical specs (see [Asset Guidelines](docs/ASSET_GUIDELINES.md) - TBD)
- Include source files when possible (Blender, Substance, etc.)

### Contributing Documentation

Documentation is crucial! You can help by:
- Fixing typos and improving clarity
- Adding diagrams or examples
- Writing tutorials
- Translating docs (future)

## Development Setup

### Prerequisites

1. **Engine**: Godot 4.2+ (or Unity/Unreal depending on final decision)
2. **Git**: Version control
3. **IDE**: VS Code with Godot extension (recommended)

### Setup Steps

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Catpocalypse.git
   cd Catpocalypse
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/thisisformuchfun/Catpocalypse.git
   ```

4. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

5. Set up engine (see engine-specific docs)

6. Make your changes

7. Test thoroughly

8. Commit and push

9. Open a Pull Request

## Coding Standards

### GDScript Style (Godot)

Follow the [official Godot GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html).

**Key Points**:
- Use `snake_case` for variables and functions
- Use `PascalCase` for class names
- Indent with tabs (Godot standard)
- Use type hints:
  ```gdscript
  var health: int = 100
  func take_damage(amount: int) -> void:
      health -= amount
  ```

**Example**:
```gdscript
class_name CatAI
extends CharacterBody3D

## Cat AI controller
##
## Manages cat behavior using a finite state machine.
## States: Idle, Cute, Hunt, Stalk, Attack

# Constants
const MAX_SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Exported variables (visible in editor)
@export var aggression_level: float = 0.5
@export var vision_range: float = 15.0

# Private variables
var _current_state: State
var _target: Player

func _ready() -> void:
    _current_state = IdleState.new(self)

func _process(delta: float) -> void:
    _current_state = _current_state.update(delta)
    _current_state.execute(delta)
```

### C# Style (If using Unity)

Follow [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions).

**Key Points**:
- Use `PascalCase` for public members
- Use `camelCase` for private members
- Use `_camelCase` for private fields
- Add XML documentation comments

### General Principles

- **Keep it simple**: Don't over-engineer
- **DRY**: Don't repeat yourself
- **Single Responsibility**: One class, one job
- **Comment complex logic**: Explain the "why," not the "what"
- **Error handling**: Handle edge cases gracefully

## Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Add/modify tests
- `chore`: Build, dependencies, tooling

**Examples**:
```
feat(cat-ai): add Hunt state to FSM

Implement Hunt state with vision cone detection and pathfinding
to last known player position.

Closes #42
```

```
fix(player): prevent double jump exploit

Add ground check cooldown to prevent jump buffering from allowing
multiple jumps.

Fixes #56
```

### Atomic Commits

- Keep commits small and focused
- One logical change per commit
- Commit often (easier to revert if needed)

## Pull Request Process

### Before Opening a PR

- [ ] Code follows style guidelines
- [ ] All tests pass (if applicable)
- [ ] Tested in-game (no new bugs introduced)
- [ ] Documentation updated (if needed)
- [ ] Commit messages are clear
- [ ] Branch is up-to-date with `main`

### PR Template

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Refactoring
- [ ] Documentation
- [ ] Other (specify)

## How to Test
1. Step-by-step testing instructions
2. Expected behavior
3. Edge cases to check

## Screenshots/Videos
If applicable, add visual proof.

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-reviewed code
- [ ] Commented complex code
- [ ] Updated documentation
- [ ] No new warnings
- [ ] Tested in-game

## Related Issues
Closes #issue_number
```

### PR Review Process

1. **Automated Checks**: CI/CD runs (future)
2. **Code Review**: Maintainer reviews code
3. **Feedback**: Address review comments
4. **Approval**: Maintainer approves
5. **Merge**: Maintainer merges (or you if given permission)

### After Merge

- Delete your feature branch
- Pull latest `main`
- Celebrate! 🎉

## Questions?

If you have questions:
- Check existing documentation
- Search closed issues
- Open a discussion on GitHub
- Reach out on Discord (TBD)

## Recognition

Contributors will be credited in:
- Game credits
- README.md contributors section
- Release notes

Thank you for contributing! 🐱✨

---

**Last Updated**: January 2026
