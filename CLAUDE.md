# lex-cognitive-hourglass

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-hourglass`

## Purpose

Models time-based cognitive resource depletion using the metaphor of sand flowing through hourglasses. Grains of different types (attention, memory, energy, focus, willpower) are loaded into hourglasses. Each flow tick moves grains from the upper chamber to the lower at `FLOW_RATE`, with a random chance of temporary blockage. Flipping resets the hourglass and rotates the remaining grain back through. Tracks urgency (how empty the upper chamber is) and fullness of the lower chamber.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-hourglass` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveHourglass` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-hourglass |

## File Structure

```
lib/legion/extensions/cognitive_hourglass/
  cognitive_hourglass.rb            # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Grain types, flow states, max counts, rates, urgency/fullness labels
    grain.rb                        # Grain value object
    hourglass.rb                    # Hourglass value object
    hourglass_engine.rb             # Engine: grains, hourglasses, flow, flip, urgency
  runners/
    cognitive_hourglass.rb          # Runner module (extend self)
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `GRAIN_TYPES` | array | `[:attention, :memory, :energy, :focus, :willpower]` |
| `FLOW_STATES` | array | `[:flowing, :blocked, :empty, :full, :idle]` |
| `MAX_HOURGLASSES` | 100 | Hourglass cap |
| `MAX_GRAINS` | 500 | Grain store cap |
| `FLOW_RATE` | 0.05 | Fraction of grains moved per tick |
| `BLOCKAGE_CHANCE` | 0.1 | Probability of flow blockage on each tick |
| `URGENCY_LABELS` | hash | `critical` (0.9+) through `none` |
| `FULLNESS_LABELS` | hash | `full` (0.9+) through `empty` |

## Helpers

### `Grain`

A unit of cognitive resource.

- `initialize(grain_type:, domain:, content:, grain_id: nil)`
- `grain_type`, `domain`, `content`
- `to_h`

### `Hourglass`

A time-tracking vessel with upper/lower chambers.

- `initialize(capacity: 10, hourglass_id: nil)`
- `load_grain(grain_id)` — adds grain to upper chamber; error if at capacity
- `flow_tick!` — moves `FLOW_RATE` fraction from upper to lower; random blockage via `BLOCKAGE_CHANCE`
- `flip!` — resets: lower chamber grains return to upper
- `urgency` — proportion of upper chamber depleted (upper empty = urgency 1.0)
- `fullness` — proportion of lower chamber filled
- `blocked?`, `flowing?`, `empty?`
- `urgency_label`, `fullness_label`
- `to_h`

### `HourglassEngine`

- `create_grain(grain_type:, domain:, content:)` — returns `{ created:, grain_id:, grain: }` or capacity error
- `create_hourglass(capacity: 10)` — returns `{ created:, hourglass_id:, hourglass: }` or capacity error
- `flow_tick(hourglass_id:)` — runs one tick; returns state + urgency + fullness
- `flip(hourglass_id:)` — flips hourglass; returns before/after state
- `most_urgent(limit: 10)` — hourglasses sorted by urgency descending
- `most_depleted(limit: 10)` — hourglasses with most grains in lower chamber
- `flow_report` — full stats

## Runners

**Module**: `Legion::Extensions::CognitiveHourglass::Runners::CognitiveHourglass`

Uses `extend self` pattern.

| Method | Key Args | Returns |
|---|---|---|
| `create_grain` | `grain_type:`, `domain:`, `content:` | `{ success:, grain_id:, grain: }` |
| `create_hourglass` | `capacity: 10` | `{ success:, hourglass_id:, hourglass: }` |
| `flow_tick` | `hourglass_id:` | `{ success:, state:, urgency:, fullness: }` |
| `flip` | `hourglass_id:` | `{ success:, before:, after: }` |
| `list_hourglasses` | `limit: 50` | `{ success:, hourglasses:, total: }` |
| `time_status` | — | `{ success:, report: }` |

Private: `hourglass(engine)` — memoized `HourglassEngine`. Logs via `log_debug` helper.

## Integration Points

- **`lex-cognitive-fatigue-model`**: Fatigue depletion rates per channel map to grain flow rates per hourglass. High urgency in an attention hourglass corresponds to attention channel depletion in the fatigue model.
- **`lex-cognitive-homeostasis`**: Urgency readings from hourglasses can drive perturbation of corresponding homeostasis variables (e.g., full urgency on `:focus` hourglass perturbs the focus variable out of range).
- **`lex-tick`**: Hourglass urgency provides a natural time-pressure signal for tick mode selection. High urgency across multiple grain types could push the agent from `:dormant` to `:sentinel` mode.

## Development Notes

- `BLOCKAGE_CHANCE = 0.1` means approximately 1 in 10 flow ticks will stall. Blocked hourglasses do not move grains; urgency continues to accumulate on the blocked tick.
- `flip!` moves grains from lower back to upper — it does not reset the hourglass to a clean state. Grains that flowed through remain; the count relationship just reverses.
- `flow_tick` with an already-empty upper chamber returns `state: :empty` without error.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
