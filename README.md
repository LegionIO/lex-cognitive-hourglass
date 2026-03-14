# lex-cognitive-hourglass

Time-bound cognitive resource model for brain-modeled agentic AI in the LegionIO ecosystem.

Sand grains represent attention tokens that flow from the top chamber to the bottom through a
narrowed neck. The hourglass must be flipped to reset the cycle, modeling cognitive depletion
and renewal.

## Concept

Each hourglass tracks a depleting resource (attention, focus, patience, willpower, creativity).
The neck width controls flow rate. When the top chamber empties, the hourglass is expired and
must be flipped. The engine manages multiple hourglasses and advances them each tick.

## Usage

```ruby
require 'legion/extensions/cognitive_hourglass'

client = Legion::Extensions::CognitiveHourglass::Client.new

# Create an hourglass for focused attention
client.create_hourglass(grain_type: :attention, domain: 'planning', neck_width: 0.3)

# Advance all hourglasses one tick
client.flow_tick

# Check overall status
client.time_status

# Flip an expired hourglass to renew it
client.flip(hourglass_id: id)
```

## License

MIT
