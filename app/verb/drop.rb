# frozen_string_literal: true

module Verb
  class Drop < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item&.location_key == "inventory"
        subject_item.location_key = state.player_location_id
        "You drop the #{noun}."
      else
        "You aren't carrying #{noun.articleize}."
      end
    end
  end
end
