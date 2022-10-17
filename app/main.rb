# frozen_string_literal: true

require "./app/base_verb"
require "./app/endgame"
require "./app/parser"
require "./app/state"
require "./app/utilities"
Dir["./app/verb/*.rb"].each { |file| require file }

class Main
  def self.start
    @state = ::State.new

    puts "Welcome to Infocom, an adventure inspired by the magical text-based games of the 1980s."
    puts "Type 'help' if you need help."

    loop do
      break if @state.quit?

      describe_location
      describe_items

      break if @state.won? || @state.lost?

      print ::Utilities.colorize(">", 1)
      command = gets.chomp
      noun, verb = ::Parser.derive_parts(command, @state)
      response = execute(noun, verb)
      puts ::Utilities.colorize(response, 0, 33) if response.present?
      ::Endgame.set_state(@state)
    end

    ::Endgame.print_message(@state)
  end

  def self.describe_location
    puts
    puts ::Utilities.colorize(@state.location.name, 1)
    puts @state.location.description unless @state.location.described
    @state.location.described = true
  end

  def self.describe_items
    @state.items_at_location.each do |item|
      puts "You see #{item.description}"
    end
  end

  # @param [String, nil] verb
  # @param [String, nil] noun
  # @return [String (frozen)]
  def self.execute(verb, noun)
    return if verb.blank?

    verb_class = "::Verb::#{verb.titleize}".safe_constantize

    if verb_class.present?
      verb_class.execute(noun, @state)
    else
      "I don't know how to #{verb}."
    end
  end
end
