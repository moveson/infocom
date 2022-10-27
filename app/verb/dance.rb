# frozen_string_literal: true

require "active_support"

require_relative "go"

module Verb
  class Dance < ::BaseExecute
    DIRECTIONS = %w[east north south west]

    # @return [String (frozen)]
    IN_PLACE_RESPONSES = [
      "The crowd goes wild!",
      "You shake your booty. Nothing happens.",
      "Nobody's watching.",
      "Broadway seems so very far away.",
      "The only Boogie Wonderland you're likely to find is in your nose.",
      "You're a bit dirty, but you can shower later.",
      "You could have danced all night, but you got bored.",
      "You aren't the dancing queen.",
      "The bugs are getting jittery.",
    ].freeze

    ELSEWHERE_RESPONSES = [
      "That's not terribly efficient, but you're the boss.",
      "Cringe. Ok, here we go.",
      "You have no tap shoes, but do your best.",
      "Sigh. The things I put up with.",
      "Ok, Michael Jackson, off you go.",
      "Walking is good. Or maybe a nice shuffle?",
    ].freeze

    private

    def noun_required?
      false
    end

    # @return [String (frozen)]
    def contextual_response
      if DIRECTIONS.include?(noun)
        go_response = Go.execute(command, state)

        go_response.presence || ELSEWHERE_RESPONSES.sample
      else
        IN_PLACE_RESPONSES.sample
      end
    end
  end
end
