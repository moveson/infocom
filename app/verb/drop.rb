# frozen_string_literal: true

module Verb
  class Drop < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "What did you want to drop?"
      elsif item&.location_key == "inventory"
        item.location_key = state.player_location_key
        "You drop the #{noun}."
      else
        "You aren't carrying #{noun.articleize}."
      end
    end
  end
end
