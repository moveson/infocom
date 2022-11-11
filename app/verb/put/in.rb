# frozen_string_literal: true

module Verb
  class Put < ::BaseExecute
    class In < ::BaseExecute
      private

      # @return [String (frozen)]
      def contextual_response
        proposed_parent = object_item

        if object.nil?
          "What do you want to put the #{noun} into?"
        elsif proposed_parent.present?
          if proposed_parent == subject_item
            "You can't put something into itself."
          elsif ::Interactions.visible_items(state).include?(proposed_parent)
            if ::Interactions.parent_can_accept_child?(proposed_parent, subject_item, state)
              subject_item.location_key = "items.#{proposed_parent.id}"
              "You put the #{noun} into the #{object}."
            elsif proposed_parent.container?
              if proposed_parent.opened?
                "The #{noun} won't fit into the #{object}."
              else
                "The #{object} is closed."
              end
            else
              "You can't put anything into the #{object}."
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
