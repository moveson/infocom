# frozen_string_literal: true

module Verb
  class Open < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to open."
      elsif subject_item.nil?
        "I don't see #{noun.articleize} here."
      elsif subject_item.location_key == state.player_location_id || subject_item.location_key == "inventory"
        if subject_item.opened?
          "The #{noun} is already open."
        elsif subject_item.container? && subject_item.unlocked?
          subject_item.opened = true
          "You open the #{noun}."
        elsif subject_item.container? && subject_item.lockable?
          "The #{noun} is locked."
        else
          "You are unable to open the #{noun}."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
