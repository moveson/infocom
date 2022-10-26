# frozen_string_literal: true

require "active_support/core_ext/hash/keys"
require "active_support/core_ext/enumerable"
require "./app/models/context"

State = Struct.new(
  :player_location_id,
  :items,
  :locations,
  :context,
  :turn_count,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.items ||= []
    self.locations ||= []
    self.context ||= ::Context.new
    self.turn_count ||= 0
  end

  def locations_by_id
    @locations_by_id ||= locations.index_by(&:id)
  end

  def items_by_id
    @items_by_id ||= items.index_by(&:id)
  end

  def children_of_item(item)
    items.select { |candidate_item| candidate_item.location_key == "items.#{item.id}"}
  end

  def items_at_player_location
    items.select { |item| item.location_key == player_location_id }
  end

  def player_location
    locations_by_id[player_location_id]
  end

  def inventory
    items.select { |item| item.location_key == "inventory" }
  end

  def to_yaml
    hash = {
      player_location_id: player_location_id,
      items: items.map(&:to_h),
      locations: locations.map(&:to_h),
      context: context.to_h,
      turn_count: turn_count,
    }.deep_stringify_keys

    hash.to_yaml
  end
end
