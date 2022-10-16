# frozen_string_literal: true

module Verb
  class Drop < ::BaseVerb
    def execute
      if noun.nil?
        puts "What did you want to drop?"
      elsif state.items[noun.to_sym].location_key == :inventory
        puts "You drop the #{noun}."
        state.items[noun.to_sym].location_key = state.location_key
      else
        puts "You aren't carrying a #{noun}."
      end
    end
  end
end
