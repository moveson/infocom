# frozen_string_literal: true

require "./app/persist"

module Verb
  class Restore < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil? || noun == "game"
        print "Restore the game from what filename? "
        response = gets.chomp
        if response.present?
          if ::Persist.restore_using_filename!(state, response)
            "Game restored from filename #{response}."
          else
            "Could not restore from filename #{response}"
          end
        else
          "I can't restore a game without a filename."
        end
      else
        "I don't know how to restore #{noun.articleize}."
      end
    end
  end
end
