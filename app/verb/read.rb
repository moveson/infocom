# frozen_string_literal: true

module Verb
  class Read < ::BaseVerb
    def execute
      item = state.items[noun&.to_sym]

      if noun.nil?
        puts "You will need to say what you want me to read."
      elsif item.nil?
        puts "I don't see a #{noun} here."
      elsif item.location_key == state.location_key
        puts "You have to hold something before reading it."
      elsif item.location_key == :inventory
        if item.text.present?
          puts "It says, '#{item.text}'"
        else
          puts "There's nothing to read on the #{item.name}."
        end
      else
        puts "I don't see a #{noun} here."
      end
    end
  end
end
