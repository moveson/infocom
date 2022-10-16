# frozen_string_literal: true

module Verb
  class Help < ::BaseVerb
    def execute
      puts "I can understand two-word commands in plain English, like 'go west' or 'take key'."
      puts "To see what you are carrying at any time, you can type 'inventory'."
      puts "To exit the game, type 'quit'."
    end
  end
end
