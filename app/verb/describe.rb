# frozen_string_literal: true

module Verb
  class Describe < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to describe."
      elsif item.nil?
        "I don't see #{noun.articleize} here."
      elsif item.location_key == state.player_location_key || item.location_key == "inventory"
        item.described = true
        "It is #{item.description}"
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
