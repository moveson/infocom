# frozen_string_literal: true

require "./app/player_constants"
require "./app/interactions"

module Verb
  class Get < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if noun == "out"
        "You are going to have to be more specific."
      elsif subject_item && ::Interactions.item_takeable?(subject_item, state)
        remaining_capacity = PlayerConstants::CARRY_CAPACITY_SIZE - state.inventory.sum(&:size)

        if remaining_capacity >= subject_item.size
          subject_item.location_key = "inventory"
          "You take the #{noun}."
        else
          "You can't carry the #{noun}."
        end
      elsif subject_item || subject_character || subject_location_detail?
        "You can't get the #{noun}."
      end
    end
  end
end
