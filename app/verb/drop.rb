# frozen_string_literal: true

module Verb
  class Drop < ::BaseVerb
    def execute
      item = state.items[noun]

      if noun.nil?
        puts "What did you want to drop?"
      elsif item.location_key == "inventory"
        puts "You drop the #{noun}."
        item.location_key = state.location_key
      else
        puts "You aren't carrying a #{noun}."
      end
    end
  end
end
