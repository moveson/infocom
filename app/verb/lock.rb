# frozen_string_literal: true

module Verb
  class Lock < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to lock."
      elsif item.nil?
        "I don't see a #{noun} here."
      elsif item.location_key == state.player_location_key || item.location_key == "inventory"
        if item.locked?
          "The #{noun} is already locked."
        elsif state.inventory.any? { |item| item.can_unlock == noun }
          item.locked = true
          "You lock the #{noun}."
        elsif item.lockable?
          "You don't have anything that will lock the #{noun}."
        else
          "You can't lock the #{noun}."
        end
      else
        "I don't see a #{noun} here."
      end
    end
  end
end
