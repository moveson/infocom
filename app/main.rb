# frozen_string_literal: true

require "./app/state"

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
    case verb
    when "drop"
      execute_drop(noun)
    when "go"
      execute_go(noun)
    when "get"
      execute_get(noun)
    when "help"
      execute_help
    when "inventory"
      execute_inventory
    when "look"
      execute_look
    when "quit"
      execute_quit
    when "take"
      execute_get(noun)
    else
      puts "I don't know how to #{verb}."
    end
  end

  private

  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def self.execute_drop(noun)
    if noun.nil?
      puts "What did you want to drop?"
    elsif @state.items[noun.to_sym].location_key == :inventory
      puts "You drop the #{noun}."
      @state.items[noun.to_sym].location_key = @state.location_key
    else
      puts "You aren't carrying a #{noun}."
    end
  end

  def self.execute_get(noun)
    if noun.nil?
      puts "You will need to say what you want me to get."
    elsif @state.items[noun.to_sym].nil?
      puts "I don't see a #{noun} here."
    elsif @state.items[noun.to_sym].location_key == @state.location_key
      puts "You take the #{noun}."
      @state.items[noun.to_sym].location_key = :inventory
    else
      puts "I don't see a #{noun} here."
    end
  end

  def self.execute_go(noun)
    if noun.nil?
      puts "You will need to say where you want me to go."
      return
    end

    new_location_key = @state.location.neighbors[noun.to_sym]

    if new_location_key.nil?
      puts "I can't go #{noun} from here."
    else
      @state.location_key = new_location_key.to_sym
    end
  end

  def self.execute_help
    puts "I can understand two-word commands in plain English, like 'go west' or 'take key'."
    puts "To see what you are carrying at any time, you can type 'inventory'."
  end

  def self.execute_inventory
    if @state.inventory.present?
      @state.inventory.each do |item|
        puts "You have a #{item.name.downcase}"
      end
    else
      puts "You are not carrying anything."
    end
  end

  def self.execute_look
    puts @state.location.description
  end

  def self.execute_quit
    @state.quit = true
  end
end
