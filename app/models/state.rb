# frozen_string_literal: true

require "active_support/core_ext/hash/keys"
require "active_support/core_ext/enumerable"
require "./app/models/context"

State = Struct.new(
  :player_location_key,
  :items,
  :locations,
  :context,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.items ||= []
    self.locations ||= {}
    self.context ||= ::Context.new
  end

  def items_by_id
    @items_by_id ||= items.index_by(&:id)
  end

  def items_contained_within(item)
    items.select { |candidate_item| candidate_item.location_key == "items.#{item.id}"}
  end

  def items_at_player_location
    items.select { |item| item.location_key == player_location_key }
  end

  def player_location
    locations[player_location_key]
  end

  def inventory
    items.select { |item| item.location_key == "inventory" }
  end

  def to_yaml
    hash = {
      player_location_key: player_location_key,
      items: items.map(&:to_h),
      locations: locations.transform_values(&:to_h),
      context: context.to_h,
    }.deep_stringify_keys

    hash.to_yaml
  end
end
