# frozen_string_literal: true

module Verb
  class Look < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    # @return [String (frozen)]
    def contextual_response
      if noun.nil? || noun == "around"
        state.player_location.general_description
      else
        Describe.execute(command, state)
      end
    end
  end
end
