# frozen_string_literal: true

module Verb
  class Go < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    # @return [String (frozen)]
    def contextual_response
      destination = state.player_location.movements[noun]

      if noun.nil?
        "You will need to say where you want me to go."
      elsif destination.nil?
        "I can't go #{noun} from here."
      else
        new_location_id = destination["location_id"]
        transition_description = destination.dig("description", "general")
        player_health_change = destination.dig("effects", "player_health") || 0

        state.player.health += player_health_change
        state.player_location_id = new_location_id
        transition_description || ""
      end
    end
  end
end
