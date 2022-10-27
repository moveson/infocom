# frozen_string_literal: true

module Verb
  class Quit < ::BaseExecute
    # @return [String (frozen)]
    def execute
      contextual_response
    end

    private

    def contextual_response
      ""
    end
  end
end
