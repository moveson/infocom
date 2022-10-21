# frozen_string_literal: true

module Verb
  class Inventory < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if state.inventory.present?
        text_segments = ["You are carrying:"]

        state.inventory.each do |item|
          text_segments << "  a #{item.name.downcase}"
        end

        text_segments.join("\n")
      else
        "You are not carrying anything."
      end
    end
  end
end
