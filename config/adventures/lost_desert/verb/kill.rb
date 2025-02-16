module LostDesert
  module Verb
    class Kill < ::Verb::Kill

      # @return [String (frozen), nil]
      def contextual_response
        if subject_character && subject_character.id == "cobra"
          state.player.health = 0

          "You are about to strike, but the cobra is too fast. It lunges and bites you with venomous fangs."
        else
          super
        end
      end
    end
  end
end
