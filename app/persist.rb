# frozen_string_literal: true

require "fileutils"
require "yaml"

require "./app/models/context"
require "./app/models/character"
require "./app/models/item"
require "./app/models/location"

class Persist
  SAVED_FILE_DIRECTORY = "./saved_games"

  # @param [::State] state
  # @param [String] filename
  # @return [Boolean]
  def self.save(state, filename)
    FileUtils.mkdir_p(SAVED_FILE_DIRECTORY)
    FileUtils.mkdir_p("#{SAVED_FILE_DIRECTORY}/#{state.adventure}")
    path = path_from_filename(filename, state)

    if File.exist?(path)
      print "File exists. Replace? (y/n) "
      response = gets.chomp
      return false unless response.downcase[0] == "y"
    end

    File.open(path, "w") do |file|
      file.write(state.to_yaml)
      file.close
    end

    true
  rescue => e
    puts e
    false
  end

  # @return [Array<String>]
  def self.saved_games(state)
    paths = Dir["#{SAVED_FILE_DIRECTORY}/#{state.adventure}/*.yml"]
    paths.map { |path| path.split("/").last.split(".").first }
  end

  # @param [String] filename
  # @return [Boolean]
  def self.restore_using_filename!(state, filename)
    restore_using_file_path!(state, path_from_filename(filename, state))
  end

  # @param [::State] state
  # @param [String] file_path
  # @return [Boolean]
  def self.restore_using_file_path!(state, file_path)
    return false unless File.exist?(file_path)

    hash = ::YAML.load(File.read(file_path))
    state.adventure = hash["adventure"]
    state.player = ::Player.new(hash["player"])
    state.messages = hash["messages"]
    state.items = hash["items"].map { |item_attributes| ::Item.new(item_attributes) }
    state.locations = hash["locations"].map { |location_attributes| ::Location.new(location_attributes) }
    state.characters = hash["characters"].map { |character_attributes| ::Character.new(character_attributes) }
    true
  rescue => e
    puts e
    false
  end

  # @param [String] filename
  # @param [::State] state
  # @return [String (frozen)]
  def self.path_from_filename(filename, state)
    "#{SAVED_FILE_DIRECTORY}/#{state.adventure}/#{filename}.yml"
  end
end
