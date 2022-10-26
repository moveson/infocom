# frozen_string_literal: true

require "./app/persist"

module Verb
  class Save < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil? || noun == "game"
        print "Save the game under what filename? "
        response = gets.chomp
        if response.present?
          if ::Persist.save(state, response)
            "Game saved under filename #{response}."
          else
            "I couldn't save the game, sorry."
          end
        else
          "I can't save a game without a filename."
        end
      else
        "I don't know how to save #{noun.articleize}."
      end
    end
  end
end
