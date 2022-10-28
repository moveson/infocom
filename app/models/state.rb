# frozen_string_literal: true

require "active_support/core_ext/hash/keys"
require "active_support/core_ext/enumerable"
require "./app/models/context"
require "./app/models/player"

State = Struct.new(
  :adventure,
  :player,
  :items,
  :locations,
  :characters,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.player ||= ::Player.new
    self.items ||= []
    self.locations ||= []
    self.characters ||= []
  end

  def locations_by_id
    @locations_by_id ||= locations.index_by(&:id)
  end

  def items_by_id
    @items_by_id ||= items.index_by(&:id)
  end

  def characters_by_id
    @characters_by_id ||= characters.index_by(&:id)
  end

  def children_of_item(item)
    items.select { |candidate_item| candidate_item.location_key == "items.#{item.id}"}
  end

  def items_at_player_location
    items.select { |item| item.location_key == player_location_id }
  end

  def characters_at_player_location
    characters.select { |character| character.location_key == player_location_id }
  end

  def player_location
    locations_by_id[player_location_id]
  end

  def player_location_id
    player.location_id
  end

  def player_location_id=(location_id)
    player.location_id = location_id
  end

  def inventory
    items.select { |item| item.location_key == "inventory" }
  end

  def to_yaml
    hash = {
      adventure: adventure,
      player: player.to_h,
      items: items.map(&:to_h),
      locations: locations.map(&:to_h),
      characters: characters.map(&:to_h),
    }.deep_stringify_keys

    hash.to_yaml
  end
end
