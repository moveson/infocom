# frozen_string_literal: true

module Verb
  class Describe < ::BaseVerb
    def execute
      item = state.items[noun]

      if noun.nil?
        puts "You will need to say what you want me to describe."
      elsif item.nil?
        puts "I don't see a #{noun} here."
      elsif item.location_key == state.location_key || item.location_key == "inventory"
        puts "It is #{item.description}"
      else
        puts "I don't see a #{noun} here."
      end
    end
  end
end
