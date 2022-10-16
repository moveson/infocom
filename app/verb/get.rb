# frozen_string_literal: true

module Verb
  class Get < ::BaseVerb
    def execute
      item = state.items[noun]

      if noun.nil?
        puts "You will need to say what you want me to get."
      elsif item.nil?
        puts "I don't see a #{noun} here."
      elsif item.location_key == state.location_key
        puts "You take the #{noun}."
        item.location_key = "inventory"
      else
        puts "I don't see a #{noun} here."
      end
    end
  end
end
