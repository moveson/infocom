# frozen_string_literal: true

module Verb
  class Inventory < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    # @return [String (frozen)]
    def contextual_response
      if state.inventory.present?
        text_segments = ["You are carrying:"]

        state.inventory.each do |item|
          text_segments << "  #{item.name.articleize}"
        end

        text_segments.join("\n")
      else
        "You are not carrying anything."
      end
    end
  end
end
