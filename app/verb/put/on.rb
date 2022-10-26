# frozen_string_literal: true

require "./app/verb/drop"

module Verb
  class Put < ::BaseVerb
    class On < ::BaseVerb
      # @return [String (frozen)]
      def execute
        proposed_parent = state.items_by_id[object]

        if object.nil?
          "What do you want to put the #{noun} on?"
        elsif object == "ground" || object == "floor"
          Drop.execute(command, state)
        elsif proposed_parent.present?
          if proposed_parent == item
            "You can't put something onto itself."
          elsif state.items_at_player_location.include?(proposed_parent) || state.inventory.include?(proposed_parent)
            if proposed_parent.surface?
              item.location_key = "items.#{proposed_parent.id}"
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
