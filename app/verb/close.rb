# frozen_string_literal: true

module Verb
  class Close < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to close."
      elsif subject_item.nil?
        "I don't see #{noun.articleize} here."
      elsif subject_item.location_key == state.player_location_id || subject_item.location_key == "inventory"
        if subject_item.opened?
          subject_item.opened = false
          "You close the #{noun}."
        else
          "The #{noun} is not open."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
