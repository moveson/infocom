# frozen_string_literal: true

module Verb
  class Open < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want to open."
      elsif item.nil?
        "I don't see #{noun.articleize} here."
      elsif item.location_key == state.player_location_key || item.location_key == "inventory"
        if item.opened?
          "The #{noun} is already open."
        elsif item.container? && item.unlocked?
          item.opened = true
          "You open the #{noun}."
        elsif item.container? && item.lockable?
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
