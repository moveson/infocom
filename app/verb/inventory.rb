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
          visible_contents = ::Interactions.visible_children_of_item(item, state)
          additional_text = visible_contents.empty? ? "" : ", which contains:"

          text_segments << "  #{item.name.articleize}#{additional_text}"

          visible_contents.each do |child_item|
            text_segments << "    #{child_item.name.articleize}"
          end
        end

        text_segments.join("\n")
      else
        "You are not carrying anything."
      end
    end
  end
end
