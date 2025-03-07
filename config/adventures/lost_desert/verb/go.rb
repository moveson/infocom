module LostDesert
  module Verb
    class Go < ::Verb::Go
      def contextual_response
        if state.player_location.id == "snowy_mountains" && noun == "up"
          boots = state.items.find { |item| item.id == "snow_boots" }
          if state.inventory.include?(boots)
            new_location_id = "icy_ledge"
          else
            new_location_id = "bottom_of_gorge"
            state.player.health = 0
          end
          state.player_location_id = new_location_id
        else
          super
        end
      end
    end
    end
  end
