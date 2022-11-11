# frozen_string_literal: true

require "./app/verb/drop"

module Verb
  class Put < ::BaseExecute
    class On < ::BaseExecute
      private

      # @return [String (frozen)]
      def contextual_response
        proposed_parent = object_item

        if object.nil?
          "What do you want to put the #{noun} on?"
        elsif object == "ground" || object == "floor"
          Drop.execute(command, state)
        elsif proposed_parent.present?
          if proposed_parent == subject_item
            "You can't put something onto itself."
          elsif ::Interactions.visible_items(state).include?(proposed_parent)
            if proposed_parent.surface?
              subject_item.location_key = "items.#{proposed_parent.id}"
              "You put the #{noun} on the #{object}."
            else
              Drop.execute(command, state)
              "It falls to the ground."
            end
          else
            "I don't see #{object.articleize} here."
          end
        else
          "I can't put the #{noun} there."
        end
      end
    end
  end
end
