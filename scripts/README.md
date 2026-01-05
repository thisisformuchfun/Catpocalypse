# Scripts Directory

Game logic scripts organized by functionality.

## Structure

- **player/** - Player controller, camera, inventory
- **cats/** - Cat AI, behaviors, animations
- **environment/** - Interactive objects, triggers, doors
- **items/** - Weapon/tool implementations
- **managers/** - Singletons (GameManager, AudioManager, etc.)

## Coding Guidelines

See [CONTRIBUTING.md](../CONTRIBUTING.md) for full coding standards.

### Key Principles

1. **Keep scripts focused**: One responsibility per script
2. **Use signals for communication**: Decouple systems
3. **Comment complex logic**: Explain the "why"
4. **Use type hints**: Makes code more maintainable
5. **Avoid magic numbers**: Use constants

### Example Script Template

```gdscript
class_name ExampleScript
extends Node

## Brief description of what this script does
##
## Detailed explanation if needed.
## Can span multiple lines.

# Constants
const MAX_VALUE = 100

# Exported variables (visible in editor)
@export var speed: float = 5.0

# Public variables
var is_active: bool = false

# Private variables
var _internal_state: int = 0

# Built-in lifecycle methods
func _ready() -> void:
    pass

func _process(delta: float) -> void:
    pass

# Public methods
func activate() -> void:
    is_active = true

# Private methods
func _update_internal_state() -> void:
    _internal_state += 1
```

## Testing

Add unit tests to `../tests/unit/` for complex logic.
