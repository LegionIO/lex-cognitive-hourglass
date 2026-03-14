# frozen_string_literal: true

require 'securerandom'
require_relative 'cognitive_hourglass/version'
require_relative 'cognitive_hourglass/helpers/constants'
require_relative 'cognitive_hourglass/helpers/grain'
require_relative 'cognitive_hourglass/helpers/hourglass'
require_relative 'cognitive_hourglass/helpers/hourglass_engine'
require_relative 'cognitive_hourglass/runners/cognitive_hourglass'
require_relative 'cognitive_hourglass/client'

module Legion
  module Extensions
    module CognitiveHourglass
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
