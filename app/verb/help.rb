# frozen_string_literal: true

module Verb
  class Help < ::BaseVerb
    # @return [String (frozen)]
    def execute
      <<~TEXT
        The game is simple:
        I can understand simple commands in plain English, like 'go west' or 'take the key'.
        I can also understand some more complex commands, like 'put the key in the chest'.
        I ignore certain words like 'a' and 'the', so feel free to use them or not, as you prefer.

        To see what you are carrying at any time, you can type 'inventory' or 'inv'.
        To describe your location in full, type 'look'.
        To save your progress, type 'save'.
        To restore a saved game, type 'restore'.
        To exit the game, type 'quit'.

        Enjoy!
      TEXT
    end
  end
end
