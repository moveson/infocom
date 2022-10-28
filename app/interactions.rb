# frozen_string_literal: true

class Interactions
  def self.visible_characters(state)
    result = state.characters_at_player_location
    result << state.characters_by_id["self"]
    result
  end

  def self.item_takeable?(item, state)
    takeable_items(state).include?(item)
  end

  def self.parent_can_accept_child?(proposed_parent, proposed_child, state)
    return false unless proposed_parent.container? && proposed_parent.opened?

    existing_children = state.children_of_item(proposed_parent)
    remaining_capacity = proposed_parent.capacity - existing_children.sum(&:size)
    remaining_capacity >= proposed_child.size
  end

  def self.takeable_items(state)
    visible_items(state) - state.inventory
  end

  def self.visible_items(state)
    visible_parent_items = state.items_at_player_location + state.inventory
    result = visible_parent_items

    visible_parent_items.each do |item|
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
