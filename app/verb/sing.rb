# frozen_string_literal: true

module Verb
  class Sing < ::BaseExecute
    # @return [String (frozen)]
    RESPONSES = [
      "The nearby animals are impressed.",
      "You should keep your day job.",
      "You cheer yourself up a bit.",
      "'I am music, and I write the songs!'",
      "I can't get me no satis-venture...",
      "Your supper does not appear."
    ].freeze

    # @return [String (frozen)]
    private

    def noun_required?
      false
    end

    # @return [String (frozen)]
    def contextual_response
      RESPONSES.sample
    end
  end
end
