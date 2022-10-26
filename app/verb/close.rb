# frozen_string_literal: true

module Verb
  class Close < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to close."
      elsif item.nil?
        "I don't see #{noun.articleize} here."
      elsif item.location_key == state.player_location_id || item.location_key == "inventory"
        if item.opened?
          item.opened = false
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
