# frozen_string_literal: true

module Verb
  class Help < ::BaseVerb
    # @return [String (frozen)]
    def execute
      <<~TEXT
        I can understand two-word commands in plain English, like 'go west' or 'take key'.
        To see what you are carrying at any time, you can type 'inventory'.
        To describe your location in full, type 'look'.
        To exit the game, type 'quit'.
      TEXT
    end
  end
end
