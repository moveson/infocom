# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "active_support/core_ext/object/blank"

require "./app/build_initial_state"
require "./app/describe_characters"
require "./app/describe_items"
require "./app/describe_location"
require "./app/endgame"
require "./app/parse_input"
require "./app/text"
require "./app/turn_logger"
require "./config/constants"

require "./app/base_execute"
Dir["./app/verb/*.rb"].each { |file| require file }
Dir["./config/adventures/lost_desert/verb/*.rb"].each { |file| require file }

class Main
  def self.start
    puts "Welcome to Infocom, an adventure inspired by the magical text-based games of the 1980s.\n\n"

    set_adventure
    abort "Bye\n\n" if @adventure == "quit"

    @rules = ::Rules.new(@adventure)
    @state = ::BuildInitialState.perform(@adventure)
    @turn_logger = ::TurnLogger.new(@adventure)

    puts @state.messages["welcome"]

    loop do
      location_text = ::DescribeLocation.perform(@state)
      characters_text = ::DescribeCharacters.perform(@state)
      items_text = ::DescribeItems.perform(@state)
      full_description_text = [location_text, characters_text, items_text].compact.join("\n")

      puts full_description_text
      puts

      break unless ::Endgame.condition(@state) == "in_progress"

      print ::Text.colorize("> ", 1)
      input_text = gets.chomp
      command = parse(input_text)
      response = execute(command)
      puts ::Text.colorize(response, 0, 33) if response.present?

      @state.player.turn_count += 1
      @turn_logger.log(@state, full_description_text, input_text, command, response)
      break if @state.player.quitting?
    end

    puts ::Endgame.message(@state)
  end

  def self.set_adventure
    available_adventures = Dir["#{::Constants::ADVENTURES_DIRECTORY}/*"].map { |path| path.split("/").last }
    display_adventures = available_adventures.map { |adventure| adventure.titleize }
    puts "Available adventures are:"
    display_adventures.each { |adventure_name| puts "  #{adventure_name}" }
    puts

    while !available_adventures.include?(@adventure) && @adventure != "quit" do
      print ::Text.colorize("Choose an adventure > ", 1)
      @adventure = gets.chomp.parameterize(separator: "_")
    end
  end

  # @param [String] input_text
  # @return [::Command]
  def self.parse(input_text)
    ::ParseInput.perform(input_text, @state, @rules)
  end

  # @param [::Command] command
  # @return [String (frozen)]
  def self.execute(command)
    verb = command.verb
    return "" if verb.blank?

    verb_class = class_for_verb(verb)

    if verb_class.present?
      verb_class.execute(command, @state)
    else
      "I don't know how to #{verb}."
    end
  end

  def self.class_for_verb(verb)
    "#{@adventure.classify}::Verb::#{verb.classify}".safe_constantize ||
      "::Verb::#{verb.classify}".safe_constantize
  end
end
