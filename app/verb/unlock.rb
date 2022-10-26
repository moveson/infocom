# frozen_string_literal: true

module Verb
  class Unlock < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to unlock."
      elsif item.nil?
        "I don't see #{noun.articleize} here."
      elsif item.location_key == state.player_location_id || item.location_key == "inventory"
        if item.unlocked?
          "The #{noun} is already unlocked."
        elsif state.inventory.any? { |item| item.can_unlock == noun }
          item.locked = false
          "You unlock the #{noun}."
        elsif item.lockable?
          "You don't have anything that will unlock the #{noun}."
        else
          "You are unable to unlock the #{noun}."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
