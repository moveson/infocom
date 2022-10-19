# frozen_string_literal: true

require "fileutils"
require "yaml"

require "./app/models/context"
require "./app/models/item"
require "./app/models/location"

class Persist
  SAVED_FILE_DIRECTORY = "./saved_games"

  # @param [State] state
  # @param [String] filename
  # @return [Boolean]
  def self.save(state, filename)
    FileUtils.mkdir_p(SAVED_FILE_DIRECTORY)
    path = path_from_filename(filename)

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

  # @param [String] filename
  # @return [Boolean]
  def self.restore_using_filename!(state, filename)
    restore_using_file_path!(state, path_from_filename(filename))
  end

  # @param [State] state
  # @param [String] file_path
  # @return [Boolean]
  def self.restore_using_file_path!(state, file_path)
    return false unless File.exist?(file_path)

    hash = ::YAML.load(File.read(file_path))
    state.player_location_key = hash["player_location_key"]
    state.items = hash["items"].transform_values { |value| ::Item.new(value) }
    state.locations = hash["locations"].transform_values { |value| ::Location.new(value) }
    state.context = ::Context.new(hash["context"] || {})
    true
  rescue => e
    puts e
    false
  end

  # @param [String] filename
  # @return [String (frozen)]
  def self.path_from_filename(filename)
    "#{SAVED_FILE_DIRECTORY}/#{filename}.yml"
  end
end
