# Assets Directory

This directory contains all game assets organized by type.

## Structure

- **models/** - 3D models (.obj, .fbx, .gltf)
- **textures/** - Texture files (.png, .jpg) and materials
- **audio/** - Sound effects, music, ambience (.ogg, .wav)
- **animations/** - Animation files
- **prefabs/** - Reusable game objects
- **scenes/** - Game scenes/levels

## Asset Guidelines

### 3D Models
- **Format**: GLTF/GLB preferred (open standard)
- **Polycount**: 
  - Cat models: 2000-5000 tris
  - Furniture: 500-2000 tris
  - Small items: 100-500 tris
- **Scale**: 1 Blender unit = 1 meter
- **Origin**: Set to base of object

### Textures
- **Resolution**: Power of 2 (512, 1024, 2048)
- **Format**: PNG for transparency, JPEG for opaque
- **Compression**: Enable in engine

### Audio
- **Format**: Ogg Vorbis (compressed) for music/long sounds
- **Format**: WAV (uncompressed) for short SFX (converted to ogg by engine)
- **Sample Rate**: 44.1kHz
- **Bit Depth**: 16-bit

## Licensing

All assets must be:
- Original work
- Properly licensed (CC0, CC-BY preferred)
- Attribution documented in CREDITS.md

## Placeholder Assets

Currently using placeholders for prototyping. Replace before release!
