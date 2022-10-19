# frozen_string_literal: true

require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"
require "yaml"

require "./app/models/item"
require "./app/models/location"

class State
  START_GAME_FILE_PATH = "./config/basic.yml"

  def initialize(file_path: START_GAME_FILE_PATH)
    hash = YAML.load(File.read(file_path))
    @location_key = hash["player_location"]
    @items = hash["items"].map { |key, value| [key, item_from_raw_hash(key, value)] }.to_h
    @locations = hash["locations"].map { |key, value| [key, location_from_raw_hash(key, value)] }.to_h
    initialize_endgame_booleans
  end

  attr_reader :locations, :items
  attr_accessor :location_key, :lost, :quit, :won

  alias lost? lost
  alias quit? quit
  alias won? won

  def items_at_location
    items.values.select { |item| item.location_key == location_key }
  end

  def location
    locations[location_key]
  end

  def inventory
    items.values.select { |item| item.location_key == "inventory" }
  end

  def to_yaml
    hash = {
      player_location: location_key,
      items: items.transform_values(&:to_h),
      locations: locations.transform_values(&:to_h),
    }.deep_stringify_keys

    hash.to_yaml
  end

  private

  def item_from_raw_hash(key, value)
    item = ::Item.new(value)
    item.name = key.titleize
    item
  end

  def location_from_raw_hash(key, value)
    location = ::Location.new(value)
    location.neighbors ||= {}
    location.name = key.titleize
    location
  end

  def initialize_endgame_booleans
    @lost = false
    @quit = false
    @won = false
  end
end
