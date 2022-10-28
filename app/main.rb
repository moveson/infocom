# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

require "./app/build_initial_state"
require "./app/describe_characters"
require "./app/describe_items"
require "./app/describe_location"
require "./app/endgame"
require "./app/parse_input"
require "./app/text"
require "./config/constants"

require "./app/base_execute"
Dir["./app/verb/*.rb"].each { |file| require file }

class Main
  def self.start
    puts "Welcome to Infocom, an adventure inspired by the magical text-based games of the 1980s.\n\n"

    set_adventure
    abort "Bye\n\n" if @adventure == "quit"

    @rules = ::Rules.new(@adventure)
    @state = ::BuildInitialState.perform(@adventure)

    puts "Type 'help' for instructions."

    loop do
      endgame_condition = ::Endgame.condition(@state)
      break if endgame_condition == "quit"

      location_text = ::DescribeLocation.perform(@state)
      characters_text = ::DescribeCharacters.perform(@state)
      items_text = ::DescribeItems.perform(@state)

      puts location_text if location_text.present?
      puts characters_text if characters_text.present?
      puts items_text if items_text.present?
      puts

      break if endgame_condition == "died" || endgame_condition == "won"

      print ::Text.colorize("> ", 1)
      input_text = gets.chomp
      response = parse_and_execute(input_text)
      puts ::Text.colorize(response, 0, 33) if response.present?
      @state.player.turn_count += 1
    end

    puts "#{::Endgame.message(@state)}\n\n"
    puts "Number of turns: #{@state.player.turn_count}\n\n"
  end

  def self.set_adventure
    available_adventures = Dir["#{::Constants::ADVENTURES_DIRECTORY}/*"].map { |path| path.split("/").last }
    puts "Available adventures are:"
    available_adventures.each { |adventure_name| puts "  #{adventure_name}" }
    puts

    while !available_adventures.include?(@adventure) && @adventure != "quit" do
      print ::Text.colorize("Choose an adventure > ", 1)
      @adventure = gets.chomp
    end
  end

  # @param [String] input_text
  # @return [String (frozen)]
  def self.parse_and_execute(input_text)
    command = ::ParseInput.perform(input_text, @state, @rules)
    execute(command)
  end

  # @param [::Command] command
  # @return [String (frozen)]
  def self.execute(command)
    verb = command.verb
    return "" if verb.blank?

    verb_class = "::Verb::#{verb.classify}".safe_constantize

    if verb_class.present?
      verb_class.execute(command, @state)
    else
      "I don't know how to #{verb}."
    end
  end
end
