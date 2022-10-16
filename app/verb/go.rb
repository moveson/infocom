# frozen_string_literal: true

module Verb
  class Go < ::BaseVerb
    def execute
      if noun.nil?
        puts "You will need to say where you want me to go."
        return
      end

      new_location_key = state.location.neighbors[noun.to_sym]

      if new_location_key.nil?
        puts "I can't go #{noun} from here."
      else
        state.location_key = new_location_key.to_sym
      end
    end
  end
end
