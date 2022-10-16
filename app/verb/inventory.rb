# frozen_string_literal: true

module Verb
  class Inventory < ::BaseVerb
    def execute
      if state.inventory.present?
        state.inventory.each do |item|
          puts "You have a #{item.name.downcase}"
        end
      else
        puts "You are not carrying anything."
      end
    end
  end
end
