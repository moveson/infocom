# frozen_string_literal: true

module Verb
  class Give < ::BaseExecute
    class To < ::BaseExecute
      private

      # @return [String (frozen)]
      def contextual_response
        if object.nil?
          "Who do you want to give the #{noun} to?"
        elsif object_character.present?
          proposed_trade = object_character.trades.find { |trade| trade["accepts"] == noun }

          if proposed_trade.nil?
            "The #{object} doesn't want the #{noun}."
          else
            dropped_item_id = proposed_trade["gives"]
            state.items_by_id[dropped_item_id].location_key = state.player_location_id
            state.items_by_id[noun].location_key = "hidden"
            proposed_trade["description"]
          end
        elsif object_item || object_location_detail?
          "You can't give something to #{object.articleize}."
        else
          "I don't see #{object.articleize} here."
        end
      end
    end
  end
end
