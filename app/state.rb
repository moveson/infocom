# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/hash"
require "active_support/core_ext/string/inflections"
require "yaml"

require "./app/models/item"
require "./app/models/location"

class State
  GAME_FILE_PATH = "./config/basic.yml"

  # @param [Symbol] location_key
  def initialize(location_key: :quiet_meadow)
    @location_key = location_key
    initialize_game
  end

  attr_accessor :location_key, :quit
  attr_reader :locations, :items, :inventory

  def initialize_game
    hash = YAML.load(File.read(GAME_FILE_PATH))
    @items = hash["items"].map { |key, value| [key.to_sym, item_from_raw_hash(key, value)] }.to_h
    @locations = hash["locations"].map { |key, value| [key.to_sym, location_from_raw_hash(key, value)] }.to_h
  end

  def items_at_location
    items.values.select { |item| item.location_key == location_key }
  end

  def location
    locations[location_key]
  end

  def inventory
    items.values.select { |item| item.location_key == :inventory }
  end

  def lost?
    location_key == :deadly_pit
  end

  alias quit? quit

  def won?
    location_key == :sunlit_hill && items[:sword].location_key == :inventory
  end

  private

  def item_from_raw_hash(key, value)
    item = ::Item.new(value)
    item.location_key = value["location_key"].to_sym
    item.name = key.titleize
    item
  end

  def location_from_raw_hash(key, value)
    location = ::Location.new(value)
    location.neighbors = value["neighbors"]&.symbolize_keys || {}
    location.name = key.titleize
    location
  end
end
