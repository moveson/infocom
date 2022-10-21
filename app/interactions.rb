# frozen_string_literal: true

class Interactions
  def self.item_takeable?(item, state)
    item.location_key == state.player_location_key ||
      (state.items_at_player_location.select(&:opened?).map(&:id)).include?(item.container_id)
  end
end
