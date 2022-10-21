# frozen_string_literal: true

module Verb
  class Unlock < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to unlock."
      elsif item.nil?
        "I don't see a #{noun} here."
      elsif item.location_key == state.player_location_key || item.location_key == "inventory"
        if state.inventory.any? { |item| item.can_unlock == noun }
          item.locked = false
          "You unlock the #{noun}."
        else
          "You are unable to unlock the #{noun}."
        end
      else
        "I don't see a #{noun} here."
      end
    end
  end
end