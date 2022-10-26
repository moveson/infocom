# frozen_string_literal: true

require "./app/player_constants"
require "./app/interactions"

module Verb
  class Get < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to get."
      elsif item.nil?
        "I don't see #{noun.articleize} here."
      elsif ::Interactions.item_takeable?(item, state)
        remaining_capacity = PlayerConstants::CARRY_CAPACITY_SIZE - state.inventory.sum(&:size)

        if remaining_capacity >= item.size
          item.location_key = "inventory"
          "You take the #{noun}."
        else
          "You can't carry the #{noun}."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
