# frozen_string_literal: true

module Verb
  class Read < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to read."
      elsif item.nil?
        "I don't see a #{noun} here."
      elsif item.location_key == state.player_location_key
        "You have to hold something before reading it."
      elsif item.location_key == "inventory"
        if item.text.present?
          "It says, '#{item.text}'"
        else
          "There's nothing to read on the #{item.name}."
        end
      else
        "I don't see a #{noun} here."
      end
    end
  end
end
