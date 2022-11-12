# frozen_string_literal: true

module Verb
  class Quit < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    # @return [String (frozen)]
    def contextual_response
      if noun.nil? || noun == "game"
        print "Are you sure you want to quit? "
        response = gets.chomp
        if response.present? && response.downcase.start_with?("y")
          state.player.quitting = true
          "Hope to see you again soon. Bye!"
        else
          "Back to the game then."
        end
      else
        "I don't know how to quit #{noun.articleize}."
      end
    end
  end
end
