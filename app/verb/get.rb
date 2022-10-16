# frozen_string_literal: true

module Verb
  class Get < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to get."
      elsif item.nil?
        "I don't see a #{noun} here."
      elsif item.location_key == state.location_key
        item.location_key = "inventory"
        "You take the #{noun}."
      else
        "I don't see a #{noun} here."
      end
    end
  end
end
