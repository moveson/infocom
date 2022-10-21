# frozen_string_literal: true

module Verb
  class Put < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "What did you want to put?"
      elsif item.location_key == "inventory"
        if preposition == "in" || preposition == "into"
          proposed_container = state.items_by_id[object]
          if object.nil?
            "What do you want to put the #{noun} into?"
          elsif proposed_container.present?
            if proposed_container == item
              "You can't put something into itself."
            elsif state.items_at_player_location.include?(proposed_container) || state.inventory.include?(proposed_container)
              if proposed_container.container? && proposed_container.opened?
                item.location_key = "items.#{proposed_container.id}"
                "You put the #{noun} into the #{object}."
              elsif proposed_container.container? && proposed_container.closed?
                "The #{object} is closed."
              else
                "You can't put anything into the #{object}."
              end
            else
              "I don't see a #{object} here."
            end
          else
            "I can't put the #{noun} there."
          end
        end
      else
        "You aren't carrying a #{noun}."
      end
    end
  end
end
