# frozen_string_literal: true

module Verb
  class Look < ::BaseExecute
    # @return [String (frozen)]
    def execute
      state.player_location.description
    end
  end
end
