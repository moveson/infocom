# frozen_string_literal: true

require "fileutils"

class Persist
  SAVED_FILE_DIRECTORY = "./saved_games"

  # @param [State] state
  # @param [String] filename
  # @return [Boolean]
  def self.save(state, filename)
    FileUtils.mkdir_p(SAVED_FILE_DIRECTORY)
    path = path_from_filename(filename)

    if File.exist?(path)
      puts "File exists. Replace?"
      response = gets.chomp
      return unless response.downcase[0] == "y"
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
  # @return [State]
  def self.load(filename)
    path = path_from_filename(filename)

    ::State.new(file_path: path)
  end

  def self.path_from_filename(filename)
    "#{SAVED_FILE_DIRECTORY}/#{filename}.yml"
  end
end
