# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

require "./app/build_initial_state"
require "./app/endgame"
require "./app/parser"
require "./app/text"

require "./app/base_verb"
Dir["./app/verb/*.rb"].each { |file| require file }

class Main
  def self.start
    @state = ::BuildInitialState.perform

    puts "Welcome to Infocom, an adventure inspired by the magical text-based games of the 1980s."
    puts "Type 'help' if you need help."

    loop do
      endgame_condition = ::Endgame.condition(@state)
      break if endgame_condition == "quit"

      describe_location
      describe_items

      break if endgame_condition == "lost" || endgame_condition == "won"

      print ::Text.colorize(">", 1)
      command = gets.chomp
      response = parse_and_execute(command)
      puts ::Text.colorize(response, 0, 33) if response.present?
    end

    puts "#{::Endgame.message(@state)}\n\n"
  end

  def self.describe_location
    puts
    puts ::Text.colorize(@state.player_location.name, 1)
    puts @state.player_location.description unless @state.player_location.described
    @state.player_location.described = true
  end

  def self.describe_items
    @state.items_at_player_location.each do |item|
      puts "You see #{item.description}"
    end
  end

  # @param [String] command
  # @return [String (frozen)]
  def self.parse_and_execute(command)
    grammar = ::Parser.derive_parts(command, @state)
    response = execute(grammar)
    @state.context.verb = grammar.verb
    @state.context.noun = grammar.noun
    response
  end

  # @param [::Grammar] grammar
  # @return [String (frozen)]
  def self.execute(grammar)
    verb = grammar.verb
    return "" if verb.blank?

    verb_class = "::Verb::#{verb.classify}".safe_constantize

    if verb_class.present?
      verb_class.execute(grammar, @state)
    else
      "I don't know how to #{verb}."
    end
  end
end
