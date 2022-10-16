# frozen_string_literal: true

module Verb
  class Quit < ::BaseVerb
    def execute
      state.quit = true
    end
  end
end
