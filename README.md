# lex-cognitive-hourglass

Cognitive time-depletion model for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Models cognitive resource depletion using the metaphor of sand flowing through hourglasses. Grains (attention, memory, energy, focus, willpower) are loaded into the upper chamber of an hourglass. Each flow tick moves a fraction from upper to lower at a fixed rate, with a 10% chance of temporary blockage. Urgency rises as the upper chamber empties. Flipping the hourglass returns lower chamber grains back up for reuse. Multiple hourglasses can run concurrently to track different cognitive resources.

## Usage

```ruby
require 'legion/extensions/cognitive_hourglass'

client = Legion::Extensions::CognitiveHourglass::Client.new

# Create resource grains
attention = client.create_grain(grain_type: :attention, domain: :task, content: 'code review session')
grain_id = attention[:grain_id]

# Create an hourglass
hourglass = client.create_hourglass(capacity: 10)
hourglass_id = hourglass[:hourglass_id]

# Flow one tick
client.flow_tick(hourglass_id: hourglass_id)
# => { success: true, state: :flowing, urgency: 0.1, fullness: 0.1 }

# Flip to reset
client.flip(hourglass_id: hourglass_id)
# => { success: true, before: { urgency: 0.9, ... }, after: { urgency: 0.0, ... } }

# List all hourglasses
client.list_hourglasses(limit: 20)
# => { success: true, hourglasses: [...], total: 1 }

# Status overview
client.time_status
# => { success: true, report: { hourglass_count: 1, ... } }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
