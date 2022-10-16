# frozen_string_literal: true

module Verb
  class Go < ::BaseVerb
    # @return [String (frozen)]
    def execute
      new_location_key = state.location.neighbors[noun]

      if noun.nil?
        "You will need to say where you want me to go."
      elsif new_location_key.nil?
        "I can't go #{noun} from here."
      else
        state.location_key = new_location_key
        ""
      end
    end
  end
end
