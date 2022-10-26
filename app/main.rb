# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

require "./app/build_initial_state"
require "./app/describe_items"
require "./app/describe_location"
require "./app/endgame"
require "./app/parse_input"
require "./app/text"

require "./app/base_execute"
Dir["./app/verb/*.rb"].each { |file| require file }

class Main
  def self.start
    @state = ::BuildInitialState.perform

    puts "Welcome to Infocom, an adventure inspired by the magical text-based games of the 1980s."
    puts "Type 'help' for instructions."

    loop do
      endgame_condition = ::Endgame.condition(@state)
      break if endgame_condition == "quit"

      puts ::DescribeLocation.perform(@state)
      puts ::DescribeItems.perform(@state)

      break if endgame_condition == "lost" || endgame_condition == "won"

      print ::Text.colorize(">", 1)
      input_text = gets.chomp
      response = parse_and_execute(input_text)
      puts ::Text.colorize(response, 0, 33) if response.present?
      @state.turn_count += 1
    end

    puts "#{::Endgame.message(@state)}\n\n"
    puts "Number of turns: #{@state.turn_count}\n\n"
  end

  # @param [String] input_text
  # @return [String (frozen)]
  def self.parse_and_execute(input_text)
    command = ::ParseInput.perform(input_text, @state)
    response = execute(command)
    @state.context.verb = command.verb
    @state.context.noun = command.noun
    response
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
