# frozen_string_literal: true

module Verb
  class Lock < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to lock."
      elsif subject_item.nil?
        "I don't see #{noun.articleize} here."
      elsif subject_item.location_key == state.player_location_id || subject_item.location_key == "inventory"
        if subject_item.locked?
          "The #{noun} is already locked."
        elsif state.inventory.any? { |item| item.can_unlock == noun }
          subject_item.locked = true
          "You lock the #{noun}."
        elsif subject_item.lockable?
          "You don't have anything that will lock the #{noun}."
        else
          "You can't lock the #{noun}."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
