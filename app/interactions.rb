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

  def self.item_visible?(item, state)
    visible_items(state).include?(item)
  end

  def self.items_in_possession(state)
    visible_children = state.inventory.flat_map { |item| visible_children_of_item(item, state) }
    state.inventory + visible_children
  end

  def self.parent_can_accept_child?(proposed_parent, proposed_child, state)
    return false unless proposed_parent.container? && proposed_parent.opened?

    existing_children = children_of_item(proposed_parent, state)
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
      result += visible_children_of_item(item, state)
    end

    result
  end

  def self.visible_children_of_item(item, state)
    return [] unless item.children_visible?

    child_items = children_of_item(item, state)
    result = child_items

    child_items.each do |child_item|
      result += visible_children_of_item(child_item, state)
    end

    result
  end

  def self.children_of_item(item, state)
    state.items.select { |candidate_item| candidate_item.location_key == "items.#{item.id}" }
  end
end
