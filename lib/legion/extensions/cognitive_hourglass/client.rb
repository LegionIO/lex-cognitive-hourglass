# frozen_string_literal: true

require 'legion/extensions/cognitive_hourglass/helpers/constants'
require 'legion/extensions/cognitive_hourglass/helpers/grain'
require 'legion/extensions/cognitive_hourglass/helpers/hourglass'
require 'legion/extensions/cognitive_hourglass/helpers/hourglass_engine'
require 'legion/extensions/cognitive_hourglass/runners/cognitive_hourglass'

module Legion
  module Extensions
    module CognitiveHourglass
      class Client
        include Runners::CognitiveHourglass

        def initialize(**)
          @hourglass_engine = Helpers::HourglassEngine.new
        end

        private

        attr_reader :hourglass_engine
      end
    end
  end
end
