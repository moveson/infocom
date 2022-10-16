# frozen_string_literal: true

require "./app/base_verb"
require "./app/state"
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

      break unless @state.in_progress?

      print colorize(">", 1)
      command = gets.chomp
      noun, verb = parse(command)
      execute(noun, verb)
    end

    if @state.won?
      puts "You made it to the hill with the sword. Congratulations, you won!"
    elsif @state.quit?
      puts "Hope to see you again soon. Bye!"
    else
      puts "Sorry, you lost."
    end

    puts
  end

  def self.describe_location
    puts
    puts colorize(@state.location.name, 1)
    puts @state.location.description unless @state.location.described
    @state.location.described = true
  end

  def self.describe_items
    @state.items_at_location.each do |item|
      puts "You see #{item.description}"
    end
  end

  def self.parse(command)
    command.split
  end

  def self.execute(verb, noun)
    if (verb_class = "::Verb::#{verb.titleize}".safe_constantize)
      verb_class.execute(noun, @state)
    else
      puts "I don't know how to #{verb}."
    end
  end

  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
end
