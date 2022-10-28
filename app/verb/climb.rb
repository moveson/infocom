# frozen_string_literal: true

require "./app/verb/go"

module Verb
  class Climb < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if state.player_location.neighbors[noun]
        Go.execute(command, state)
      elsif subject_character
        "That would not be polite."
      elsif subject_item || subject_location_detail?
        "You can't climb the #{noun}."
      end
    end
  end
end
