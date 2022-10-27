# frozen_string_literal: true

module Verb
  class Describe < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to describe."
      elsif state.player_location.description.keys.include?(noun)
        state.player_location.description[noun]
      elsif subject_item.nil?
        "I don't see #{noun.articleize} here."
      elsif subject_item.location_key == state.player_location_id || subject_item.location_key == "inventory"
        subject_item.described = true
        "It is #{subject_item.description}"
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
