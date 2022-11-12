# frozen_string_literal: true

module Verb
  class Quit < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    def contextual_response
      state.player.quitting = true
      "Hope to see you again soon. Bye!"
    end
  end
end
