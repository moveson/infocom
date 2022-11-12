# frozen_string_literal: true

require "./app/persist"

module Verb
  class Restore < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    def noun_required?
      false
    end

    # @return [String (frozen)]
    def contextual_response
      if noun.nil? || noun == "game"
        response = get_filename

        if response.present?
          if ::Persist.restore_using_filename!(state, response)
            "Game restored from filename #{response}."
          else
            "Could not restore from filename #{response}"
          end
        else
          "Returning to the game without restoring."
        end
      else
        "I don't know how to restore #{noun.articleize}."
      end
    end

    def get_filename
      available_files = ::Persist.saved_games(state)
      puts "Available games to restore are:"
      available_files.each { |filename| puts "  #{filename}" }
      puts

      response = nil

      while !available_files.include?(response) && response != "" do
        print ::Text.colorize("Which file do you want to restore? (press Return to cancel) > ", 1)
        response = gets.chomp
      end

      response
    end
  end
end
