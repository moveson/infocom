# frozen_string_literal: true

module Verb
  class Look < ::BaseVerb
    # @return [String (frozen)]
    def execute
      state.location.description
    end
  end
end
