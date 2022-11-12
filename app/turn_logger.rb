# frozen_string_literal: true

require "fileutils"

class TurnLogger
  TURN_LOG_DIRECTORY = "./log/adventures"

  def initialize(adventure)
    filename = ::Time.now.to_i
    @adventure = adventure
    @path = "#{TURN_LOG_DIRECTORY}/#{adventure}/#{filename}.log"
    write_log_header
  end

  def log(state, description, input, command, response)
    description.gsub!(/\e\[(\d+)(;\d+)*m/, "")
    description.gsub!(/^\n/, "")

    message = <<~MSG

      Turn #{state.player.turn_count} ====================================
      #{description}
      - Player input: #{input}
      - Interpreted as:
          Verb: #{command.verb}
          Noun: #{command.noun}
          Preposition: #{command.preposition}
          Object: #{command.object}
      - Response: #{response}
    MSG

    ::File.open(path, "a") do |file|
      file.write message
    end
  end

  private

  attr_reader :adventure, :path

  def write_log_header
    ::FileUtils.mkdir_p "#{TURN_LOG_DIRECTORY}/#{adventure}"

    ::File.open(path, "a") do |file|
      file.write "#{path}\n"
      file.write "#{Time.now}\n"
    end
  end
end
