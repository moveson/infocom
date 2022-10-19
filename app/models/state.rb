# frozen_string_literal: true

require "active_support/core_ext/hash/keys"
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
    self.items ||= {}
    self.locations ||= {}
    self.context ||= ::Context.new
  end

  def items_at_player_location
    items.values.select { |item| item.location_key == player_location_key }
  end

  def player_location
    locations[player_location_key]
  end

  def inventory
    items.values.select { |item| item.location_key == "inventory" }
  end

  def to_yaml
    hash = {
      player_location_key: player_location_key,
      items: items.transform_values(&:to_h),
      locations: locations.transform_values(&:to_h),
      context: context.to_h,
    }.deep_stringify_keys

    hash.to_yaml
  end
end
