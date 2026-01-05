# ADR-001: Engine Selection

**Status**: Accepted
**Date**: January 2026
**Decision Date**: January 5, 2026
**Deciders**: Lead Developer
**Priority**: Critical (Blocks all development)

## Context and Problem Statement

We need to select a game engine for Schrödinger's Catpocalypse. This is the most critical technical decision as it affects:
- Development speed and workflow
- Team skill requirements
- Performance characteristics
- Platform support
- Modding capabilities
- Long-term maintenance

**Key Requirements**:
- First-person controller support
- Good 3D rendering capabilities
- Robust physics system
- AI/pathfinding tools
- Audio system (ideally with dynamic mixing)
- Cross-platform builds (Windows, macOS, Linux)
- Active community and documentation
- Budget: $0-500 for engine licensing

## Decision Drivers

1. **Development Speed**: Time-to-prototype
2. **Performance**: 60 FPS on mid-range hardware
3. **Learning Curve**: Existing team expertise
4. **Cost**: Budget constraints
5. **Community**: Asset availability, tutorials, support
6. **Flexibility**: Can we implement unique mechanics?
7. **Export Options**: Multi-platform support

## Considered Options

### Option 1: Unity

**Version**: Unity 2022 LTS or newer

**Pros**:
- ✅ Industry standard, massive community
- ✅ Huge asset store (quick prototyping)
- ✅ Excellent documentation and tutorials
- ✅ Proven for first-person games
- ✅ C# (readable, familiar to many)
- ✅ Visual Studio integration
- ✅ Universal Render Pipeline (URP) for performance
- ✅ Robust physics and navmesh
- ✅ Timeline for cutscenes

**Cons**:
- ❌ Free tier has Unity splash screen
- ❌ Licensing fees if revenue > $200k/year
- ❌ Reputation issues (install fee controversy)
- ❌ Bloated for simple projects
- ❌ Version upgrade headaches
- ❌ Closed source

**Performance**: Excellent (if optimized)
**Cost**: Free (Unity Personal) until $200k revenue
**Learning Curve**: Moderate
**First-Person Support**: ⭐⭐⭐⭐⭐

---

### Option 2: Godot 4.x

**Version**: Godot 4.2 or newer

**Pros**:
- ✅ Completely free and open source (MIT license)
- ✅ Lightweight, fast iteration
- ✅ GDScript (Python-like, easy to learn)
- ✅ Also supports C# and C++
- ✅ Built-in scene system (great for modular design)
- ✅ Growing community, especially for indie devs
- ✅ No licensing fees ever
- ✅ Godot 4.x has major 3D improvements
- ✅ Built-in animation tree
- ✅ Export to all major platforms

**Cons**:
- ❌ Smaller asset marketplace (vs Unity/Unreal)
- ❌ Less AAA game examples
- ❌ 3D performance not as optimized as Unity/Unreal
- ❌ Fewer tutorials for complex 3D games
- ❌ Some features still maturing (Godot 4 is newer)
- ❌ Smaller developer job market (if that matters)

**Performance**: Good (improving with Godot 4)
**Cost**: Free (forever)
**Learning Curve**: Low-Moderate
**First-Person Support**: ⭐⭐⭐⭐ (good but less documented)

---

### Option 3: Unreal Engine 5

**Version**: UE5.3 or newer

**Pros**:
- ✅ AAA-quality graphics (Lumen, Nanite)
- ✅ Best-in-class rendering
- ✅ Free until 1M revenue (5% after)
- ✅ Blueprints (visual scripting, great for designers)
- ✅ Excellent first-person template
- ✅ Industry standard for high-fidelity games
- ✅ Marketplace with quality assets
- ✅ Robust audio system
- ✅ Metahuman for characters (overkill but available)

**Cons**:
- ❌ Huge download size (100+ GB)
- ❌ Overkill for indie project scope
- ❌ Steeper learning curve
- ❌ C++ required for advanced features
- ❌ Long compile times
- ❌ High hardware requirements (for dev and players)
- ❌ Harder to achieve stylized look (pushes toward realism)

**Performance**: Excellent (but high baseline requirements)
**Cost**: Free until $1M revenue, then 5%
**Learning Curve**: Steep
**First-Person Support**: ⭐⭐⭐⭐⭐

---

### Option 4: Custom Engine (Rust + Bevy/Fyrox)

**Approach**: Build on Bevy ECS or Fyrox engine

**Pros**:
- ✅ Full control over architecture
- ✅ Rust = memory safety and performance
- ✅ Bevy has modern ECS architecture
- ✅ No licensing fees
- ✅ Excellent learning experience
- ✅ Cutting-edge tech stack

**Cons**:
- ❌ Massive time investment (6+ months for engine alone)
- ❌ No asset marketplace
- ❌ No visual editor (Bevy)
- ❌ Small community, fewer tutorials
- ❌ Everything built from scratch
- ❌ High risk of never shipping game
- ❌ Debugging tools less mature

**Performance**: Potentially excellent (Rust is fast)
**Cost**: Free
**Learning Curve**: Very Steep
**First-Person Support**: ⭐⭐ (build it yourself)

---

## Decision Matrix

| Criterion              | Unity | Godot | Unreal | Custom |
|------------------------|-------|-------|--------|--------|
| Development Speed      | 9/10  | 8/10  | 6/10   | 2/10   |
| Performance            | 8/10  | 7/10  | 10/10  | 9/10   |
| Learning Curve         | 7/10  | 9/10  | 4/10   | 3/10   |
| Cost                   | 8/10  | 10/10 | 9/10   | 10/10  |
| Community/Assets       | 10/10 | 6/10  | 8/10   | 3/10   |
| First-Person Tools     | 9/10  | 7/10  | 10/10  | 4/10   |
| Cross-Platform         | 9/10  | 9/10  | 8/10   | 7/10   |
| **Total**              | **60**| **56**| **55** | **38** |

## Decision Outcome

### Chosen Option: **Godot 4.x**

**Rationale**:

1. **Free Forever**: No concerns about licensing, revenue sharing, or install fees
2. **Indie-Friendly**: Perfect scope for the project size
3. **Fast Iteration**: Lightweight engine, quick compile times
4. **Open Source**: Can contribute fixes, no black box mysteries
5. **C# Support**: If GDScript becomes limiting, C# is available
6. **Sufficient 3D Capabilities**: Godot 4 has significantly improved 3D rendering
7. **Growing Ecosystem**: Momentum in indie community
8. **Ethical Choice**: No corporate drama, community-driven

**Why not Unity?**:
- Licensing uncertainty (install fee fiasco)
- Overkill for scope
- Want to support open-source gamedev

**Why not Unreal?**:
- Too heavy for the project needs
- Longer iteration cycles
- Want stylized look, not photorealism

**Why not Custom?**:
- Can't afford 6-month engine dev time
- Want to make a game, not an engine

### Secondary Option: Unity (If Godot doesn't work out)

If Godot's 3D performance or tooling proves insufficient during vertical slice:
- Switch to Unity 2022 LTS
- Accept licensing terms
- Leverage asset store for rapid development

## Implementation Plan

### Godot Learning Path (Month 1)
1. Complete Godot FPS tutorial
2. Build simple interaction prototype
3. Test NavMesh with multiple agents
4. Evaluate audio system capabilities
5. Test export to all target platforms

### Decision Point: End of Month 1
- If Godot prototype is smooth → Proceed with Godot
- If major blockers → Switch to Unity

### Tools & Ecosystem
- **IDE**: VS Code with Godot extension
- **Version Control**: Git (already set up)
- **Asset Creation**: Blender (free), GIMP, Audacity
- **Audio Middleware**: Evaluate if Godot's audio system suffices, else consider FMOD

## Consequences

### Positive
- Zero licensing costs
- Fast iteration times
- Learning valuable open-source tech
- Strong ethical stance
- Community support from indie devs

### Negative
- Smaller asset marketplace (more DIY)
- Less polish than Unity/Unreal out-of-box
- Fewer tutorials for complex 3D
- Potential performance tuning needed

### Neutral
- GDScript is new language to learn (but Python-like)
- Community is smaller but growing
- Less "industry standard" on resume

## Risks and Mitigations

### Risk 1: Godot 4.x Stability Issues
- **Mitigation**: Use stable LTS builds only, avoid bleeding edge
- **Fallback**: Unity is always an option

### Risk 2: Performance on Lower-End Hardware
- **Mitigation**: Early performance testing, use LOD, optimize meshes
- **Fallback**: Reduce visual fidelity, target higher min spec

### Risk 3: Missing Features vs Unity/Unreal
- **Mitigation**: Research required features beforehand
- **Fallback**: Implement missing features or switch engines

## Follow-Up Actions

- [x] Finalize engine selection decision
- [ ] Install Godot 4.2+
- [ ] Set up project structure in Godot
- [ ] Complete FPS controller tutorial
- [ ] Build vertical slice prototype
- [ ] Performance test on target hardware

## References

- [Godot 4.x Documentation](https://docs.godotengine.org/en/stable/)
- [Unity Personal Terms](https://unity.com/products/unity-personal)
- [Unreal Engine Licensing](https://www.unrealengine.com/en-US/faq)
- [Bevy Engine](https://bevyengine.org/)

---

**Decision Status**: ✅ Accepted
**Decision Date**: January 5, 2026
**Review Date**: End of Month 1 (for validation)
**Author**: Development Team
