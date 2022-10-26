# frozen_string_literal: true

module Verb
  class Put < ::BaseExecute
    class In < ::BaseExecute
      # @return [String (frozen)]
      def execute
        proposed_parent = state.items_by_id[object]

        if object.nil?
          "What do you want to put the #{noun} into?"
        elsif proposed_parent.present?
          if proposed_parent == subject_item
            "You can't put something into itself."
          elsif state.items_at_player_location.include?(proposed_parent) || state.inventory.include?(proposed_parent)
            if proposed_parent.container? && proposed_parent.opened?
              subject_item.location_key = "items.#{proposed_parent.id}"
              "You put the #{noun} into the #{object}."
            elsif proposed_parent.container? && proposed_parent.closed?
              "The #{object} is closed."
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
