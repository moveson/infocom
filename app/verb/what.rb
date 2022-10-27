# frozen_string_literal: true

module Verb
  class What < ::BaseExecute
    RESPONSES = [
      "I'm just kind of a fake dungeon master; I don't answer questions.",
      "You'll have to figure that out on your own.",
      "I do not know. Go ask your Dad.",
      "42.",
      "I actually know the answer to that, but I like to see you suffer.",
      "You get what you pay for, which in this case is nothing.",
      "Say 'what' again! I dare you! I double dare you!",
      "Ask me no questions, I'll tell you no lies.",
      "If a picture paints a thousand words, then why can't I paint you?",
      "He who has a 'why' to live for can bear almost any 'how.'",
    ].freeze

    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    # @return [String (frozen)]
    def contextual_response
      RESPONSES.sample
    end
  end
end
