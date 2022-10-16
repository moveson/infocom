# frozen_string_literal: true

module Verb
  class Quit < ::BaseVerb
    # @return [String (frozen)]
    def execute
      state.quit = true
      ""
    end
  end
end
