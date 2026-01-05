# ADR-004: Audio Architecture

**Status**: Proposed
**Date**: January 2026
**Deciders**: Lead Developer, Audio Designer
**Priority**: High (Critical to emotional impact)

## Context and Problem Statement

Audio is **essential** to Schrödinger's Catpocalypse's emotional journey. We need:
- Seamless transition from cozy lo-fi to horror soundscape
- Dynamic music that responds to game state
- Spatial 3D audio for cat positioning
- Layered, adaptive audio mixing
- High-quality sound design on indie budget

**Core Challenge**: Create a AAA-feeling audio experience with limited resources and technical complexity.

## Decision Drivers

1. **Emotional Impact**: Audio drives the tonal shift
2. **Dynamic Response**: Music adapts to gameplay
3. **Performance**: Low CPU overhead
4. **Budget**: Free or low-cost tools
5. **Implementation Complexity**: Achievable for small team
6. **Platform Support**: Works on all target platforms

## Considered Options

### Option 1: Simple Audio Player (Engine Built-In)

**Approach**: Use Godot's AudioStreamPlayer nodes directly

```gdscript
# Play music
music_player.stream = lo_fi_track
music_player.play()

# Transition
music_player.stop()
horror_player.play()
```

**Pros**:
- ✅ Zero additional cost
- ✅ Simplest implementation
- ✅ No external dependencies
- ✅ Lightweight

**Cons**:
- ❌ No dynamic layering
- ❌ Jarring transitions
- ❌ Hard to sync layers
- ❌ Manual mixing complexity
- ❌ No advanced features (ducking, sidechaining)

---

### Option 2: Audio Middleware (FMOD / Wwise)

**Approach**: Use professional audio middleware

**FMOD**:
- Free for indie (< $500k revenue)
- Visual audio editor
- Dynamic mixing, layering, parameters
- Industry standard

**Wwise**:
- Free for indie (< $150k revenue)
- More complex than FMOD
- Powerful but steep learning curve

**Pros**:
- ✅ Professional-grade features
- ✅ Visual design tools
- ✅ Dynamic music system built-in
- ✅ Advanced 3D audio
- ✅ Proven in AAA games

**Cons**:
- ❌ Learning curve (new tools)
- ❌ Export complexity (licensing, integration)
- ❌ Larger build size
- ❌ Overkill for small project
- ❌ External dependency
- ❌ Revenue limits

---

### Option 3: Custom Audio Manager (Godot + Code)

**Approach**: Build a layer on top of Godot's audio system

```gdscript
class AudioManager:
    var music_layers = {
        "lo_fi": AudioStreamPlayer,
        "tension": AudioStreamPlayer,
        "horror": AudioStreamPlayer
    }

    func set_tension_level(level: float):
        # Crossfade between layers
        music_layers["lo_fi"].volume_db = lerp(0, -80, level)
        music_layers["tension"].volume_db = lerp(-80, 0, level)
```

**Pros**:
- ✅ Full control
- ✅ No external dependencies
- ✅ Tailored to exact needs
- ✅ Lightweight
- ✅ Free

**Cons**:
- ❌ Manual implementation
- ❌ No visual tools
- ❌ Debugging is harder
- ❌ Re-inventing the wheel

---

### Option 4: Open-Source Audio Engine (OpenAL, Miniaudio)

**Approach**: Use lower-level audio libraries

**Pros**:
- ✅ Full control
- ✅ High performance
- ✅ Cross-platform

**Cons**:
- ❌ Very low-level (lots of boilerplate)
- ❌ No high-level features out-of-box
- ❌ Steep learning curve
- ❌ Overkill for needs

---

## Decision Matrix

| Criterion              | Built-In | FMOD  | Custom Mgr | Low-Level |
|------------------------|----------|-------|------------|-----------|
| Cost                   | 10/10    | 9/10  | 10/10      | 10/10     |
| Ease of Use            | 8/10     | 7/10  | 6/10       | 3/10      |
| Dynamic Features       | 3/10     | 10/10 | 7/10       | 5/10      |
| Performance            | 8/10     | 7/10  | 9/10       | 10/10     |
| Learning Curve         | 10/10    | 5/10  | 8/10       | 3/10      |
| Flexibility            | 5/10     | 9/10  | 8/10       | 10/10     |
| **Total**              | **44**   | **47**| **48**     | **41**    |

## Decision Outcome

### Chosen Option: **Custom Audio Manager** (Godot + Custom Code)

**Rationale**:

1. **Just Right**: Enough features, not overkill
2. **No Dependencies**: Pure Godot, easy to maintain
3. **Tailored**: Built exactly for our needs
4. **Free**: Zero licensing concerns
5. **Learning Opportunity**: Understand audio systems deeply
6. **Lightweight**: Minimal overhead

**We will build**:
- Layered music system
- Dynamic mixer
- 3D spatial audio wrapper
- Sound pool management
- Event-driven sound triggers

**If Custom System Proves Insufficient**:
- Fallback to FMOD (has free indie tier)
- Evaluate after vertical slice

## Audio System Design

### Architecture

```
┌─────────────────────────────────────────────────────┐
│                   AUDIO MANAGER                      │
│                    (Singleton)                       │
├─────────────────────────────────────────────────────┤
│                                                      │
│  ┌──────────────────┐  ┌──────────────────┐         │
│  │  Music System    │  │   SFX System     │         │
│  ├──────────────────┤  ├──────────────────┤         │
│  │ • Layers         │  │ • 2D Sounds      │         │
│  │ • Crossfade      │  │ • 3D Sounds      │         │
│  │ • Dynamic Mix    │  │ • Sound Pools    │         │
│  │ • Stingers       │  │ • Priorities     │         │
│  └──────────────────┘  └──────────────────┘         │
│                                                      │
│  ┌──────────────────┐  ┌──────────────────┐         │
│  │ Ambience System  │  │  Voice System    │         │
│  ├──────────────────┤  ├──────────────────┤         │
│  │ • Room Tone      │  │ • Dialogue       │         │
│  │ • Weather        │  │ • Subtitles      │         │
│  │ • Events         │  │ • Priority       │         │
│  └──────────────────┘  └──────────────────┘         │
│                                                      │
│  ┌─────────────────────────────────────────┐        │
│  │        Audio Bus Mixer                  │        │
│  │  Master → Music / SFX / Voice / Ambient │        │
│  └─────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────┘
```

### Music System: Layered Adaptive Audio

**Concept**: Multiple synchronized music layers that fade in/out based on game state

```gdscript
class MusicSystem:
    # Layers (all playing simultaneously, volume controlled)
    var layers = {
        "lo_fi_beat": MusicLayer.new(),      # Base layer
        "lo_fi_melody": MusicLayer.new(),    # Cozy layer
        "tension_strings": MusicLayer.new(), # Building tension
        "horror_bass": MusicLayer.new(),     # Deep dread
        "horror_lead": MusicLayer.new()      # Full panic
    }

    var current_intensity: float = 0.0  # 0.0 = cozy, 1.0 = horror

    func set_intensity(target_intensity: float, duration: float = 2.0):
        # Smoothly transition between states
        var tween = create_tween()
        tween.tween_property(self, "current_intensity", target_intensity, duration)

    func _process(delta):
        # Update layer volumes based on intensity
        layers["lo_fi_beat"].volume = 1.0                           # Always on
        layers["lo_fi_melody"].volume = 1.0 - current_intensity     # Fade out
        layers["tension_strings"].volume = smoothstep(0.3, 0.7, current_intensity)
        layers["horror_bass"].volume = smoothstep(0.5, 0.9, current_intensity)
        layers["horror_lead"].volume = smoothstep(0.7, 1.0, current_intensity)
```

**Music Layers**:

```
Intensity 0.0 (Morning Routine):
  🔊 Lo-Fi Beat (100%)
  🔊 Lo-Fi Melody (100%)
  🔇 Tension Strings (0%)
  🔇 Horror Bass (0%)
  🔇 Horror Lead (0%)

Intensity 0.3 (News Broadcast):
  🔊 Lo-Fi Beat (100%)
  🔉 Lo-Fi Melody (70%)
  🔉 Tension Strings (30%)
  🔇 Horror Bass (0%)
  🔇 Horror Lead (0%)

Intensity 0.6 (Cat Transformation):
  🔊 Lo-Fi Beat (100%)
  🔉 Lo-Fi Melody (40%)
  🔊 Tension Strings (80%)
  🔉 Horror Bass (40%)
  🔇 Horror Lead (0%)

Intensity 1.0 (Cat Attack):
  🔊 Lo-Fi Beat (distorted, 100%)
  🔇 Lo-Fi Melody (0%)
  🔊 Tension Strings (100%)
  🔊 Horror Bass (100%)
  🔊 Horror Lead (100%)
```

### Stinger System

**Concept**: Short musical hits that punctuate moments

```gdscript
class StingerSystem:
    var stingers = {
        "cat_notice": preload("res://audio/stingers/cat_notice.ogg"),
        "cat_attack": preload("res://audio/stingers/cat_attack.ogg"),
        "item_pickup": preload("res://audio/stingers/item_pickup.ogg"),
        "door_slam": preload("res://audio/stingers/door_slam.ogg")
    }

    func play_stinger(name: String):
        var player = AudioStreamPlayer.new()
        add_child(player)
        player.stream = stingers[name]
        player.play()
        player.finished.connect(func(): player.queue_free())
```

### 3D Spatial Audio

**Concept**: Cats emit sounds from their positions (crucial for horror)

```gdscript
class SpatialAudioManager:
    var max_distance = 20.0
    var attenuation_model = AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE

    func play_3d_sound(sound: AudioStream, position: Vector3, volume_db = 0.0):
        var player = AudioStreamPlayer3D.new()
        get_tree().root.add_child(player)

        player.stream = sound
        player.position = position
        player.unit_db = volume_db
        player.max_distance = max_distance
        player.attenuation_model = attenuation_model
        player.bus = "SFX"

        player.play()
        player.finished.connect(func(): player.queue_free())

# Usage:
SpatialAudioManager.play_3d_sound(cat_hiss_sound, cat.position)
```

### Sound Pooling

**Problem**: Creating AudioStreamPlayer nodes every sound is expensive

**Solution**: Reuse pool of players

```gdscript
class SoundPool:
    var pool_size = 32
    var available_players = []
    var active_players = []

    func _ready():
        for i in range(pool_size):
            var player = AudioStreamPlayer.new()
            add_child(player)
            available_players.append(player)
            player.finished.connect(func(): _return_to_pool(player))

    func play_sound(sound: AudioStream, bus: String = "SFX"):
        if available_players.is_empty():
            # Pool exhausted, stop oldest sound
            var oldest = active_players.pop_front()
            oldest.stop()
            available_players.append(oldest)

        var player = available_players.pop_back()
        player.stream = sound
        player.bus = bus
        player.play()
        active_players.append(player)

    func _return_to_pool(player: AudioStreamPlayer):
        active_players.erase(player)
        available_players.append(player)
```

### Audio Bus Configuration

```
Master Bus (0 dB)
├─ Music Bus (-3 dB)
│  └─ Sidechain Compressor (ducks during dialogue)
├─ SFX Bus (-1 dB)
│  ├─ Player SFX (footsteps, item use)
│  └─ Cat SFX (purr, meow, hiss)
├─ Ambience Bus (-6 dB)
│  ├─ Room Tone
│  └─ Outside Chaos
└─ Voice Bus (0 dB)
   └─ Dialogue (highest priority)
```

### Event-Driven Sound Triggers

**Concept**: Decouple gameplay events from audio

```gdscript
# Somewhere in game code
EventBus.emit("cat_entered_hunt_mode", cat_id)

# Audio manager listens
func _ready():
    EventBus.connect("cat_entered_hunt_mode", _on_cat_hunt)

func _on_cat_hunt(cat_id):
    play_stinger("cat_notice")
    set_music_intensity(0.6)
    play_3d_sound(hiss_sound, get_cat_position(cat_id))
```

## Audio Content Requirements

### Music Tracks

1. **Lo-Fi Cozy** (Loop, 120s)
   - Beat layer (drums, bass)
   - Melody layer (synth, keys)
   - Genre: Chill lo-fi hip-hop

2. **Tension Strings** (Loop, 120s)
   - String ostinato (violas, cellos)
   - Synced with lo-fi beat tempo
   - Building unease

3. **Horror Score** (Loop, 120s)
   - Deep bass drones
   - Dissonant lead
   - Synced with beat tempo

**Production Plan**:
- Option 1: Commission composer ($500-1000 budget)
- Option 2: Use royalty-free music (epidemic sound, artlist)
- Option 3: Create in-house (if team has music skills)

### Sound Effects Needed

**Player Sounds**:
- Footsteps (wood floor, carpet, tile) - 6 variations each
- Breathing (calm, tense, panicked)
- Item pickup
- Item use (per item type)
- Door open/close
- Drawer open/close

**Cat Sounds**:
- Purr (cute mode) - 3 variations
- Meow (normal) - 5 variations
- Hiss (aggressive) - 4 variations
- Growl (hunt mode) - 3 variations
- Pounce sound (attack)
- **Glitched purr/meow** (transformation) - critical!

**Environment**:
- TV static, channels changing
- Kettle boiling
- Fridge hum
- Clock ticking
- Outside ambience (birds, city)
- Lighting flicker/buzz

**UI Sounds**:
- Menu select
- Menu confirm
- Menu back
- Item switch
- Notification

**SFX Sources**:
- Freesound.org (free, CC licensed)
- Record ourselves (phones, cheap mic)
- Epidemic Sound / Artlist (subscription)

### Voice/Dialogue

**Approach**: Text-only dialogue (no voice acting for MVP)

**Rationale**:
- Budget constraints
- Localization easier
- Faster iteration
- Can add voice acting post-launch if successful

**Alternative**: Use voice synthesis (expressive TTS) for robotic effect?

## Implementation Plan

### Phase 1: Basic Audio (Month 1-2)
- [ ] Set up audio bus structure
- [ ] Implement basic MusicSystem (single track)
- [ ] Implement SoundPool
- [ ] Add player footstep sounds
- [ ] Add basic cat sounds

### Phase 2: Dynamic Music (Month 3-4)
- [ ] Commission/acquire layered music tracks
- [ ] Implement layered music system
- [ ] Implement intensity-based mixing
- [ ] Add stinger system
- [ ] Sync layers perfectly

### Phase 3: Polish (Month 5-7)
- [ ] 3D spatial audio for all cat sounds
- [ ] Reverb per room
- [ ] Full SFX pass (all interactions)
- [ ] Audio ducking (music ducks for dialogue)
- [ ] Mix and master all audio
- [ ] Accessibility: visual sound indicators

## Consequences

### Positive
- Full control over audio system
- Lightweight, performant
- No licensing restrictions
- Tailored to exact needs
- Deep understanding of system

### Negative
- Manual implementation work
- No visual audio tools
- Need to build everything ourselves
- Potential for bugs in custom system

### Neutral
- Learning experience (audio programming)
- Can pivot to FMOD if needed

## Testing Strategy

### Audio Tests
- All layers stay in sync (no drift over time)
- Crossfades are smooth (no pops/clicks)
- 3D audio positioning is accurate
- No audio clipping/distortion
- Acceptable performance (< 5% CPU)

### Playtesting Focus
- Does music transition feel seamless?
- Can players locate cats by sound?
- Is the audio mix balanced (no elements too loud/quiet)?
- Does the intensity ramp feel natural?

## Performance Considerations

### Optimization Strategies
- Compress audio (Ogg Vorbis, 128-192 kbps)
- Stream long tracks (don't load fully into memory)
- Pool AudioStreamPlayer nodes
- Limit max simultaneous 3D sounds (32 max)
- Use distance-based culling (don't play sounds too far away)

## Follow-Up Actions

- [ ] Set up audio bus structure in Godot
- [ ] Implement MusicSystem singleton
- [ ] Implement SoundPool
- [ ] Acquire/create placeholder audio
- [ ] Test layered music synchronization
- [ ] Commission final music tracks
- [ ] Full SFX creation pass

## References

- [Godot Audio System Docs](https://docs.godotengine.org/en/stable/tutorials/audio/)
- [Game Audio Implementation (Wwise Blog)](https://blog.audiokinetic.com/)
- [Dynamic Music in Games (GDC Talks)](https://www.gdcvault.com/)
- [Freesound.org](https://freesound.org/) - Free SFX

---

**Decision Status**: ✅ Finalized
**Implementation Start**: Month 2 (Phase 1)
**Author**: Development Team
