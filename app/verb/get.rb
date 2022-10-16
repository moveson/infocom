# frozen_string_literal: true

module Verb
  class Get < ::BaseVerb
    def execute
      if noun.nil?
        puts "You will need to say what you want me to get."
      elsif state.items[noun.to_sym].nil?
        puts "I don't see a #{noun} here."
      elsif state.items[noun.to_sym].location_key == state.location_key
        puts "You take the #{noun}."
        state.items[noun.to_sym].location_key = :inventory
      else
        puts "I don't see a #{noun} here."
      end
    end
  end
end
