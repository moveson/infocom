# frozen_string_literal: true

module Verb
  class Sing < ::BaseVerb
    # @return [String (frozen)]
    def execute
      [
        "The nearby animals are impressed.",
        "You should keep your day job.",
        "You cheer yourself up a bit.",
        "'I am music, and I write the songs!'",
        "I can't get me no satis-venture...",
        "Your supper does not appear."
      ].sample
    end
  end
end
