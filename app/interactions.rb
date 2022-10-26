# frozen_string_literal: true

class Interactions
  def self.item_takeable?(item, state)
    item.location_key == state.player_location_id ||
      state.items_at_player_location.select(&:children_visible?).map(&:id).include?(item.parent_item_id)
  end

  def self.visible_items(state)
    items_at_player_location = state.items_at_player_location
    result = []
    result += state.inventory
    result += items_at_player_location

    items_at_player_location.each do |item|
      next unless item.children_possible?

      result += visible_children_of_item(item, state)
    end

    result
  end

  def self.visible_children_of_item(item, state)
    if item.children_visible?
      state.children_of_item(item)
    else
      []
    end
  end
end
