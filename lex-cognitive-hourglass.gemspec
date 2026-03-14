# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_hourglass/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-hourglass'
  spec.version       = Legion::Extensions::CognitiveHourglass::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX CognitiveHourglass'
  spec.description   = 'Time-bound cognitive resource model for brain-modeled agentic AI — ' \
                       'sand grains flow through a narrowed neck, depleting attention resources ' \
                       'until the hourglass is flipped to renew the cycle'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-hourglass'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-hourglass'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-hourglass'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-hourglass'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-hourglass/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-cognitive-hourglass.gemspec Gemfile LICENSE README.md]
  end
  spec.require_paths = ['lib']
end
