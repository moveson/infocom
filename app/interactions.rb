# frozen_string_literal: true

class Interactions
  def self.item_takeable?(item, state)
    item.location_key == state.player_location_key ||
      state.items_at_player_location.select(&:children_visible?).map(&:id).include?(item.parent_item_id)
  end
end
