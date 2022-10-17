# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/hash"
require "active_support/core_ext/string/inflections"
require "yaml"

require "./app/models/item"
require "./app/models/location"

class State
  GAME_FILE_PATH = "./config/basic.yml"

  def initialize
    hash = YAML.load(File.read(GAME_FILE_PATH))
    @location_key = hash["player_location"]
    @items = hash["items"].map { |key, value| [key, item_from_raw_hash(key, value)] }.to_h
    @locations = hash["locations"].map { |key, value| [key, location_from_raw_hash(key, value)] }.to_h
  end

  attr_accessor :location_key, :lost, :quit, :won
  attr_reader :locations, :items, :inventory

  def items_at_location
    items.values.select { |item| item.location_key == location_key }
  end

  def location
    locations[location_key]
  end

  def inventory
    items.values.select { |item| item.location_key == "inventory" }
  end

  alias lost? lost
  alias quit? quit
  alias won? won

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
end
