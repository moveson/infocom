# frozen_string_literal: true

require "active_support"

require_relative "go"

module Verb
  class Dance < ::BaseVerb
    # @return [String (frozen)]
    DANCE_IN_PLACE_RESPONSES = [
      "The crowd goes wild!",
      "You shake your booty. Nothing happens.",
      "Nobody's watching.",
      "Broadway seems so very far away.",
      "The only Boogie Wonderland you're likely to find is in your nose.",
      "You're a bit dirty, but you can shower later.",
    ]

    DANCE_ELSEWHERE_RESPONSES = [
      "That's not terribly efficient, but you're the boss.",
      "Cringe. Ok, here we go.",
      "You have no tap shoes, but do your best.",
      "Sigh. The things I put up with.",
      "Ok, Michael Jackson, off you go.",
    ]

    def execute
      if noun.in?(%w[east west north south])
        go_response = Go.execute(grammar, state)

        go_response.presence || DANCE_ELSEWHERE_RESPONSES.sample
      else
        DANCE_IN_PLACE_RESPONSES.sample
      end
    end
  end
end
