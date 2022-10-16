# frozen_string_literal: true

module Verb
  class Drop < ::BaseVerb
    # @return [String (frozen)]
    def execute
      item = state.items[noun]

      if noun.nil?
        "What did you want to drop?"
      elsif item.location_key == "inventory"
        item.location_key = state.location_key
        "You drop the #{noun}."
      else
        "You aren't carrying a #{noun}."
      end
    end
  end
end
