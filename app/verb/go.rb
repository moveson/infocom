# frozen_string_literal: true

module Verb
  class Go < ::BaseExecute
    # @return [String (frozen)]
    def execute
      new_location_id = state.player_location.neighbors.dig(noun, "location_id")

      if noun.nil?
        "You will need to say where you want me to go."
      elsif new_location_id.nil?
        "I can't go #{noun} from here."
      else
        state.player_location_id = new_location_id
        ""
      end
    end
  end
end
